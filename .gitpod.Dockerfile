FROM gitpod/workspace-full:2022-08-17-18-37-55

# install full gcloud cli
RUN sudo apt-get install -y apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg
RUN sudo apt-get update && sudo apt-get install google-cloud-cli

# install pulumi
RUN curl -fsSL https://get.pulumi.com | sh
ENV PATH="${PATH}:/home/gitpod/.pulumi/bin"
