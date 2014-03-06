include_recipe "java"

archive_name = "TeamCity-#{node["teamcity_server"]["version"]}.tar.gz"
full_url     = "#{node["teamcity_server"]["base_url"]}#{archive_name}"
archive      = "/opt/#{archive_name}"

remote_file archive do
  backup false
  source full_url
  action :create_if_missing
  notifies :run, "execute[unarchive]", :immediately
end

execute "unarchive" do
  command "tar xf #{archive}"
  cwd "/opt"
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
