#!/bin/bash

# This script is used to execute a SQL file and record if the script has been executed already.
# It will check if the SQL file has already been executed by looking for a record in the dbversion table.
# If yes, it will exit with a message indicating that the script has already been executed.
# If no, it will execute the SQL file and record if the script has been executed successfully.
# Just a simple way to avoid executing the same script multiple times.
#
# Of course, this is a very basic way to handle this. 
# In a real project, you would have a much more robust system to handle this like Liquibase or Flyway.

# Check if the SQL filename argument is provided
if [ -z "${1}" ]; then
  echo "pg_execute.sh Usage: ${0} <sql_file>"
  exit 1
fi

SQL_FILE="${1}"
DB_NAME=${2}
VERSION_TABLE="public.dbversion"
VERSION_SCRIPT="/scripts/db_version.sql"

# Wait for database to be available
for i in {1..10}; do
    if psql -lqt | cut -d \| -f 1 | grep -qw "${DB_NAME}"; then
        break
    fi
    if [ $i -eq 10 ]; then
        echo "Database '${DB_NAME}' not found after 10 attempts"
        exit 1
    fi
    echo "Waiting for database '${DB_NAME}' to be available... (attempt $i/10)"
    sleep 3
done

# Create the dbversion table if it doesn't exist
psql -d "${DB_NAME}" -f "${VERSION_SCRIPT}" >/dev/null 2>&1

# Check if the SQL file has already been executed
if psql -d "${DB_NAME}" -Atqc "SELECT 1 FROM ${VERSION_TABLE} WHERE filename = '${SQL_FILE}'" | grep -q 1; then
  echo "Script '${SQL_FILE}' has already been executed."
  exit 0
else
  # Execute the SQL file
  if psql -d "${DB_NAME}" -f "${SQL_FILE}"; then
    echo "Successfully executed '${SQL_FILE}'."
    psql -d "${DB_NAME}" -c "INSERT INTO ${VERSION_TABLE} (filename) VALUES ('${SQL_FILE}')"
    exit 0
  else
    echo "Failed to execute '${SQL_FILE}'."
    exit 1
  fi
fi