include_recipe "teamcity_server::common"

unless Chef::Config[:solo]
  unless node["teamcity_server"]["build_agent"]["server"]
    server_node = search(:node, node["teamcity_server"]["build_agent"]["search_query"]).first

    if server_node
      node.default["teamcity_server"]["build_agent"]["server"] = server_node["ipaddress"]
    end
  end
end

if node["teamcity_server"]["build_agent"]["server"].nil?
  node.default["teamcity_server"]["build_agent"]["server"] = node["ipaddress"]
end

# Create agents directory
directory "#{node["teamcity_server"]["root_dir"]}/agents" do
  user  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
end

# Convert attributes to hash for easier parsing
agent_defaults = JSON.parse(node["teamcity_server"]["build_agent"].to_json)

agents = if node["teamcity_server"]["build_agents"].nil?
  # If necessary, create a build_agents entry.
  { "buildAgent" => agent_defaults }
else
  # Convert attributes to hash for easier parsing
  JSON.parse(node["teamcity_server"]["build_agents"].to_json)
end
port = 9090
agents.each do |agent, p|
  properties          = agent_defaults.merge(p)
  properties_file     = "#{node["teamcity_server"]["root_dir"]}/agents/#{agent}/conf/buildAgent.properties"
  server              = properties["server"]
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

    unless properties["name"]
      lines = File.readlines(properties_file).grep(/^name=/)

      unless lines.empty?
        match = /name=(.+)/.match(lines.first)
        properties["name"] = match[1].strip if match
      end
    end
  end

  execute "copy_buildAgent_to_#{agent}" do
    command "cp -Rf #{node["teamcity_server"]["root_dir"]}/buildAgent #{node["teamcity_server"]["root_dir"]}/agents/#{agent}"
    user node["teamcity_server"]["user"]
    group node["teamcity_server"]["group"]
    not_if { File.directory?("#{node["teamcity_server"]["root_dir"]}/agents/#{agent}") }
  end

  template properties_file do
    source "buildAgent.properties.erb"
    owner  node["teamcity_server"]["user"]
    group  node["teamcity_server"]["group"]
    variables(
      :server_address      => server,
      :server_port         => node["teamcity_server"]["server"]["port"],
      :name                => properties["name"] || agent,
      :own_address         => own_address,
      :port                => properties["port"] || port,
      :authorization_token => authorization_token
    )
  end

  port += 1
end
