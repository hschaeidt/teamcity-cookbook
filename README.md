# Description

Installs TeamCity CI from JetBrains.

# Requirements

## Cookbooks

* bluepill
* java

# Attributes

Used by both recipes:

* `node["teamcity_server"]["version"]` - TeamCity version. node is `7.1.4`.

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

* build_agent.rb: Installs TeamCity Build Agent. Usually should be extended.
* server.rb: Installs TeamCity Server.
