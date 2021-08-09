FROM  mcr.microsoft.com/dotnet/framework/sdk:4.7.2 AS build
WORKDIR .\app

EXPOSE 8080

# copy csproj and restore as distinct layers
COPY  src\*  .

RUN nuget restore SmartStoreNET.sln

# copy everything else and build app
COPY . .
RUN msbuild  SmartStoreNET.sln /p:OutputPath=.\app\publish /p:Configuration=Release


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build .\app\publish . 

