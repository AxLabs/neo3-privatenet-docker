#!/usr/bin/env bash

# Ok... this is a multi-platform build with multiple docker nodes (docker builders).
# So, no qemu or any emulation shit.
#
# Let's suppose we have two nodes (i.e., physical machines) with docker installed:
# (1) Local one supporting linux/arm64 and darwin/arm64.
# (2) A remote machine (reachable through ssh) supporting linux/amd64 and darwin/amd64.
#     The remote machine has the address 192.168.1.10.
#
# Now, we should create a docker builder (i.e., named 'multi-host') with two nodes:
#
# $ DOCKER_HOST=ssh://user@192.168.1.10 docker buildx create --platform linux/amd64,darwin/amd64 --name multi-host --node node2
# $ docker buildx create --platform linux/arm64,darwin/arm64 --name multi-host --append --node node1
# 
# If everything goes fine you can see the result with:
# $ docker buildx ls
#
# Then you can set your local docker to use the builder 'multi-host':
# $ docker buildx use multi-host
#
# After this, you can simply run your `docker buildx build` commands. :-)
#
# IMPORTANT:
# - If your remote machine (node2) is a MacOS, you might fall into this problem:
#   https://github.com/docker/for-mac/issues/4382
# - In this case, check the following comment to solve it:
#   https://github.com/docker/for-mac/issues/4382#issuecomment-603031242

set -o allexport; source .env; set +o allexport;

DOCKER_CONTEXT=default
DOCKER_BUILDX_CONTEXT=default

# Ensuring the default docker context is used
docker context use ${DOCKER_CONTEXT} || {
    echo "Failed to set the Docker context to ${DOCKER_CONTEXT}."
    exit 1
}

# Check for the existence of Docker Buildx plugin and set to default context if exists
if docker buildx version &>/dev/null; then
    docker buildx use ${DOCKER_BUILDX_CONTEXT} || {
        echo "Failed to set Docker Buildx to use the ${DOCKER_BUILDX_CONTEXT} context."
        exit 1
    }
fi

# Force no-cache:
# Remove all images and respective tags if 'no-cache' param is provided
if [ "$1" == "no-cache" ]; then
    declare -a IMAGES_TO_REMOVE=(
        "ghcr.io/axlabs/neo3-privatenet-docker/neo-cli:${IMAGE_TAG}"
        "ghcr.io/axlabs/neo3-privatenet-docker/neo-cli-with-plugins:${IMAGE_TAG}"
    )

    for IMAGE in "${IMAGES_TO_REMOVE[@]}"; do
        docker rmi -f "$IMAGE" 2>/dev/null || true
    done
fi

declare -a PLATFORMS=(
    "linux/amd64"
    "linux/arm64"
)

# Get the list of supported platforms using docker buildx inspect
SUPPORTED_PLATFORMS=$(docker buildx inspect default --bootstrap | grep 'linux/' | tr -d " " | tr ',' '\n')

# Flag to track if all platforms are supported
ALL_PLATFORMS_SUPPORTED=true

# Check each platform in PLATFORMS against the supported platforms
for PLATFORM in "${PLATFORMS[@]}"; do
    if echo "$SUPPORTED_PLATFORMS" | grep -q "$PLATFORM"; then
        echo "Platform $PLATFORM is supported"
    else
        echo "Platform $PLATFORM is NOT supported"
        ALL_PLATFORMS_SUPPORTED=false
    fi
done

# If not all platforms are supported, exit with status 1
if [ "$ALL_PLATFORMS_SUPPORTED" = false ]; then
    echo "Error: Not all platforms are supported"
    exit 1
fi

# Create a comma-separated string of all platforms
IFS=',' 
PLATFORMS_STR="${PLATFORMS[*]}"
IFS=' '
echo "Platforms: $PLATFORMS_STR"

echo "##############################"
echo "# Build+Push ghcr.io/axlabs/neo3-privatenet-docker/neo-cli:${IMAGE_TAG}"
echo "##############################"

docker buildx build \
	--no-cache \
	--push \
	--platform ${PLATFORMS_STR} \
	-t ghcr.io/axlabs/neo3-privatenet-docker/neo-cli:${IMAGE_TAG} \
	-f ./neo-node/Dockerfile \
	./neo-node

echo "##############################"
echo "# Build+Push ghcr.io/axlabs/neo3-privatenet-docker/neo-cli-with-plugins:${IMAGE_TAG}"
echo "##############################"

docker buildx build \
	--no-cache \
	--push \
	--platform ${PLATFORMS_STR} \
	-t ghcr.io/axlabs/neo3-privatenet-docker/neo-cli-with-plugins:${IMAGE_TAG} \
	-f ./docker/Dockerfile \
	--build-arg IMAGE_TAG=${IMAGE_TAG} \
	--target NeoCliFinal \
	./neo-modules