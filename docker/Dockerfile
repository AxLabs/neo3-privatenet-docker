ARG IMAGE_TAG=master

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS PluginBuild

COPY ./ /neo-modules
WORKDIR /neo-modules
RUN dotnet publish -r linux-x64 -c Release -o /plugins

FROM neo-project/neo-node/neo-cli:${IMAGE_TAG} AS NeoCliFinal

COPY --from=PluginBuild /plugins ./Plugins