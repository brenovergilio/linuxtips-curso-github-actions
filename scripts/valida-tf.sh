#!/usr/bin/env bash
set -euo pipefail

### Configuração do Terraform
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y && sudo apt install terraform -y
###

cd ./iac/

echo "::group::Terraform Initialization"
terraform init -backend=false
echo "::endgroup::"

echo "::add-mask::${AWS_ACCESS_KEY_ID:-LINUXTIPSTRIGUSGIRUS}"

if terraform validate -no-color; then
    echo "::notice::Terraform initialization succeeded"
    echo "tf_result=success" >> $GITHUB_OUTPUT
else
    echo "::error file=ec2.tf,line=1,col=1::Terraform validation failed"
    echo "tf_result=failure" >> $GITHUB_OUTPUT
    exit 1
fi

echo "::warning::Remember to run 'terraform fmt -check' in a separate step"