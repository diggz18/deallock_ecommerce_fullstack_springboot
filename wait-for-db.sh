#!/bin/sh
set -eu

echo "Waiting for DB at db:3306..."

# Pure shell TCP socket check that does not require mysqladmin or nc
until getent hosts db >/dev/null 2>&1; do
  echo "DB not ready — sleeping 5s"
  sleep 5
done

echo "DB is up — starting app"
exec java -jar /app/backend-0.0.1-SNAPSHOT.jar
