FROM debian:bullseye-slim

USER root

# Installing dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg lsb-release apt-transport-https software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Adding oficial HashiCorp Vault repo, update and install
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install -y vault && \
    rm -rf /var/lib/apt/lists/*

# Get the version of argocd-vault-plugin from build args
ARG AVP_VERSION=1.16.1
ENV AVP_VERSION=${AVP_VERSION}

# Installing argocd-vault-plugin
ENV BIN=argocd-vault-plugin
RUN curl -L -o ${BIN} https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${AVP_VERSION}/argocd-vault-plugin_${AVP_VERSION}_linux_amd64 && \
    chmod +x ${BIN} && \
    mv ${BIN} /usr/local/bin

USER 999
