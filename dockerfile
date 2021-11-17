FROM  mcr.microsoft.com/dotnet/framework/sdk:4.7.2 AS build


EXPOSE 80

# copy everything and restore as distinct layers
COPY  . .

WORKDIR ./src


RUN nuget restore SmartStoreNET.sln

WORKDIR ..

# Build app

RUN msbuild  ./SmartStoreNET.proj /p:DeployOnBuild=true 

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build ./src/Presentation/SmartStore.Web .
RUN icacls './App_Data' /grant 'IIS_IUSRS:(F)' /t


