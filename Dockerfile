# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY . ./

# 👇 FIX HERE
RUN dotnet restore QuantityMeasurementApp.sln

# 👇 FIX HERE
RUN dotnet publish QuantityMeasurementApp.Api/QuantityMeasurementApp.Api.csproj -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/out ./

ENV ASPNETCORE_URLS=http://+:$PORT

CMD ["dotnet", "QuantityMeasurementApp.Api.dll"]