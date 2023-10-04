FROM ballerina/ballerina:2201.6.1 AS ballerina-builder
USER root
ADD . /

WORKDIR /

RUN bal build

FROM ballerina/jvm-runtime:1

LABEL maintainer="choreo"

COPY --from=ballerina-builder target/bin/ping_central.jar /home/ballerina/

RUN addgroup troupe \
    && adduser -S -s /bin/bash -g 'ballerina' -G troupe -D ballerina \
    && apk add --update --no-cache bash \
    && rm -rf /var/cache/apk/*

WORKDIR /home/ballerina

EXPOSE  9090 9091
USER ballerina

CMD java -XX:InitialRAMPercentage=50.0 -XX:+UseContainerSupport -XX:MinRAMPercentage=60.0 -XX:MaxRAMPercentage=60.0 -jar ping_central.jar
