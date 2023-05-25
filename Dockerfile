FROM ubuntu:20.04

WORKDIR /data

ENV jq_version="1.6"
ENV hcl2json_version="0.5.0"
ENV terraform_version="1.4.5"

RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl -sOL "https://github.com/stedolan/jq/releases/download/jq-${jq_version}/jq-linux64" && cp jq-linux64 /usr/local/bin/jq && chmod +x /usr/local/bin/jq && \
    curl -sOL "https://github.com/tmccombs/hcl2json/releases/download/v${hcl2json_version}/hcl2json_linux_amd64" && cp hcl2json_linux_amd64 /usr/local/bin/hcl2json && chmod +x /usr/local/bin/hcl2json && \
    curl -sOL "https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip" && unzip -q "terraform_${terraform_version}_linux_amd64.zip" && cp terraform /usr/local/bin/ && chmod +x /usr/local/bin/terraform

ADD terraform-repl /usr/local/bin/
RUN chmod +x /usr/local/bin/terraform-repl

ENTRYPOINT ["terraform-repl"]