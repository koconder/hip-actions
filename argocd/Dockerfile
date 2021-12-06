FROM debian:buster-slim

LABEL "com.github.actions.name"="GitHub Action for ArgoCD"
LABEL "com.github.actions.description"="Wraps the ArgoCD CLI to enable common ArgoCD commands."
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="https://github.com/hipages/argocd-actions"
LABEL "homepage"="https://github.com/hipages/argocd-actions"

RUN apt-get update && apt-get install -y ca-certificates jq

ADD https://github.com/argoproj/argo-cd/releases/download/v2.0.0/argocd-linux-amd64 /usr/local/bin/argocd
ADD https://github.com/Blacksmoke16/oq/releases/download/v0.2.1/oq-0.2.1-linux-x86_64 /usr/local/bin/oq

RUN chmod 755 /usr/local/bin/argocd /usr/local/bin/oq

COPY functions.sh /
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
