# Google Cloud CLI client (`gcloud`)

Use it interactively:

    docker run -it --rm gcloud

Launch built-in commands directly from the CLI:

    docker run --rm gcloud gcloud version
    docker run --rm gcloud kubectl version

Now create a _Service Account_ on https://console.cloud.google.com/iam-admin/serviceaccounts :

1. on Menu _IAM & admin -> Service accounts_
1. click _Create Service Account_
1. as _Service Account Name_ use e.g. `deployer`
1. click _Create_
1. grant _Service account permissions_, as required; e.g. _Deployment Manager Editor_, _Cloud Run Admin_ and/or _Compute Admin_
1. skip _Grant users access to this service account_
1. click _Create key_, choose _JSON_ as _Key Type_
1. copy the new service account's _Email_

You also have to enable the APIs you'd like to use on the respective project once;
e.g. by visiting the Compute Engine > VM Instances once in the UI, clicking, and
waiting a minute to get ready.  You now can e.g do:

    docker run --rm --mount=type=bind,source=token/,destination=/tmp,z gcloud bash -c "gcloud --project YOURPROJECT auth activate-service-account YOURSERVICEACCOUNT@YOURPROJECT.iam.gserviceaccount.com --key-file=/tmp/YOURKEY.json && gcloud compute zones list"

Using https://cloud.google.com/deployment-manager/docs/quickstart :

    docker run --rm --mount=type=bind,source=test/,destination=/tmp,z gcloud bash -c "gcloud --project YOURPROJECT auth activate-service-account YOURSERVICEACCOUNT@YOURPROJECT.iam.gserviceaccount.com --key-file=/tmp/YOURKEY.json && gcloud deployment-manager deployments create quickstart-deployment --config /tmp/sample-deploy.yaml"

_TODO The built-in [`deploy`](deploy) script for
[Google Cloud Deployment Manager](https://cloud.google.com/deployment-manager/) can be used like this:_
