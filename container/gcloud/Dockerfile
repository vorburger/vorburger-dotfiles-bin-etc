FROM fedora-updated

# https://cloud.google.com/sdk/docs/quickstart-redhat-centos
COPY google-cloud-sdk.repo /etc/yum.repos.d/google-cloud-sdk.repo

RUN yum makecache -y \
 && yum install -y kubectl google-cloud-sdk google-cloud-sdk-cloud-build-local

# cannot: gcloud components install cloud_sql_proxy
# TODO nok: RUN yum install -y google-cloud-sdk-cloud_sql_proxy

# cannot: gcloud components install docker-credential-gcr
# TODO nok: RUN yum install -y google-cloud-sdk-docker-credential-gcr

RUN gcloud version

CMD gcloud beta interactive
