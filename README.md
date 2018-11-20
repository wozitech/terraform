# WOZiTech terraform
WOZiTech Limited Terraform repo, for local and 'public cloud' provisioning for wit products

Using the [recommended structure](https://www.terraform.io/docs/enterprise/workspaces/repo-structure.html) for multiple environments:
* dev & test are local - KVM/libvirt
* acceptance & production - public (AWS) cloud

# dependencies
Expects to read access key and secret from the local shared configuration file [$HOME/%HOME%]/.aws/credentials, but each environment excepts a profile name.