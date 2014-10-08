
template "/etc/init/teamcity.conf" do
  source "upstart/teamcity.erb"
  owner  "root"
  group  "root"
  variables(
    :data_dir => node["teamcity_server"]["data_dir"],
    :root_dir => node["teamcity_server"]["root_dir"]
  )
end

template "/etc/init/teamcityagent.conf" do
  source "upstart/teamcityagent.erb"
  owner  "root"
  group  "root"
  variables(
    :data_dir => node["teamcity_server"]["data_dir"],
    :root_dir => node["teamcity_server"]["root_dir"]
  )
end
