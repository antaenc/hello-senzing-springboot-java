# Hello Senzing Spring-boot for Java

## Overview

In this demonstration....

## Install and Run

These instructions will install and run the web server.

1. [Debian-based installation](doc/debian-based-installation.md) - For Ubuntu and [others](https://en.wikipedia.org/wiki/List_of_Linux_distributions#Debian-based)
1. [RPM-based installation](doc/rpm-based-installation.md) - For Red Hat, CentOS, openSuse and [others](https://en.wikipedia.org/wiki/List_of_Linux_distributions#RPM-based).

## Test

### Find port

Once the service is running, the end of the log shown in standard out (STDOUT) may look something like this:

```console
YYYY-MM-DD HH:MM:SS.sss  INFO 8032 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
YYYY-MM-DD HH:MM:SS.sss  INFO 8032 --- [           main] c.s.senzingdemo.SenzingDemoApplication   : Started SenzingDemoApplication in 11.077 seconds (JVM running for 12.172)
```

The import information is that the service is running on port `8080`.

### Test port

To test the service, open a web-browser (e.g. FireFox, Chrome, Safari, MS Explorer, Opera) to
`http://localhost:8080/stats`,  replacing `localhost` if needed.

### View OpenAPI document

1. Set environment variables.

    ```console
    export PROJECT_DIR=~/docktermj.git
    export REPOSITORY_DIR="${PROJECT_DIR}/hello-senzing-springboot-java"
    export DEMO_URL="http://localhost:8080"
    ```

1. Download OpenAPI document.

    ```console
    curl -X GET \
      --output ${REPOSITORY_DIR}/Senzing_API.json \
      ${DEMO_URL}/v2/api-docs
    ```

1. Visit [Swagger / OpenAPI editor](https://editor.swagger.io)
    1. [Editor](https://editor.swagger.io) > File > Import File > Browse...
        1. Choose ${REPOSITORY_DIR}/Senzing_API.json

## References

1. [Spring Boot](http://spring.io/projects/spring-boot)
    1. [Spring initializr](https://start.spring.io/)