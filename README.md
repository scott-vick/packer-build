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
variable "base_directory" {default = "/home/user1/packer/vbox"}
variable "iso_directory" {default = "/home/user1/packer/iso"}

        output = "/home/user1/vagrant/boxes/{{ .Provider }}-rhel7.box"

        output = "/home/user1/vagrant/boxes/{{ .Provider }}-rhel8.box"

        output = "/home/user1/vagrant/boxes/{{ .Provider }}-rhel9.box"

```
## Usage example

A few motivating and useful examples of how your product can be used. Spice this up with code blocks and potentially more screenshots.

_For more examples and usage, please refer to the [Wiki][wiki]._

## Development setup

Describe how to install all development dependencies and how to run an automated test-suite of some kind. Potentially do this for multiple platforms.

```sh
make install
npm test
```

## Release History

* 0.2.1
    * CHANGE: Update docs (module code remains unchanged)
* 0.2.0
    * CHANGE: Remove `setDefaultXYZ()`
    * ADD: Add `init()`
* 0.1.1
    * FIX: Crash when calling `baz()` (Thanks @GenerousContributorName!)
* 0.1.0
    * The first proper release
    * CHANGE: Rename `foo()` to `bar()`
* 0.0.1
    * Work in progress

## Meta

Your Name – [@YourTwitter](https://twitter.com/dbader_org) – YourEmail@example.com

Distributed under the XYZ license. See ``LICENSE`` for more information.

[https://github.com/yourname/github-link](https://github.com/dbader/)

## Contributing

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

<!-- Markdown link & img dfn's -->
[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[wiki]: https://github.com/yourname/yourproject/wiki
