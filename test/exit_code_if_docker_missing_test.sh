#!/bin/bash

test_exit_code_if_docker_missing() {
  # If docker is missing and the -docker-container-backend option is provided,
  # terraform-repl should exit with exit code 1
  output=$(terraform-repl -docker-container-backend)
  exitcode=$?
  assertContains "docker is not installed" "$output"
  assertEquals 1 "$exitcode"
}

# Load shUnit2.
. shunit2