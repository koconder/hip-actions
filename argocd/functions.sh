#!/usr/bin/env bash

argocd_app_delete() {
    generate_manifest "$1"
    if [ $? -ne 0 ]; then
        echo "Manifest generation failed."
        exit 1
    fi

    app=$(oq -r -i yaml .metadata.name .argocd.yml.dist)
    echo "Application name \"$app\" extracted from manifest"

    echo "Delete application \"$app\" from ArgoCD"

    argocd app delete "$app"
}

argocd_app_deploy() {

    echo "Current ArgoCD file is:"
    cat $INPUT_MANIFEST_FILE

    app=$(oq -r -i yaml .metadata.name $INPUT_MANIFEST_FILE)
    echo "Application name \"$app\" extracted from manifest"
    
    argocd app create -f $INPUT_MANIFEST_FILE --upsert || exit 1

    url=$(argocd app get "$app" -o json | jq -r '.status.summary.externalURLs[0]')

    echo "::set-output name=externalURL::$url"

    echo "App created. Waiting for status to be ready..."
    argocd app wait "$app" --timeout ${ARGOCD_TIMEOUT:-240} || exit 1
}

