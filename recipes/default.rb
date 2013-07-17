node.set["teamcity_server"]["build_agent"]["server"] = node["ipaddress"]

include_recipe "teamcity_server::server"
include_recipe "teamcity_server::build_agent"
