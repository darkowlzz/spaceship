# launch

Spaceship Launcher launches spaceships made using [Spaceship
Builder](spaceship/build/) and adds customization to the base spaceship,
including IAC repo and credentials.


## How it works?

1. Using the image created by builder as base image, terraform launches a
server with the specified configuration.
2. Using `terraform`'s provisioners, puppet files are uploaded to the server
under `/tmp/puppet/`.
3. Puppet clones given project repo and add secret file in the machine.


## Setup

* __Install [terraform](https://www.terraform.io/downloads.html)__

* __Add Instance Details__: Copy
[terraform.tfvars.sample](terraform.tfvars.sample) to `terraform.tfvars` and
add iam_instance_profile (with proper permissions), image ID, security group,
ssh key pair name and path to ssh private key. This is required to ssh into
the instance and run the provisioners.

* __Install Puppet Modules__: Terraform uploads puppet modules from local to
remote machine. This requires installation of puppet modules before running
terraform. Spaceship uses [librarian-puppet](http://librarian-puppet.com/) to
install puppet dependencies. Install librarian puppet and then run
`librarian-puppet install` in [manifests/](manifests/) directory. This would
install the puppet dependencies in `manifests/modules/` directory.

* Edit puppet configuration file
[manifests/hieradata/common.yaml](manifests/hieradata/common.yaml.sample)
and add repo to clone, repo path, aws-region, etc.

* __Private Key__: Spaceship used github deployment keys to clone project.
This requires adding a public deployment key in the repo of the project to
be cloned and adding the private key in `manifests/files/private_key` file.
Depending upon the use-case, the deployment key would have read & write
permissions.

* __Secrets__: Copy
[secrets.erb.sample](manifests/templates/secrets.erb.sample) to `secrets.erb`
and put the secrets that should be part of environment variables.


__NOTE__: __[ssh_config](manifests/files/ssh_config)__ file is added as
`.ssh/config` of the machine with `StrictHostKeyChecking` disabled for
`github.com`. This is done to skip host key check while cloning a repo for
for first time using ssh keys, else repo cloning fails.


## IAM Policy Permissions

Inshort, `AmazonEC2FullAccess` and `IAMFullAccess`.


## Running

Run terraform with `terraform apply`. It is recommended to `terraform plan`
and check the output before applying.
