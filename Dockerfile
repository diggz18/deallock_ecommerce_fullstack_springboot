FROM maven:3.9.12-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN mvn -DskipTests package -B

FROM eclipse-temurin:25-jre-jammy
WORKDIR /app

# Install a small MySQL client so wait-for-db.sh can probe the DB
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends default-mysql-client \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/target/backend-0.0.1-SNAPSHOT.jar /app/
COPY wait-for-db.sh /app/
RUN chmod +x /app/wait-for-db.sh
EXPOSE 8080
CMD ["/app/wait-for-db.sh"]
