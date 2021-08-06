FROM  mcr.microsoft.com/dotnet/framework/sdk:4.7.2 AS build
WORKDIR C:\app

EXPOSE 8080
# copy csproj and restore as distinct layers

COPY  *.sln   .
COPY src\*.csproj .\projects\
COPY src\*.config .\configurations\



RUN nuget restore

# copy everything else and build app
COPY . C:\app
RUN msbuild /p:OutputPath=C:\app\publish /p:Configuration=Release


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build C:\app\publish . 

