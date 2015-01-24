name             "teamcity"
maintainer       "Vyacheslav Slinko"
maintainer_email "vyacheslav.slinko@gmail.com"
license          "MIT"
description      "Installs TeamCity CI from JetBrains"
version          "0.2.2"

recipe "teamcity::build_agent", "Install TeamCity build agent"
recipe "teamcity::server", "Install TeamCity server"
recipe "teamcity::default", "Install TeamCity server and build agent"

depends 'apt',   '~> 2.0'
depends 'yum',   '~> 3.0'