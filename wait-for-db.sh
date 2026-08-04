#!/bin/sh
set -eu

# wait-for-db.sh
# Waits until MySQL on host "db" responds, then starts the Spring Boot jar.

echo "Waiting for DB at db:3306..."
# mysqladmin is provided by the mysql-client package in many images; if not available,
# consider installing or using a different check (e.g., nc or curl to a readiness endpoint).
until mysqladmin ping -h db --silent; do
  echo "DB not ready — sleeping 5s"
  sleep 5
done

echo "DB is up — starting app"
exec java -jar /app/backend-0.0.1-SNAPSHOT.jar
