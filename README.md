# TeamCity Cookbook

[![Build Status](https://travis-ci.org/hschaeidt/teamcity-cookbook.svg)](https://travis-ci.org/hschaeidt/teamcity-cookbook)

# Requirements

* java

# Attributes

Used by both recipes:

* `node["teamcity_server"]["version"]` - TeamCity version. Default is `8.1.1`.
* `node["teamcity_server"]["base_url"]` - Base URL for TeamCity packages.
Default is `http://download.jetbrains.com/teamcity/`.
This value may also use FTP (ftp://) or local (file://) (e.g., a shared folder).

Used by Build Agent:

* `node["teamcity_server"]["build_agent"]["server"]` - TeamCity server address.
  Default value is `nil`. If value isn't changed then server is fist node with
  recipe `teamcity_server::server`.
* `node["teamcity_server"]["build_agent"]["name"]` - Build Agent name. Default
  is `nil`.

Used by Sever:

* `node["teamcity_server"]["server"]["address"]` - Address for listening.
  Default is `0.0.0.0`.
* `node["teamcity_server"]["server"]["port"]` — Port for listening. Default is
  `8111`.

## Recipes

This cookbook provides two recipes:

* build_agent.rb: Installs TeamCity Build Agent.
* server.rb: Installs TeamCity Server.
* default.rb: Installs TeamCity Server and TeamCity Build Agent.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## Developer requirements

### Required

* [chef-dk](https://downloads.getchef.com/chef-dk/) >= 0.3.2

The Chef-DK comes with all relevant chef tools, like berkshelf.

### Docker

* [docker](https://docs.docker.com/installation/#installation) >= 1.2.0
* [packer](https://www.packer.io/downloads.html) >= 0.7.2

```
$ #cookbooks will be vendored in ./berks-cookbooks
$ berks vendor
$
$ #create the docker image
$ packer build packer-docker.json
```

Run it: 
`$ docker run -v --publish 8111:8111 hschaeidt/teamcity`

Goto: http://localhost:8111

### Vagrant

* [virtualbox](https://www.virtualbox.org/wiki/Downloads) >= 4.2
* [vagrant](https://www.vagrantup.com/downloads.html) >= 1.5
* vagrant plugin vagrant-berkshelf >= 2.0.1
* vagrant plugin vagrant-omnibus >= 1.4.1

To install the vagrant plugins on their latest version:
`$ vagrant plugin install vagrant-berkshelf`
`$ vagrant plugin install vagrant-omnibus`

To start the machine:
`$ vagrant up`

Goto: http://localhost:8111