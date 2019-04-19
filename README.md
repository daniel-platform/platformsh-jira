# JIRA on Platform.sh

Automaticly deploys a fully function copy of JIRA (currently at version 8.1.0) on 
Platform.sh

## Requirements

Needs no less than an Large plan to function properly.
A JIRA license key

## Instructions

- Create a new project.
- Deploy this repository.
- Enjoy.

## Details

Uses PostgresSQL 9.6 as the database.  By default it sets aside 1 GB for database and 2 GB for assets.

## Additional Information

In order to decode relationship and route information from enviroment 
variables, this project uses the following pre-built (Debian) binaries 
located in the `bin` folder.

- json_env: https://github.com/daniel-platform/relationship-explorer
- routes: https://github.com/daniel-platform/route-lookup

