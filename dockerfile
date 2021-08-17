FROM  mcr.microsoft.com/dotnet/framework/sdk:4.7.2 AS build


EXPOSE 80

# copy everything and restore as distinct layers
COPY  . .

WORKDIR ./src


RUN nuget restore SmartStoreNET.sln

# Build app

RUN msbuild  ./Presentation/SmartStore.Web/SmartStore.Web.csproj /p:DeployOnBuild=true 

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019 AS runtime
WORKDIR /inetpub/wwwroot
RUN New-Item ./smartstore -type directory

COPY --from=build ./src/Presentation/SmartStore.Web .
RUN icacls './smartstore/App_Data' /grant 'IIS_IUSRS:(F)' /t

RUN dir
RUN Remove-WebSite -Name 'Default Web Site'
RUN New-Website -Name 'smartstore'-Port 80 -PhysicalPath './smartstore' -ApplicationPool '.NET v4.7.2'
