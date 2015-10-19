include_recipe "teamcity::common"

template "#{node["teamcity_server"]["root_dir"]}/conf/server.xml" do
  source "server.xml.erb"
  owner  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  variables(
    :address => node["teamcity_server"]["server"]["address"],
    :port    => node["teamcity_server"]["server"]["port"],
    :path => node["teamcity_server"]["server"]["path"],
    :docbase => node["teamcity_server"]["root_dir"]
  )
end

template "#{node["teamcity_server"]["root_dir"]}/conf/database.properties" do
  source "database.properties.erb"
  owner  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  variables(
    :database_connection_url => node["teamcity_server"]["server"]["database_connection_url"],
    :database_user => node["teamcity_server"]["server"]["database_user"],
    :database_pass => node["teamcity_server"]["server"]["database_pass"]
  )
  only_if { node["teamcity_server"]["server"]["database_internal"] == false }
end

# Install upstart file
template "/etc/init/teamcity-server.conf" do
  source "upstart/teamcity-server.erb"
  owner  "root"
  group  "root"
  variables(
      :user => node["teamcity_server"]["user"],
      :group => node["teamcity_server"]["group"],
      :server_opts => node["teamcity_server"]["server_opts"],
      :server_mem_opts => node["teamcity_server"]["server_mem_opts"],
      :prepare_script => node["teamcity_server"]["server_prepare_script"],
      :data_dir => node["teamcity_server"]["data_dir"],
      :root_dir => node["teamcity_server"]["root_dir"]
  )
end
