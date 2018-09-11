# Debian-based installation

The following instruction are meant to be "copy-and-paste" to install and demonstrate.

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
sudo apt-get -y install \
  curl \
  git-core \
  jq \
  maven \
  sqlite3
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
export GIT_ACCOUNT_DIR=~/docktermj.git
export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/hello-senzing-springboot-java"
export GIT_REPOSITORY_URL="https://github.com/docktermj/hello-senzing-springboot-java.git"
export SENZING_DIR=/opt/senzing
export SENZING_USER=g2
```

If not set, export `JAVA_HOME`.

```console
  if [ -z "${JAVA_HOME}" ]; \
    then export JAVA_HOME=$(dirname $(dirname $(readlink -fn $(which javac)))); \
  fi
```

## Create Senzing user

Create a new user to install and run Senzing with (if not using an existing user):

```console
sudo adduser ${SENZING_USER}
```

Create directory for Senzing deployment and assign permissions to user:

```console
sudo mkdir ${SENZING_DIR}
sudo chown ${SENZING_USER}:${SENZING_USER} ${SENZING_DIR}
```

Switch to Senzing user:

```console
su - ${SENZING_USER}
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
    wget https://s3.amazonaws.com/public-read-access/SenzingComDownloads/Senzing_API.tgz
    ```

1. Uncompress `Senzing_API.tgz` into Senzing directory.

    ```console
    tar \
      --extract \
      --verbose \
      --directory=${SENZING_DIR} \
      --file=Senzing_API.tgz
    ```
    
1. Source setupEnv.
   To automate setting the environment variables in setupEnv in the future consider adding the source to your .bashrc or equivalent.  

    ```console
    source /opt/senzing/g2/setupEnv
    ```


1. Copy jar file into maven repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    mvn install:install-file \
      -Dfile=${SENZING_ROOT}/g2/lib/g2.jar \
      -DgroupId=com.senzing \
      -DartifactId=g2 \
      -Dversion=1.0.0-SNAPSHOT \
      -Dpackaging=jar
    ```

## Build Service

1. Build JAR file.

    ```console
    mvn package
    ```

## Run Service

1. Run demo service.

    ```console
    java -jar target/senzing-demo-0.0.1-SNAPSHOT.jar
    ```

1. [Test the service](../README.md#test).

## Clean up

After the demonstration is complete,
you may want to remove all files used in the demonstration.

1. Remove all files.

    ```console
    rm -rf ${SENZING_ROOT}
    rm -rf ${GIT_REPOSITORY_DIR}
    ```
