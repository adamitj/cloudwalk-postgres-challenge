# Cloudwalk SRE/DBE/DBA challenge

This test was requested by Willian Nascimento.

Description available at https://gist.github.com/cloudwalk-tests/dfd459b26fd031acf986f1e15acad0d5 .

# Instructions

Put all project files in a folder/path where `docker` and `docker-compose` commands are available:

    scripts
      |- pg_master/db/migration
        |- V1_init.sql
      |- pg_replica/db/migration
        |- V1_init.sql
      |- db_version.sql
      |- pg_execute.sh
      |- pg_migration.sh
      |- test_insert.sql
    db_start.cmd
    db_start.ksh
    db_start.sh
    db_stop.cmd
    db_stop.ksh
    db_stop.sh
    docker-compose.yaml 

For both `pg_master` and `pg_replica` database containers running on PostgreSQL v14 (could be using v16+ or more recent version) will used bind volume mounts.

It is recommended to use the scripts below to avoid database crashes.


## Microsoft Windows

If you are running Microsoft Windows, open the terminal or `cmd.exe`, go to the folder where `docker-compose.yaml` file is (the root of the project) using the command `cd`.

### Starting databases

To start both `pg_master` and `pg_replica` instances, just run

    db_start.cmd

### Stopping databases

    db_stop.cmd

## Linux

On Unix the procedure is the same, just fire up a new terminal with bash, `cd` to the root folder of the project where `docker-compose.yaml` file is.

### Starting databases

    bash db_start.sh

### Stopping databases

    bash db_stop.sh

## macOS

I don't own any Apple device like a MacBook, but follow the Linux process and try these scripts below. They should work.

### Starting databases

    ksh db_start.ksh

### Stopping databases

    ksh db_stop.ksh
