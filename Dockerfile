#
# Copyright 2015-2016 The OpenZipkin Authors
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
FROM openzipkin/zipkin:1.31.0
MAINTAINER OpenZipkin "http://zipkin.io/"

ENV ZIPKIN_AWS_REPO https://jcenter.bintray.com
ENV ZIPKIN_AWS_VERSION 0.5.1

RUN apk add unzip && \ 
  curl -SL $ZIPKIN_AWS_REPO/io/zipkin/aws/zipkin-autoconfigure-collector-sqs/$ZIPKIN_AWS_VERSION/zipkin-autoconfigure-collector-sqs-$ZIPKIN_AWS_VERSION-module.jar > sqs.jar && \
  curl -SL $ZIPKIN_AWS_REPO/io/zipkin/aws/zipkin-autoconfigure-collector-kinesis/$ZIPKIN_AWS_VERSION/zipkin-autoconfigure-collector-kinesis-$ZIPKIN_AWS_VERSION-module.jar > kinesis.jar && \
  unzip sqs.jar -d sqs && \
  unzip kinesis.jar -d kinesis && \
  rm sqs.jar && \
  rm kinesis.jar && \
  apk del unzip

CMD test -n "$STORAGE_TYPE" && source .${STORAGE_TYPE}_profile; java ${JAVA_OPTS} -Dloader.path=sqs,kinesis -Dspring.profiles.active=sqs,kinesis -cp . org.springframework.boot.loader.PropertiesLauncher
