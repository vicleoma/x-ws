# 基础镜像
FROM ubuntu:20.04

# 设置环境变量
ENV XRAY_VERSION 1.5.5

# 安装依赖
RUN apt-get update && apt-get install -y wget unzip

# 下载并安装Xray
RUN wget https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip \
    && unzip Xray-linux-64.zip -d /usr/local/bin/ \
    && rm Xray-linux-64.zip \
    && chmod +x /usr/local/bin/xray

# 创建配置文件目录
RUN mkdir -p /etc/xray

# 添加配置文件
COPY config.json /etc/xray/config.json

# 暴露端口
EXPOSE 443

# 启动Xray
CMD ["xray", "-c", "/etc/xray/config.json"]
