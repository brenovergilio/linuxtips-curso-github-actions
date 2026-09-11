#!/usr/bin/env bash
set -euo pipefail

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