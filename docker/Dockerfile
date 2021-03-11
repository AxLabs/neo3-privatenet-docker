ARG IMAGE_TAG=master

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS PluginBuild

COPY ./ /neo-modules
WORKDIR /neo-modules

ARG REGEX_EXCLUDE_PLUGINS=".*(SystemLog|RpcNep5Tracker)"

#
# Some magic here. Time for the kids to leave. Adults only.
#
# The following disgusting shell command is due to the lack of tooling 
# to exclude tests and projects in dotnet. *facepalm*
#
# The good side: main artifacts and tests are not mixed up in the 
# same plugins director, avoiding potential conflicts of .dll versions 
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
	| xargs -I {} sh -c 'echo {} && dotnet publish ./src/{} -r linux-x64 -c Release -o /plugins'

FROM neo-project/neo-node/neo-cli:${IMAGE_TAG} AS NeoCliFinal

# Install some utils and clean things up
RUN apt-get -y update && \
	apt-get -y install jq nano procps && \
	rm -rf /var/lib/apt/lists/*

COPY --from=PluginBuild /plugins ./Plugins