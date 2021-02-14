#!/usr/bin/env bash

set -e

# shellcheck source=functions.sh
. "$(dirname "$0")/functions.sh"

usage() {
    echo "usage: entrypoint.sh <app-deploy|app-delete>"
}

config() {
    export ARGOCD_SERVER=${ARGOCD_SERVER:-$INPUT_SERVER}
    export ARGOCD_OPTS=${ARGOCD_OPTS:-$INPUT_OPTS}
    export ARGOCD_AUTH_TOKEN=${ARGOCD_AUTH_TOKEN:-$INPUT_AUTHTOKEN}
    env
}

main() {
    echo "hipages ArgoCD Wrapper by Enrico Stahn."
    echo ""

    # Configure environment variables for ArgoCD CLI
    config

    case "$1" in
        '' | '-h' | '--help') usage && exit 0;;
        'app-delete') argocd_app_delete "$2" && exit 0;;
        'app-deploy') argocd_app_deploy "$2" && exit 0;;
         *) argocd "$@"
            ;;
    esac
}

main "$@"
