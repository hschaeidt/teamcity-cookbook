include_recipe "teamcity_server::common"

template "/opt/TeamCity/conf/server.xml" do
  source "server.xml.erb"
  variables(
    :address => node["teamcity_server"]["server"]["address"],
    :port    => node["teamcity_server"]["server"]["port"]
  )
end
