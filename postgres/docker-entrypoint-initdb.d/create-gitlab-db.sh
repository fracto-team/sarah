#!/bin/bash

# Copy create-x-db.sh.example to create-x-db.sh
# then uncomment, set database name and username to create databases

# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
#     CREATE USER db1 WITH PASSWORD 'db1';
#     CREATE DATABASE db1;
#     GRANT ALL PRIVILEGES ON DATABASE db1 TO db1;
# EOSQL

if [ "$GITLAB_POSTGRES_INIT" == 'true' ]; then
    echo "Initializing gitlab postgres database..."
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
		CREATE USER $GITLAB_POSTGRES_USER WITH PASSWORD '$GITLAB_POSTGRES_PASSWORD';
		CREATE DATABASE $GITLAB_POSTGRES_DB;
		GRANT ALL PRIVILEGES ON DATABASE $GITLAB_POSTGRES_DB TO $GITLAB_POSTGRES_USER;
		ALTER ROLE $GITLAB_POSTGRES_USER CREATEROLE SUPERUSER;
	EOSQL
	echo
fi

