#!/bin/bash

test_history() {
  rm screenlog.0 &>/dev/null

  # start background screen process
  screen -d -mL bash -c "printf \"history\nexit\" | terraform-repl"
  
  # kill process
  pkill -f screen
  
  # wait for screenlog file to exist
  while ! [ -s screenlog.0 ]; do
    sleep 1
  done

  # check output
  output="$(grep -Eo '.+\S' screenlog.0)"
  assertEquals "    1  history" "$output"
}

# Load shUnit2.
. shunit2