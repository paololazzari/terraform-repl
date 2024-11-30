#!/bin/bash

test_exit_code_if_tf_missing() {
  # If terraform is not installed, terraform-repl should exit with exit code 1
  output=$(terraform-repl)
  exitcode=$?
  assertContains "terraform is not installed" "$output"
  assertEquals 1 "$exitcode"
}

# Load shUnit2.
. shunit2