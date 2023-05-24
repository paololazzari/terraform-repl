#!/bin/bash

test_tf_function() {
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
  screen -d -mL bash -c "printf \"element(local.b.nums,0)\nexit\" | terraform-repl -no-docker-container-backend"
  
  # kill process
  pkill -f screen
  
  # wait for screenlog file to exist
  while ! [ -s screenlog.0 ]; do
    sleep 1
  done

  # check output
  output="$(grep -Eo '[0-9]+\S*' screenlog.0)"
  assertEquals "1" "$output"
}

# Load shUnit2.
. shunit2