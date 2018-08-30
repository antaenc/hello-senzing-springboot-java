# Debian-based installation

## Pre-requisites

```console
sudo apt-get -y install \
  git-core \
  maven \
  wget
```

## Set Environment variables

These variables may be modified, but do not need to be modified.
The variables are used throughout the installation procedure.

```console
export PROJECT_DIR=~/docktermj.git
export REPOSITORY_DIR="${PROJECT_DIR}/senzing-demo-1"
export GIT_REPOSITORY_URL="https://github.com/docktermj/senzing-demo-1.git"
export SENZING_DIR=/opt/senzing
```

## Clone repository

Get repository.

```console
mkdir --parents ${PROJECT_DIR}
cd  ${PROJECT_DIR}
git clone ${GIT_REPOSITORY_URL}
```

## Install Senzing_API.tgz

1. Download [Senzing_API.tgz](https://s3.amazonaws.com/public-read-access/SenzingComDownloads/Senzing_API.tgz)

    ```console
    wget \
      --show-progress \
      --output-document ${REPOSITORY_DIR}/Senzing_API.tgz \
      https://s3.amazonaws.com/public-read-access/SenzingComDownloads/Senzing_API.tgz
    ```

1. Create directory for Senzing.

    ```console
    sudo mkdir ${SENZING_DIR}
    ```

1. Uncompress `Senzing_API.tgz` into Senzing directory.

    ```console
    sudo tar \
      --extract \
      --verbose \
      --directory=${SENZING_DIR} \
      --file=${REPOSITORY_DIR}/Senzing_API.tgz
    ```

## Run Demo

1. If not set, export `JAVA_HOME`.

    ```console
    if [ -z "${JAVA_HOME}" ]; \
      then export JAVA_HOME=$(readlink -nf $(which java) | xargs dirname | xargs dirname | xargs dirname); \
    fi
    ```

1. Run demo

    ```console
    cd ${REPOSITORY_DIR}
    ./mvnw
    ```