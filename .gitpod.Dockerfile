FROM gitpod/workspace-full:2022-08-17-18-37-55

# install full gcloud cli
RUN sudo apt-get install -y apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg
RUN sudo apt-get update && sudo apt-get install google-cloud-cli

# install gcloud components
RUN sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

# install pulumi
ENV PULUMI_VERSION="3.38.0"
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