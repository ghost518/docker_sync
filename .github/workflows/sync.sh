#!/bin/bash
set -eux

TARGET_REGISTRY=registry.cn-hangzhou.aliyuncs.com
TARGET_NAMESPACE=ghost518
IMAGES="langgenius/dify-api:1.3.0 langgenius/dify-web:1.3.0 langgenius/dify-plugin-daemon:0.0.8-local"

for image in ${IMAGES};do
    # 拉取镜像
    docker pull $image
    name=`echo ${image} | cut -d '/' -f2`
    tag=`echo ${name} | cut -d ':' -f2`
    targetFullName=${TARGET_REGISTRY}/${TARGET_NAMESPACE}/${name}
    # 打阿里云的tag
    docker tag ${image} ${targetFullName}
    # 推送到阿里云
    docker push ${targetFullName}
done
