#!/bin/bash

CURR_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd )";
[ -d "$CURR_DIR" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

# shellcheck source=./common.sh
source "$CURR_DIR/common.sh";

section "Destination Registry"

printf ${YEL}"Define destination registry (ex: registry.andygodish.com):${END} "
read DEST_REG

# docker login $SOURCE_REG

# printf ${YEL}"Define source image (docker pull -a <source registry>/<source image>):${END} "
# read SOURCE_IMAGE

# docker pull -a $SOURCE_REG/$SOURCE_IMAGE

# echo $SOURCE_IMAGE
# rm ${PWD}/images.txt
# docker image ls --format '{{.Repository}}:{{.Tag}}' | grep "${SOURCE_REG}/${SOURCE_IMAGE}" >> ${PWD}/images.txt

manifest=${PWD}/images.txt

while read image; do
    docker pull "$image"
    IFS='/'
    read -a array <<< "$image"
    docker image tag "$image" ${DEST_REG}/public-images/rancher-259/${array[${#array[@]}-1]]}
    docker push ${DEST_REG}/public-images/rancher-259/${array[${#array[@]}-1]]}
done <"${manifest}"
