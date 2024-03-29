#!/bin/bash

test_tab_complete_functions() {
  rm screenlog.0 &>/dev/null

  # start background screen process
  screen -SdmL test
  screen -S test -X stuff 'terraform-repl'`echo -ne '\015'`
  screen -S test -X stuff 'l'
  screen -S test -X stuff '\t'

  # kill process
  pkill -f screen

  # wait for screenlog file to exist
  while ! [ -s screenlog.0 ]; do
    sleep 1
  done

  # check output
  output=$(head -n2 screenlog.0 | tail -n 1 | sed 's/[^a-z]//g' | tail -c +3)
  [ "$output" == $(echo "loglowerlengthlistlookup" | sed 's/[^a-z]//g') ]
  exitcode=$?
  assertEquals 0 "$exitcode"
}

# Load shUnit2.
. shunit2