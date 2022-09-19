FROM gitpod/workspace-full:2022-08-17-18-37-55

# install full gcloud cli
RUN sudo apt-get install -y apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg
RUN sudo apt-get update && sudo apt-get install google-cloud-cli

# install gcloud components
RUN sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

# install pulumi
ENV PULUMI_VERSION="3.40.0"
RUN curl -fsSL https://get.pulumi.com | sh -s -- --version $PULUMI_VERSION
ENV PATH="${PATH}:/home/gitpod/.pulumi/bin"

# install kubectl
# ENV KUBECTL_VERSION="1.24.3"
RUN brew install kubectl

# install skaffold
ENV SKAFFOLD_VERSION="v2.0.0-beta1"
RUN curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/$SKAFFOLD_VERSION/skaffold-linux-amd64 && chmod +x skaffold && sudo mv skaffold /usr/local/bin

# install k9s
# ENV K9S_VERSION="0.26.3"
RUN brew install k9s

ENV TERRAFORM_VERSION=1.2.9
ENV TERRAFORM_VERSION_SHA256SUM=0e0fc38641addac17103122e1953a9afad764a90e74daf4ff8ceeba4e362f2fb
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN echo "${TERRAFORM_VERSION_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > checksum && sha256sum -c checksum
RUN mkdir .terraform && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d .terraform/bin
ENV PATH="${PATH}:/home/gitpod/.terraform/bin"
