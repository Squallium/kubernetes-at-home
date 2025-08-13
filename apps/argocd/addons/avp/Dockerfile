FROM registry.access.redhat.com/ubi8

USER root

RUN microdnf install -y curl awscli gpg && \
    microdnf clean all

# ARG para pasar la versión en build
ARG AVP_VERSION=1.16.1
ENV AVP_VERSION=${AVP_VERSION}

ENV BIN=argocd-vault-plugin
RUN curl -L -o ${BIN} https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${AVP_VERSION}/argocd-vault-plugin_${AVP_VERSION}_linux_amd64 && \
    chmod +x ${BIN} && \
    mv ${BIN} /usr/local/bin

USER 999
