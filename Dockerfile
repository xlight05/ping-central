# FROM ballerina/ballerina:2201.7.2 AS ballerina-builder
# USER root
# ADD . /

# WORKDIR /

# RUN bal build

# FROM ballerina/jvm-runtime:1

# LABEL maintainer="choreo"

# COPY --from=ballerina-builder target/bin/ping_central.jar /home/ballerina/


# FROM ballerina/jvm-runtime:1

# LABEL maintainer="choreo"

# COPY ping_central.jar /home/ballerina/

# RUN addgroup troupe \
#     && adduser -S -s /bin/bash -g 'ballerina' -G troupe -D ballerina \
#     && apk add --update --no-cache bash \
#     && rm -rf /var/cache/apk/*

# WORKDIR /home/ballerina

# EXPOSE  9090 9091
# USER ballerina


FROM adoptopenjdk/openjdk11:jre-11.0.18_10-alpine
WORKDIR /home/ballerina

LABEL maintainer="choreo"

RUN addgroup -g 12000 troupe \
      && adduser -u 12000 --system  --disabled-password --shell /bin/bash --gecos 'ballerina' --ingroup troupe ballerina \
      && apk update \
      && apk upgrade \
      && rm -rf /var/cache/apk/*

COPY ping_central.jar /home/ballerina

RUN chown ballerina -R /home/ballerina

EXPOSE 9090 9091
USER ballerina

CMD java -XX:InitialRAMPercentage=50.0 -XX:+UseContainerSupport -XX:MinRAMPercentage=60.0 -XX:MaxRAMPercentage=60.0 -jar ping_central.jar
