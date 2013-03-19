include_recipe "bluepill"
include_recipe "java"

archive_name = "TeamCity-#{node["teamcity_server"]["version"]}.tar.gz"
archive      = "/opt/#{archive_name}"

remote_file archive do
  backup false
  source "http://download.jetbrains.com/teamcity/#{archive_name}"
  action :create_if_missing
  notifies :run, "execute[unarchive]", :immediately
end

execute "unarchive" do
  command "tar xf #{archive}"
  cwd "/opt"
  action :nothing
end
