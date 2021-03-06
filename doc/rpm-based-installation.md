# RPM-based installation

The following instruction are meant to be "copy-and-paste" to install and demonstrate.
These instructions have been tested with CentOS 7.2.

## Overview

1. [Install prerequisites](#prerequisites)
1. [Set environment variables](#set-environment-variables)
1. [Clone repository](#clone-repository)
1. [Install Senzing](#install-senzing)
1. [Build service](#build-service)
1. [Run service](#run-service)
1. [Clean up](#clean-up)

## Prerequisites

These programs will be used in the installation and demonstration of Senzing.
They need to be installed first.

```console
sudo yum install -y epel-release

sudo yum -y install \
  curl \
  git \
  jq \
  maven \
  sqlite
```

A Java Development Kit (JDK) will be needed.
Determine if a JDK is installed. Example:

```console
$ javac -version
javac 1.8.0_181
```

If a JDK is not installed, you can install with the following command:

```console
sudo yum -y install \
  java-1.8.0-openjdk-devel  
```

## Set Environment variables

These variables may be modified, but do not need to be modified.
The variables are used throughout the installation procedure.

```console
export GIT_ACCOUNT_DIR=~/docktermj.git
export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/hello-senzing-springboot-java"
export GIT_REPOSITORY_URL="https://github.com/docktermj/hello-senzing-springboot-java.git"
export SENZING_DIR=/opt/senzing
export LD_LIBRARY_PATH=${SENZING_DIR}/g2/lib:$LD_LIBRARY_PATH
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
mkdir --parents ${GIT_ACCOUNT_DIR}
cd  ${GIT_ACCOUNT_DIR}
git clone ${GIT_REPOSITORY_URL}
```

## Install Senzing

1. Download [Senzing_API.tgz](https://s3.amazonaws.com/public-read-access/SenzingComDownloads/Senzing_API.tgz).

    ```console
    curl -X GET \
      --output ${GIT_REPOSITORY_DIR}/Senzing_API.tgz \
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
      --file=${GIT_REPOSITORY_DIR}/Senzing_API.tgz
    ```

1. Change permissions for database.

    ```console
    sudo chmod -R 777 ${SENZING_DIR}/g2/sqldb
    ````

1. Copy jar file into maven repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    mvn install:install-file \
      -Dfile=${SENZING_DIR}/g2/lib/g2.jar \
      -DgroupId=com.senzing \
      -DartifactId=g2 \
      -Dversion=1.0.0-SNAPSHOT \
      -Dpackaging=jar
    ```

## Build Service

1. Build JAR file.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    mvn package
    ```

## Run Service

1. Open port 8080

    ```console
    sudo firewall-cmd --permanent --add-port=8080/tcp
    sudo firewall-cmd --reload
    ```
1. Run demo service.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    java -jar target/senzing-demo-0.0.1-SNAPSHOT.jar
    ```

1. [Test the service](../README.md#test).

## Clean up

After the demonstration is complete,
you may want to remove all files used in the demonstration.

1. Remove all files.

    ```console
    sudo rm -rf ${SENZING_DIR}
    rm -rf ${GIT_REPOSITORY_DIR}
    ```
