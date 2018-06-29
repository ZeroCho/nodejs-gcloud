FROM gcr.io/google_appengine/nodejs

MAINTAINER zerocho

ENV GCLOUD_DOWNLOAD_URL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-207.0.0-linux-x86_64.tar.gz

ENV DEBIAN-FRONTEND noninteractive
RUN apt-get update

RUN apt-get install -y python2.7 python-pip
RUN npm install -g npm
RUN export CLOUDSDK_PYTHON=$(which python)

# Google Cloud SDK installation
RUN curl ${GCLOUD_DOWNLOAD_URL} > /tmp/gcloud.tar.gz
RUN tar xzf /tmp/gcloud.tar.gz --directory /opt
RUN rm /tmp/gcloud.tar.gz

RUN /opt/google-cloud-sdk/install.sh \
    --usage-reporting=true \
    --path-update=true \
    --bash-completion=true \
    --rc-path=/etc/profile.d/gcloud.sh

RUN /opt/google-cloud-sdk/bin/gcloud components update

# This is a temporary workaround to make gcloud binaries to be avaliable in PATH environment variable
RUN ln -s /opt/google-cloud-sdk/bin/* /usr/local/bin
