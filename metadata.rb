name             "teamcity"
maintainer       "Vyacheslav Slinko"
maintainer_email "vyacheslav.slinko@gmail.com"
license          "MIT"
description      "Installs TeamCity CI from JetBrains"
version          "0.2.2"

recipe "teamcity_server::build_agent", "Install TeamCity build agent"
recipe "teamcity_server::server", "Install TeamCity server"
recipe "teamcity_server::default", "Install TeamCity server and build agent"

depends "java"
