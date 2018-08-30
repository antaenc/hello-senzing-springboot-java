# Debian-based installation

The following instruction are meant to be "copy-and-paste" to install and demonstrate.

## Overview

1. [Install prerequisites](#prerequisites)
1. [Set environment variables](#set-environment-variables)
1. [Clone repository](#clone-repository)
1. [Install Senzing](#install-senzing)
1. [Build demo](#build-demo)
1. [Run demo](#run-demo)

## Prerequisites

These programs will be used in the installation and demonstration of Senzing.
They need to be installed first.

```console
sudo apt-get -y install \
  git-core \
  maven \
  sqlite \
  wget
```

A Java Development Kit (JDK) will be needed.
Determine if a JDK is installed. Example:

```console
$ javac -version
javac 1.8.0_181
```

If a JDK is not installed, you can install with the following command:

```console
sudo apt-get -y install \
  openjdk-8-jdk-headless
```

## Set Environment variables

These variables may be modified, but do not need to be modified.
The variables are used throughout the installation procedure.

```console
export PROJECT_DIR=~/docktermj.git
export REPOSITORY_DIR="${PROJECT_DIR}/hello-senzing-springboot-java"
export GIT_REPOSITORY_URL="https://github.com/docktermj/hello-senzing-springboot-java.git"
export SENZING_DIR=/opt/senzing
export LD_LIBRARY_PATH=${SENZING_DIR}/g2/lib:${SENZING_DIR}/g2/lib/debian:$LD_LIBRARY_PATH
```

1. If not set, export `JAVA_HOME`.

    ```console
    if [ -z "${JAVA_HOME}" ]; \
      then export JAVA_HOME=$(readlink -nf $(which java) | xargs dirname | xargs dirname | xargs dirname); \
    fi
    ```

## Clone repository

Get repository.

```console
mkdir --parents ${PROJECT_DIR}
cd  ${PROJECT_DIR}
git clone ${GIT_REPOSITORY_URL}
```

## Install Senzing

1. Download [Senzing_API.tgz](https://s3.amazonaws.com/public-read-access/SenzingComDownloads/Senzing_API.tgz).

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
      --owner=root \
      --group=root \
      --no-same-owner \
      --no-same-permissions \
      --directory=${SENZING_DIR} \
      --file=${REPOSITORY_DIR}/Senzing_API.tgz
    ```

1. Change permissions for database.

    ```console
    sudo chmod -R 777 ${SENZING_DIR}/g2/sqldb
    ````

1. Copy jar file into maven repository.

    ```console
    cd ${REPOSITORY_DIR}
    mvn install:install-file \
      -Dfile=${SENZING_DIR}/g2/lib/g2.jar \
      -DgroupId=com.senzing \
      -DartifactId=g2 \
      -Dversion=1.0.0-SNAPSHOT \
      -Dpackaging=jar
    ```

## Build Demo

1. Build JAR file.

    ```console
    cd ${REPOSITORY_DIR}
    mvn package
    ```

## Run Demo

1. Run demo.

    ```console
    cd ${REPOSITORY_DIR}
    java -jar target/senzing-demo-0.0.1-SNAPSHOT.jar
    ```
