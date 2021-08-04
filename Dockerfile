FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    gnupg \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - \
    && sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    jenkins \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

RUN service jenkins start
ENTRYPOINT ["tail", "-f", "/var/log/jenkins/jenkins.log"]
