# packer-build
> A Packer template, RHEL kickstart files and Ansible playbooks used for building Virtualbox VM templates (base boxes)

This repo contains a complete set of files used to create a Virtualbox VM template for use with Vagrant. The Packer template is designed to install the RHEL operating system on a Virtualbox VM and provision the base server using an Ansible playbook. Upon completion, Packer will package the resulting artifacts into the Vagrant box format in a designated directory.

Because of their size the RHEL ISO files are not provided and should be obtained from the Red Hat download site. 

![](header.png)

## Installation

OS X & Linux:

```sh
git clone https://github.com/scott-vick/packer-build.git packer-build
```

This clone will contain two subdirectories, vbox and iso. The vbox subdirectory contains the packer templates, kickstart files and ansible playbooks. 

The iso directory will be empty. Download the appropriate ISO files from Red Hat customer download site and place the downoaded ISO's in to the iso directory.

In the parent directory is a hidden file called ".set_env". Insert your Red Hat password that you will be using to subscribe your template build to the Red Hat Subscription Manager.

```sh
PKR_VAR_RHSMPassword='<Insert Password>'

export PKR_VAR_RHSMPassword
```

In the Packer template, modify the following lines to the correct directory being used by the Packer process:

```sh
variable "base_directory" {default = "/home/user1/packer/vbox"} # Example: /Users/macuser/packer-build/vbox
variable "iso_directory" {default = "/home/user1/packer/iso"} # Example: /Users/macuser/packer-build/iso

        output = "/home/user1/vagrant/boxes/{{ .Provider }}-rhel7.box"

        output = "/home/user1/vagrant/boxes/{{ .Provider }}-rhel8.box"

        output = "/home/user1/vagrant/boxes/{{ .Provider }}-rhel9.box"

```

Additionally, depending on the version of the Red Hat ISO you downloaded, it may be necessary to update the *iso_checksum* and *iso_url* lines to reflect the ISO you downloaded and its resulting checksum.

## Usage example

Once the environment source file and the templates have been updated you are ready to execute a build. In the provided example, you can build three VM's for RHEL 7, 8 and 9 all at one time:

First, validate the template is valid and that there are no issues with the template.

```sh
$ cd ~/packer-build
$ source .set_env
$ cd vbox
$ packer validate virtualbox-build.pkr.hcl  
```
Once validated, you can start the build process. The following example will build and provision all three OS templates.

```sh
$ packer build virtualbox-build.pkr.hcl 
```

To build a single template VM, use the **_-only_** flag (in this example we are only building the RHEL 8 template.)

```sh
$ packer build -only=virtualbox-iso.rhel8 virtualbox-build.pkr.hcl 
```

To build all of the templates **_EXCEPT_** specific ones, use the the **_-except_** flag (in this example we are building RHEL 7 and 8 templates and skipping the RHEL 9 template)

```sh
$ packer build -except=virtualbox-iso.rhel9 virtualbox-build.pkr.hcl 
```

_For more examples and usage, please refer to the [Wiki][wiki]._

## Release History

* 0.1.0
    * Added README to include instructions and information.
* 0.0.1
    * First release

## Meta

Scott Vick - joebloe144@me.com

Distributed under the MIT license. See ``LICENSE`` for more information.

## Contributing

1. Fork it (<https://github.com/scott-vick/packer-build>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

