#!/bin/bash

test_external_command() {
  rm screenlog.0 &>/dev/null
  
  # start background screen process
  screen -d -mL bash -c "printf \"\!whoami\nexit\" | terraform-repl -no-docker-container-backend"
  
  # kill process
  pkill -f screen
  
  # wait for screenlog file to exist
  while ! [ -s screenlog.0 ]; do
    sleep 1
  done

  # check output
  output="$(grep -Eo '[a-z]+\S*' screenlog.0)"
  assertEquals "root" "$output"
}

# Load shUnit2.
. shunit2