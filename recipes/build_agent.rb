include_recipe "teamcity_server::common"

unless Chef::Config[:solo]
  unless node["teamcity_server"]["build_agent"]["server"]
    server_node = search(:node, "recipes:teamcity_server\\:\\:server").first

    if server_node
      node.default["teamcity_server"]["build_agent"]["server"] = server_node["ipaddress"]
    end
  end
end

if node["teamcity_server"]["build_agent"]["server"].nil?
  node.default["teamcity_server"]["build_agent"]["server"] = node["ipaddress"]
end

properties_file     = "#{node["teamcity_server"]["root_dir"]}/buildAgent/conf/buildAgent.properties"
server              = node["teamcity_server"]["build_agent"]["server"]
own_address         = node["ipaddress"]
authorization_token = nil

if server == own_address
  server = own_address = "127.0.0.1"
end

if File.exists?(properties_file)
  lines = File.readlines(properties_file).grep(/^authorizationToken=/)

  unless lines.empty?
    match = /authorizationToken=([0-9a-f]+)/.match(lines.first)
    authorization_token = match[1] if match
  end

  unless node["teamcity_server"]["build_agent"]["name"]
    lines = File.readlines(properties_file).grep(/^name=/)

    unless lines.empty?
      match = /name=(.+)/.match(lines.first)
      node.default["teamcity_server"]["build_agent"]["name"] = match[1].strip if match
    end
  end
end

template properties_file do
  source "buildAgent.properties.erb"
  owner  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  variables(
    :server_address      => server,
    :name                => node["teamcity_server"]["build_agent"]["name"],
    :own_address         => own_address,
    :authorization_token => authorization_token
  )
end


