# Hello Senzing Spring-boot for Java

## Overview

This demonstration shows how to wrap Senzing with Spring-boot to create an HTTP API.

The resulting HTTP API is documented in 
[OpenAPI.json](https://raw.githubusercontent.com/docktermj/hello-senzing-springboot-java/master/doc/OpenAPI.json)
and can be viewed in the 
[Swagger editor](http://editor.swagger.io/?url=https://raw.githubusercontent.com/docktermj/hello-senzing-springboot-java/master/doc/OpenAPI.json).

## Install and run service

These instructions will install and run the web server.

1. [Debian-based installation](doc/debian-based-installation.md) - For Ubuntu and [others](https://en.wikipedia.org/wiki/List_of_Linux_distributions#Debian-based)
1. [RPM-based installation](doc/rpm-based-installation.md) - For Red Hat, CentOS, openSuse and [others](https://en.wikipedia.org/wiki/List_of_Linux_distributions#RPM-based).

## Test

### Find port

Normally the service runs on port 8080.
To verify this, the end of the service log sent to standard out (STDOUT) will have the port information.

```console
YYYY-MM-DD HH:MM:SS.sss  INFO 8032 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
YYYY-MM-DD HH:MM:SS.sss  INFO 8032 --- [           main] c.s.senzingdemo.SenzingDemoApplication   : Started SenzingDemoApplication in 11.077 seconds (JVM running for 12.172)
```

### Test port

To test the service, open a web-browser (e.g. FireFox, Chrome, Safari, MS Explorer, Opera) to
`http://localhost:8080/stats`, replacing `localhost` if needed.

### View OpenAPI document

1. Set environment variables.

    ```console
    export PROJECT_DIR=~/docktermj.git
    export REPOSITORY_DIR="${PROJECT_DIR}/hello-senzing-springboot-java"
    export SENZING_DEMO_DATASOURCE="TEST"
    export SENZING_DEMO_URL="http://localhost:8080"
    export SENZING_DIR=/opt/senzing
    ```

1. Download OpenAPI document.

    ```console
    curl -X GET \
      --output ${REPOSITORY_DIR}/Senzing_API.json \
      ${SENZING_DEMO_URL}/v2/api-docs
    ```

1. Visit [Swagger / OpenAPI editor](https://editor.swagger.io)
    1. [Editor](https://editor.swagger.io) > File > Import File > Browse...
        1. Choose ${REPOSITORY_DIR}/Senzing_API.json

### Try the API

1. Get the Senzing workload statistics

    ```console
    curl -X GET \
      ${SENZING_DEMO_URL}/stats
    ```
1. Pretty printing.  If you would like the JSON response formatted, you can pipe the output to `jq`.  Example:

    ```console
    curl -X GET \
      ${SENZING_DEMO_URL}/stats | jq
    ```
1. Exercise a number of APIs via `curl` command.

    ```console
    cd ${REPOSITORY_DIR}/doc
    ./curl-commands.sh > curl-commands.out 2>&1
    ```

    View results in ${REPOSITORY_DIR}/doc/curl-commands.out

## References

1. [Spring Boot](http://spring.io/projects/spring-boot)
    1. [Spring initializr](https://start.spring.io/)

## Work-in-progress

1. Create a new datasource.

    ```console
    export JSON_BEFORE='\"CFG_DSRC\": \['
    export JSON_AFTER='\"CFG_DSRC\": \[{\"DSRC_ID\": 9999,\"DSRC_CODE\": \"'${SENZING_DEMO_DATASOURCE}'\",\"DSRC_DESC\": \"'${SENZING_DEMO_DATASOURCE}'\",\"DSRC_RELY\": 1,\"RETENTION_LEVEL\": \"Remember\",\"CONVERSATIONAL\": 0},'

    sudo sed -i.$(date +%s) \
      -e "s|${JSON_BEFORE}|${JSON_AFTER}|" \
      ${SENZING_DIR}/g2/data/g2config.json
    ```