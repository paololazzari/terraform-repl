#!/bin/bash
set -e

# Install prerequisites
apt-get update -y
apt-get install curl -y
apt-get install unzip -y
apt-get install screen -y

# Install shunit2
curl -L https://raw.githubusercontent.com/kward/shunit2/master/shunit2 -o /usr/local/bin/shunit2
chmod +x /usr/local/bin/shunit2

# Install terraform-repl
curl -O https://raw.githubusercontent.com/paololazzari/terraform-repl/master/terraform-repl
cp terraform-repl /usr/local/bin/
chmod +x /usr/local/bin/terraform-repl

# Make all test scripts executable
chmod +x *.sh

./exit_code_if_tf_missing_test.sh
curl -sOL https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip
unzip -q terraform_1.3.7_linux_amd64.zip
cp terraform /usr/local/bin/
chmod +x /usr/local/bin/terraform

./exit_code_if_jq_missing_test.sh
curl -sOL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
cp jq-linux64 /usr/local/bin/jq
chmod +x /usr/local/bin/jq

./exit_code_if_hcl2json_missing_test.sh
curl -sOL https://github.com/tmccombs/hcl2json/releases/download/v0.3.6/hcl2json_linux_amd64
cp hcl2json_linux_amd64 /usr/local/bin/hcl2json
chmod +x /usr/local/bin/hcl2json

./exit_code_if_docker_missing_test.sh

./test_history.sh
./test_external_command.sh
./test_transcript.sh
./test_tf_function.sh