# Google Cloud CLI client (`gcloud`)

    docker run -it --rm gcloud

    docker run --rm gcloud gcloud version

Now create a _Service Account_ on https://console.cloud.google.com/iam-admin/serviceaccounts :

1. on Menu _IAM & admin -> Service accounts_
1. click _Create Service Account_
1. as _Service Account Name_ use e.g. `deployer`
1. click _Create_
1. grant _Service account permissions_, as required; e.g. _Cloud Run Admin_ and/or _Compute Admin_
1. skip _Grant users access to this service account_
1. click _Create key_, choose _JSON_ as _Key Type_
1. copy the new service account's _Email_

You also have to enable the APIs you'd like to use on the respective project once;
e.g. by visiting the Compute Engine > VM Instances once in the UI, clicking, and
waiting a minute to get ready.  You now can e..g do:  (_TODO simplify this..._)

    docker run --rm --mount=type=bind,source=token/,destination=/tmp,z gcloud bash -c "gcloud config set project vorburger && gcloud auth activate-service-account deployer@vorburger.iam.gserviceaccount.com --key-file=/tmp/demo-68c9bbc9c5f1.json && gcloud compute zones list"


_TODO docker run -v local-project:container-dir gcloud gcloud deployment-manager ???_
