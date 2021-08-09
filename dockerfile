FROM  mcr.microsoft.com/dotnet/framework/sdk:4.7.2 AS build


EXPOSE 55282

# copy everything and restore as distinct layers
COPY  . .

WORKDIR ./src


RUN nuget restore SmartStoreNET.sln

# Build app

RUN msbuild  ./Presentation/SmartStore.Web/SmartStore.Web.csproj /p:OutputPath=./publish/ /p:Configuration=Release


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build ./publish/ . 

