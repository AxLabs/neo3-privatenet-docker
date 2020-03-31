FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS PluginBuild

COPY ./ /neo-modules

WORKDIR /neo-modules
RUN dotnet restore && dotnet publish -r linux-x64 -c Release -o /plugins

FROM neo-project/neo-node/neo-cli:latest AS NeoCliFinal

COPY --from=PluginBuild /plugins ./Plugins