ARG IMAGE_TAG=master

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS PluginBuild

COPY ./ /neo-modules
WORKDIR /neo-modules

ARG REGEX_EXCLUDE_PLUGINS=".*(SystemLog|RpcNep5Tracker)"

#
# Some magic here. Time for the kids to leave. Adults only.
#
# The following disgusting shell command is due to the lack of tooling 
# to exclude tests and specific sub-projects in dotnet. *facepalm*
#
# The good side: main artifacts and tests are not mixed up in the 
# same plugins directory, avoiding potential conflicts of .dll versions 
# and other nasty problems. *smile*
#
RUN mkdir -p /plugins && \
	find ./src/ \
		-regextype posix-extended \
		-maxdepth 1 \
		-mindepth 1 \
		-type d \
		-and -not -name '.*' \
		-and -not -regex "${REGEX_EXCLUDE_PLUGINS}" -print0 \
	| xargs -0 -L1 sh -c 'basename $0' \
	| sed 's/ //g' \
	| xargs -I {} sh -c 'echo {} && dotnet publish ./src/{} -c Release /p:ErrorOnDuplicatePublishOutputFiles=false -o /plugins && mkdir -p /plugins/{} && cp /plugins/{}.* /plugins/{}/ && if [ -e ./src/{}/config.json ]; then cp ./src/{}/config.json /plugins/{}/config.json; fi'

FROM ghcr.io/axlabs/neo3-privatenet-docker/neo-cli:${IMAGE_TAG} AS NeoCliFinal

LABEL org.opencontainers.image.source https://github.com/axlabs/neo3-privatenet-docker

# Install some utils and clean things up
RUN apt-get -y update && \
	apt-get -y install jq nano procps && \
	rm -rf /var/lib/apt/lists/*

COPY --from=PluginBuild /plugins ./Plugins