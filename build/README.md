# build

Spaceship build involves baking various tools into a machine image.


## How it works?

1. Using packer, a server is launched with a basic version of ubuntu
(default) machine image.
2. Using packer's puppet-masterless provisioner, the server is provisioned
with a few tools. By default, `ntp`, `git`, `unzip`, `htop`, `ncdu`,
`terraform` and `terragrunt` are installed.
3. Once provisioned, packer creates a machine image of the machine and
terminates the server. Packer returns a machine image ID.


## Setup

* __Install [Packer](https://www.packer.io/downloads.html)__

* __Specifying image details__: Copy
[variables.json.sample](variables.json.sample) to `variables.json` and put
edit as per the requirements. Read [Packer Amazon AMI
Builder](https://www.packer.io/docs/builders/amazon.html) to learn how to
use environment variables and aws-cli tools.

* Edit terraform and terragrunt download links in
[manifests/hieradata/common.yaml](manifests/hieradata/common.yaml) to install
the latest version of the tools.

* __Install puppet modules__: Packer uploads puppet modules from local to
remote machine. This requires installation of puppet modules before running
packer. Spaceship uses [librarian-puppet](http://librarian-puppet.com/) to
install puppet dependencies. Install librarian puppet and then run
`librarian-puppet install` in [manifests/](manifests/) directory. This would
install the puppet dependencies in `manifests/modules/` directory.


## Running

If not using the default AWS profile, export `AWS_PROFILE` environment
variable with proper profile name.

Run packer with `packer build -var-file=variables.json basebox-aws.json`.
