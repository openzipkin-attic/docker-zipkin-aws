#
# Copyright 2015-2018 The OpenZipkin Authors
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions and limitations under
# the License.
#

FROM alpine

WORKDIR /zipkin-aws

ENV ZIPKIN_AWS_REPO https://jcenter.bintray.com
ENV ZIPKIN_AWS_VERSION 0.16.2

RUN apk add curl unzip && \
  curl -SL $ZIPKIN_AWS_REPO/io/zipkin/aws/zipkin-autoconfigure-collector-sqs/$ZIPKIN_AWS_VERSION/zipkin-autoconfigure-collector-sqs-$ZIPKIN_AWS_VERSION-module.jar > sqs.jar && \
  curl -SL $ZIPKIN_AWS_REPO/io/zipkin/aws/zipkin-autoconfigure-collector-kinesis/$ZIPKIN_AWS_VERSION/zipkin-autoconfigure-collector-kinesis-$ZIPKIN_AWS_VERSION-module.jar > kinesis.jar && \
  curl -SL $ZIPKIN_AWS_REPO/io/zipkin/aws/zipkin-autoconfigure-storage-elasticsearch-aws/$ZIPKIN_AWS_VERSION/zipkin-autoconfigure-storage-elasticsearch-aws-$ZIPKIN_AWS_VERSION-module.jar > elasticsearch-aws.jar && \
  curl -SL $ZIPKIN_AWS_REPO/io/zipkin/aws/zipkin-autoconfigure-storage-xray/$ZIPKIN_AWS_VERSION/zipkin-autoconfigure-storage-xray-$ZIPKIN_AWS_VERSION-module.jar > xray.jar && \
  echo > .xray_profile && \
  unzip sqs.jar -d sqs && \
  unzip kinesis.jar -d kinesis && \
  unzip elasticsearch-aws.jar -d elasticsearch-aws && \
  unzip xray.jar -d xray && \
  rm sqs.jar && \
  rm kinesis.jar && \
  rm elasticsearch-aws.jar && \
  rm xray.jar

FROM openzipkin/zipkin:2.12.6
MAINTAINER OpenZipkin "http://zipkin.io/"

COPY --from=0 /zipkin-aws/ /zipkin/

ENV MODULE_OPTS="-Dloader.path=sqs,kinesis,elasticsearch-aws,xray -Dspring.profiles.active=sqs,kinesis,elasticsearch-aws,xray"
