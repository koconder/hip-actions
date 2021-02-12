#!/usr/bin/env bash

argocd_app_delete() {
    generate_manifest "$1"
    if [ $? -eq 1 ]; then
        echo "Manifest generation failed."
        exit 1
    fi

    app=$(oq -r -i yaml .metadata.name .argocd.yml.dist)
    echo "Application name \"$app\" extracted from manifest"

    echo "Delete application \"$app\" from ArgoCD"

    argocd app delete "$app"
}

argocd_app_deploy() {
    generate_manifest "$1"
    if [ $? -eq 1 ]; then
        echo "Manifest generation failed."
        exit 1
    fi

    app=$(oq -r -i yaml .metadata.name .argocd.yml.dist)
    echo "Application name \"$app\" extracted from manifest"

    argocd app create -f .argocd.yml.dist --upsert

    # Populate external URL to be used for GitHub Environment
    url=$(argocd app get "$app" -o json | jq -r '.status.summary.externalURLs[0]')

    echo "::set-output name=app::$app"
    echo "::set-output name=externalURL::$url"

    argocd app wait "$app" --timeout 240
}

# TODO: use glob to process multiple argocd files
# generate_manifest creates the ArgoCD application manifest that is being submitted to ArgoCD.
generate_manifest() {
    local manifest=${1:-.argocd.yml}
    local ref
    local branch
    local repo

    if [ ! -f "$manifest" ]; then
        echo "ArgoCD application manifest \"$manifest\" not found."
        return 1
    fi

    echo "Generate ArgoCD application manifest from \"$manifest\""

    # Inject helper scripts into the manifest
    cat gomplate-helper.tpl "$manifest" > "$manifest.predist"

    # Read workflow details from event file
    ref=$(jq -r .ref "$GITHUB_EVENT_PATH")
    branch=${ref#refs/heads/}
    repo=$(jq -r .repository.name "$GITHUB_EVENT_PATH")

    APP_NAME=$(generate_app_name "${GIT_REPONAME:-$repo}" "${GIT_BRANCH:-$branch}") \
    GIT_REPONAME=${GIT_REPONAME:-$repo} \
    GIT_REF=${GIT_REF:-$ref} \
    GIT_BRANCH=${GIT_BRANCH:-$branch} \
        gomplate -f "$manifest.predist" -o "$manifest".dist
}

# generate_app_name generates an ArgoCD application name based on git information.
generate_app_name() {
    if [ -n "$APP_NAME" ]; then
        echo "$APP_NAME"
        return 0
    fi

    local repo=$1
    local branch=$2
    read -r -d '' template <<'EOF'
{{- $release := printf "%s-%s" (getenv "GIT_REPONAME" | strings.Slug) (getenv "GIT_BRANCH" | strings.Slug) -}}
{{- $app     := gt (len $release) 53 | ternary (printf "%s-%s" (getenv "GIT_REPONAME" | strings.Slug) (getenv "GIT_BRANCH" | crypto.SHA1 | strings.Trunc 7)) $release -}}
{{- $app -}}{{- getenv "APP_SUFFIX" -}}
EOF

    APP_SUFFIX=$APP_SUFFIX GIT_REPONAME=$repo GIT_BRANCH=$branch gomplate -i "$template"
}
