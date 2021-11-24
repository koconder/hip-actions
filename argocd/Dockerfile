FROM debian:buster-slim

LABEL "com.github.actions.name"="GitHub Action for ArgoCD"
LABEL "com.github.actions.description"="Wraps the ArgoCD CLI to enable common ArgoCD commands."
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="https://github.com/hipages/argocd-actions"
LABEL "homepage"="https://github.com/hipages/argocd-actions"

RUN apt-get update && apt-get install -y ca-certificates jq

ADD https://github.com/argoproj/argo-cd/releases/download/v2.0.0/argocd-linux-amd64 /usr/local/bin/argocd

RUN chmod 755 /usr/local/bin/argocd

COPY functions.sh /
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
