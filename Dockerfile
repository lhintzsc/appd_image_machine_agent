FROM openjdk:8-jre-slim

# set environment variables
ENV APPD_HOME /opt/appd
ENV APPD_AGENT_HOME ${APPD_HOME}/machine_agent

# install packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y bash && \
    apt-get install -y gawk && \
    apt-get install -y sed && \
    apt-get install -y grep && \
    apt-get install -y coreutils && \
    apt-get install -y vim-tiny && \
    apt-get install -y iproute2 && \
    apt-get install -y procps && \
    apt-get install -y sysstat && \
    apt-get install -y nmap && \
    apt-get install -y net-tools && \
    apt-get install -y tcpdump && \
    apt-get install -y curl && \
    apt-get install -y sysvinit-utils && \
    apt-get install -y openssh-client && \
    rm -rf /var/lib/apt/lists/*

# install agent and startup script
ADD machine_agent ${APPD_AGENT_HOME}
ADD startup.sh ${APPD_AGENT_HOME}/startup.sh
RUN chmod 744 ${APPD_AGENT_HOME}/startup.sh

# Configure and Run AppDynamics Machine Agent
WORKDIR ${APPD_AGENT_HOME}
CMD "${APPD_AGENT_HOME}/startup.sh"
