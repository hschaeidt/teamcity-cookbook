
node["teamcity_server"]["server"]["plugins"].each do | plugin |
	remote_file "#{node["teamcity_server"]["server"]["plugins_dir"]}/#{plugin['name']}.zip" do
	  owner node["teamcity_server"]["user"]
	  group node["teamcity_server"]["group"]   
	  mode "0644"
	  source plugin['download_url']
	end
end