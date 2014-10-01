
directory node["teamcity_server"]["server"]["plugins_dir"] do
  owner  node["teamcity_server"]["user"]
  group  node["teamcity_server"]["group"]
  mode "0755"
  action :create
  recursive true
end

node["teamcity_server"]["server"]["plugins"].each do | plugin |
	remote_file "#{node["teamcity_server"]["server"]["plugins_dir"]}/#{plugin['name']}.zip" do
    backup false
	  owner node["teamcity_server"]["user"]
	  group node["teamcity_server"]["group"]
	  mode "0644"
	  source plugin['download_url']
    action :create_if_missing
	end
end
