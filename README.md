# spaceship

> noun: spaceship; plural noun: spaceships,
a spacecraft, especially one controlled by a crew.

Server builder and launcher for terraform based projects.

Bake a base image with terraform, terragrunt and all the other necessary tools
preinstalled and fry in project code and secrets at launch time. Spaceship, is
a control center (server) for the infrastructure.


## Build

Building base machine involves baking all the common tools into the image.
Spaceship uses [packer](https://www.packer.io/) and
[puppet](https://puppet.com/) to bake-in all the ingredient tools and pack
into a machine image.

Read [build/README.md](build/README.md) for build configuration and setup
instructions.

## Launch

Launching spaceship involves frying the backed image with code, secrets,
etc, resulting in a ready to use, infrastructure control center. For launching,
spaceship uses [terraform](https://www.terraform.io/) and
[puppet](https://puppet.com/) to launch a server instance and provision with
customized needs.

Read [launch/README.md](launch/README.md) for launch configurations and setup
instructions.


## LICENSE

MIT
