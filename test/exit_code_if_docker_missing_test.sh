#!/bin/bash

test_exit_code_if_docker_missing() {
  # If docker is missing and the -no-docker-container-backend option is not provided, 
  # terraform-repl should exit with exit code 1
  output=$(terraform-repl)
  exitcode=$?
  assertEquals "docker is not installed
To not use the docker container backend, use the -no-docker-container-backend option when running terraform-repl" "$output"
  assertEquals 1 "$exitcode"
}

# Load shUnit2.
. shunit2