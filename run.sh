#!/bin/bash

startdb() {
    echo "Starting postgres database"
    docker compose up -d
    echo "Started."
}

stopdb() {
    echo "Stopping postgres database."
    docker stop go_postgres
    docker rm go_postgres
    echo "Stopped."
}

dblogs() {
    docker logs -f go_postgres
}

initdb() {
    docker exec -it go_postgres psql -U postgres -c products_db
}

cleanup() {
    echo "Removing cache."
    rm -rf go-rest-api
    docker volume rm pq_dbdata
    echo "Removed."
}

server() {
    if [[ -n "$1" ]]; then
        go run . $1
    else
        go run .
    fi
}

test() {
    go test -v github.com/adwardstark/go-rest-api/app
}

"$@"