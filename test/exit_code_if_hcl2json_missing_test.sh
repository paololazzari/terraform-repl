#!/bin/bash

test_exit_code_if_hcl2json_missing() {
  # If hcl2json is missing, terraform-repl should exit with exit code 1
  output=$(terraform-repl)
  exitcode=$?
  assertContains "hcl2json is not installed" "$output"
  assertEquals 1 "$exitcode"
}

# Load shUnit2.
. shunit2