include_recipe "teamcity_server::common"

template "#{node["teamcity_server"]["root_dir"]}/conf/server.xml" do
  source "server.xml.erb"
  owner  node["teamcity_server"]["user"]   
  group  node["teamcity_server"]["group"] 
  variables(
    :address => node["teamcity_server"]["server"]["address"],
    :port    => node["teamcity_server"]["server"]["port"]
  )
end
