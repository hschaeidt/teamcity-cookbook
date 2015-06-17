group node["teamcity_server"]["group"] do
  action :create
end

user node["teamcity_server"]["user"] do
  action :create
  supports :manage_home => true
  gid node["teamcity_server"]["group"]
  home node["teamcity_server"]["home_dir"]
  shell "/bin/bash"
end

directory node["teamcity_server"]["root_dir"] do
  owner  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  mode "0755"
  action :create
end

directory node["teamcity_server"]["data_dir"] do
  owner  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  mode "0755"
  action :create
end

directory "#{node["teamcity_server"]["data_dir"]}/config" do
  owner  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  mode "0755"
  action :create
end

archive_name = "TeamCity-#{node["teamcity_server"]["version"]}.tar.gz"
full_url     = "#{node["teamcity_server"]["base_url"]}#{archive_name}"
archive      = node["teamcity_server"]["archive_path"].nil? ? "#{Chef::Config[:file_cache_path]}/#{archive_name}" : "#{node["teamcity_server"]["archive_path"]}/#{archive_name}"

remote_file archive do
  backup false
  source full_url
  owner  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  action :create_if_missing
  notifies :run, "execute[unarchive]", :immediately
end

execute "unarchive" do
  command "tar xf #{archive} --strip=1"
  user   node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  cwd node["teamcity_server"]["root_dir"]
  action :nothing
end

#create the logs dir after unarchiving in case we want to put it in there
directory node["teamcity_server"]["logs_dir"] do
  owner  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  mode "0755"
  action :create
end
