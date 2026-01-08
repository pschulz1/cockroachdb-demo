#!/bin/bash
../binaries/cockroach-v25.4.2 sql --insecure --file ../sql/backup.sql
../binaries/cockroach-v25.4.2 sql --insecure --file ../sql/drop.sql