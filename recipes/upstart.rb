
template "/etc/init/teamcity-server.conf" do
  source "upstart/teamcity-server.erb"
  owner  "root"
  group  "root"
  variables(
    :user => node["teamcity_server"]["user"],
    :group => node["teamcity_server"]["group"],
    :data_dir => node["teamcity_server"]["data_dir"],
    :root_dir => node["teamcity_server"]["root_dir"]
  )
end

template "/etc/init/teamcity-agent.conf" do
  source "upstart/teamcity-agent.erb"
  owner  "root"
  group  "root"
  variables(
    :user => node["teamcity_server"]["user"],
    :group => node["teamcity_server"]["group"],
    :data_dir => node["teamcity_server"]["data_dir"],
    :root_dir => node["teamcity_server"]["root_dir"]
  )
end
