FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-1803 AS build
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


FROM microsoft/aspnet:4.7.2-windowsservercore-1803 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/publish 

