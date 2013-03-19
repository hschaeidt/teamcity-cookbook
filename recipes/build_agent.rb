include_recipe "teamcity_server::common"

unless node["teamcity_server"]["build_agent"]["server"]
  server_node = search(:node, "recipes:teamcity_server\\:\\:server").first

  if server_node
    node.default["teamcity_server"]["build_agent"]["server"] = server_node["ipaddress"]
  end
end

unless node["teamcity_server"]["build_agent"]["server"]
  Chef::Application.fatal! "Undefined TeamCity server address"
end

properties_file     = "/opt/TeamCity/buildAgent/conf/buildAgent.properties"
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
  variables(
    :server_address      => server,
    :name                => node["teamcity_server"]["build_agent"]["name"],
    :own_address         => own_address,
    :authorization_token => authorization_token
  )
  notifies :restart, "bluepill_service[teamcity-build-agent]"
end

template "#{node["bluepill"]["conf_dir"]}/teamcity-build-agent.pill" do
  source "teamcity-build-agent.pill.erb"
end

bluepill_service "teamcity-build-agent" do
  action [:enable, :load, :start]
end
