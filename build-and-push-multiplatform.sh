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
# IMPORTANT:
# - If your remote machine (node2) is a MacOS, you might fall into this problem:
#   https://github.com/docker/for-mac/issues/4382
# - In this case, check the following comment to solve it:
#   https://github.com/docker/for-mac/issues/4382#issuecomment-603031242

set -o allexport; source .env; set +o allexport;

echo "##############################"
echo "# Build+Push ghcr.io/axlabs/neo3-privatenet-docker/neo-cli:${IMAGE_TAG}"
echo "##############################"

docker buildx build \
	--no-cache \
	--push \
	--platform linux/arm64,linux/amd64 \
	-t ghcr.io/axlabs/neo3-privatenet-docker/neo-cli:${IMAGE_TAG} \
	# -t ghcr.io/axlabs/neo3-privatenet-docker/neo-cli:latest \
	-f ./neo-node/Dockerfile \
	./neo-node

echo "##############################"
echo "# Build+Push ghcr.io/axlabs/neo3-privatenet-docker/neo-cli-with-plugins:${IMAGE_TAG}"
echo "##############################"

docker buildx build \
	--no-cache \
	--push \
	--platform linux/arm64,linux/amd64 \
	-t ghcr.io/axlabs/neo3-privatenet-docker/neo-cli-with-plugins:${IMAGE_TAG} \
	# -t ghcr.io/axlabs/neo3-privatenet-docker/neo-cli-with-plugins:latest \
	-f ./docker/Dockerfile \
	--build-arg IMAGE_TAG=${IMAGE_TAG} \
	--target NeoCliFinal \
	./neo-modules