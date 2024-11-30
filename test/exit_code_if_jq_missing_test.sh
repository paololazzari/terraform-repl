#!/bin/bash

test_exit_code_if_jq_missing() {
  # If jq is missing, terraform-repl should exit with exit code 1
  output=$(terraform-repl)
  exitcode=$?
  assertContains "jq is not installed" "$output"
  assertEquals 1 "$exitcode"
}

# Load shUnit2.
. shunit2