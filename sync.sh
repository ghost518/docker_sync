
#!/bin/bash
set -eux

TARGET_REGISTRY="registry.cn-hangzhou.aliyuncs.com"
TARGET_NAMESPACE="ghost518-acr"
IMAGES=(
  "confluentinc/cp-zookeeper:7.4.0"
)

for image in "${IMAGES[@]}"; do
    # 拉取镜像
    docker pull "$image"
    name=$(echo "${image}" | cut -d '/' -f2)
    pure_name=$(echo "${name}" | cut -d ':' -f1)
    tag=$(echo "${name}" | cut -d ':' -f2)
    targetFullName="${TARGET_REGISTRY}/${TARGET_NAMESPACE}/${pure_name}:${tag}"
    
    # 打阿里云的tag
    docker tag "${image}" "${targetFullName}"
    # 推送到阿里云
    docker push "${targetFullName}"
done
