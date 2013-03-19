include_recipe "teamcity_server::common"

template "/opt/TeamCity/conf/server.xml" do
  source "server.xml.erb"
  variables(
    :address => node["teamcity_server"]["server"]["address"],
    :port    => node["teamcity_server"]["server"]["port"]
  )
  notifies :restart, "bluepill_service[teamcity-server]"
end

template "#{node["bluepill"]["conf_dir"]}/teamcity-server.pill" do
  source "teamcity-server.pill.erb"
end

bluepill_service "teamcity-server" do
  action [:enable, :load, :start]
end
