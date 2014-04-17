include_recipe "teamcity_server::common"

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
