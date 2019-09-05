FROM fedora-updated

# https://cloud.google.com/sdk/docs/quickstart-redhat-centos
COPY google-cloud-sdk.repo /etc/yum.repos.d/google-cloud-sdk.repo
RUN yum install -y google-cloud-sdk

# TODO how to initialize using an ENV variable instead of interactive?
# RUN gcloud init --console-only
