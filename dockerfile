FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019 AS build
WORKDIR /app

EXPOSE 8080
# copy csproj and restore as distinct layers
COPY *.sln .
COPY /src/*.csproj ./projects
COPY *.config ./configurations
RUN nuget restore

# copy everything else and build app
COPY . .
WORKDIR /app/projects
RUN msbuild /p:Configuration=Release


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/publish . 

