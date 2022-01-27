FROM maven:3.8-openjdk-11

ENV TIME_ZONE=Asia/Shanghai
ENV CHANGE_SOURCE=true

WORKDIR /home/jenkins

COPY ./ ./

RUN set -eux; \
    # ⬇ 修改时区
    ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime ; \ 
    echo $TIME_ZONE > /etc/timezone ; \
    \
    # ⬇ 替换源
    rm -rf /etc/apt/sources.list.d/buster.list ; \
    if [ ${CHANGE_SOURCE} = true ]; then \
        mv /etc/apt/sources.list /etc/apt/source.list.bak; \ 
        mv /home/jenkins/resource/sources.list /etc/apt/sources.list; \
    fi; \
    \
    # ⬇ 安装基础工具
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y --allow-remove-essential --no-install-recommends \
    curl \
    wget \
    zip \
    unzip \
    vim \
    git \
    iputils-ping \
    net-tools \
    ntpdate ; \
    \
    # ⬇ 安装docker helm kubectl
    /bin/bash /home/jenkins/resource/install_utils.sh && rm -rf ./* ;

CMD ["mvn","-version"]
