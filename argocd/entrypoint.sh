#!/usr/bin/env bash

set -e

source './functions.sh'

usage() {
    echo "usage: entrypoint.sh <app-deploy|app-delete>"
}

main() {
    echo "hipages ArgoCD Wrapper by Enrico Stahn."
    echo ""

    case "$1" in
        '' | '-h' | '--help') usage && exit 0;;
        'app-delete') argocd_app_delete "$2" && exit 0;;
        'app-deploy') argocd_app_deploy "$2" && exit 0;;
         *) argocd "$@"
            ;;
    esac
}

main "$@"
