[![Build Status](https://travis-ci.org/openzipkin/docker-zipkin-aws.svg)](https://travis-ci.org/openzipkin/docker-zipkin-aws)
[![zipkin-aws](https://quay.io/repository/openzipkin/zipkin-aws/status "zipkin-aws")](https://quay.io/repository/openzipkin/zipkin-aws)

# docker-zipkin-aws

This repository contains the Docker build definition and release process for
[openzipkin/zipkin-aws](https://github.com/openzipkin/zipkin-aws).

This layers Amazon Web Services support on the base [zipkin docker image](https://github.com/openzipkin/docker-zipkin).

Currently, this adds a SQS Collector, and a Kinesis Streams Collector

## Running

By default, this image will search for credentials including those in the `~/.aws` directory.

If you want to try Zipkin against Amazon Elasticsearch Service and SQS, the
easiest start is to share your credentials with Zipkin's docker image.

For example, if you are able to run `aws es list-domain-names`, then you
should be able to start Zipkin on Amazon as simply as this:


```bash
$ docker run -d -p 9411:9411 \
  -e STORAGE_TYPE=elasticsearch -e ES_AWS_DOMAIN=your_domain \
  -e SQS_QUEUE_URL=https://ap-southeast-1.queue.amazonaws.com/12345678/your_queue \
  -v $HOME/.aws:/root/.aws:ro \
  openzipkin/zipkin-aws
```

## Configuration

Configuration is via environment variables, defined by [zipkin-aws](https://github.com/openzipkin/zipkin-aws/blob/master/README.md).

In docker, the following can also be set:

    * `JAVA_OPTS`: Use to set java arguments, such as heap size or trust store location.

### SQS

SQS Configuration variables are detailed [here](https://github.com/openzipkin/zipkin-aws/tree/master/autoconfigure/collector-sqs#configuration).


### Kinesis

Kinesis Configuration variables are detailed [here](https://github.com/openzipkin/zipkin-aws/tree/master/autoconfigure/collector-kinesis#configuration).