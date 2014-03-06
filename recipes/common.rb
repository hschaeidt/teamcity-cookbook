include_recipe "java"

archive_name = "TeamCity-#{node["teamcity_server"]["version"]}.tar.gz"
full_url     = "#{node["teamcity_server"]["base_url"]}#{archive_name}"
archive      = "#{Chef::Config[:file_cache_path]}/#{archive_name}"

directory node["teamcity_server"]["root_dir"] do
  owner  node["teamcity_server"]["user"]   
  group  node["teamcity_server"]["group"] 
  mode "0755"
  action :create
end

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

group "teamcity" do
	action :create
end

user "teamcity" do
	action :create
	gid "teamcity"
	home node["teamcity_server"]["root_dir"]  
	shell "/bin/bash"
end
