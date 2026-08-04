FROM maven:3.9.12-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN mvn -DskipTests package -B

FROM eclipse-temurin:25-jre-jammy
WORKDIR /app
COPY --from=build /app/target/backend-0.0.1-SNAPSHOT.jar /app/
COPY wait-for-db.sh /app/
RUN chmod +x /app/wait-for-db.sh
EXPOSE 8080
CMD ["/app/wait-for-db.sh"]
