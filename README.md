[![Build Status](https://travis-ci.org/openzipkin/docker-zipkin-aws.svg)](https://travis-ci.org/openzipkin/docker-zipkin-aws)
[![zipkin-aws](https://quay.io/repository/openzipkin/zipkin-aws/status "zipkin-aws")](https://quay.io/repository/openzipkin/zipkin-aws)

# docker-zipkin-aws

This repository contains the Docker build definition and release process for
[openzipkin/zipkin-aws](https://github.com/openzipkin/zipkin-aws).

This layers Amazon Web Services support on the base [zipkin docker image](https://github.com/openzipkin/docker-zipkin).

Currently, this adds SQS Collector support

## Running

TODO: link to variables used and show docker run -e for the minimum needed

## Configuration

Configuration is via environment variables, defined by [zipkin-aws](https://github.com/openzipkin/zipkin-aws/blob/master/README.md).

In docker, the following can also be set:

    * `JAVA_OPTS`: Use to set java arguments, such as heap size or trust store location.

### SQS

SQS Configuration variables are detailed [here](https://github.com/openzipkin/zipkin-aws/tree/master/autoconfigure/collector-sqs#configuration).
