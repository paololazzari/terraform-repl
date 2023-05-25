#!/bin/bash

test_transcript() {
  rm screenlog.0 &>/dev/null

  # gen temp .tf file
  cat <<EOT > main.tf
locals {
  a = "foo"
  b = {"nums": [
    1,
    2
  ]}
}
EOT

  # start background screen process
  screen -d -mL bash -c "printf \"local.a\nexit\" | terraform-repl -transcript"
  
  # kill process
  pkill -f screen
  
  # wait for screenlog file to exist
  while ! [ -s screenlog.0 ]; do
    sleep 1
  done

  # check output
  output="$(head -n 1 screenlog.0 | grep -Eo '.+\S')"
  assertEquals "\"foo\"" "$output"

  # check transcript file contents
  transcript_file="$(tail -n 1 screenlog.0 | grep -Eo '/tmp/\S+')"
  
  output="$(head -n 1 $transcript_file | grep -Eo '.+\S')"
  assertEquals "> local.a" "$output"

  output="$(tail -n 1 $transcript_file | grep -Eo '.+\S')"
  assertEquals "\"foo\"" "$output"
}

# Load shUnit2.
. shunit2