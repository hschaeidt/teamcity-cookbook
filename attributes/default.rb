default["teamcity_server"]["version"]                           = "8.0.1"
default["teamcity_server"]["base_url"]                          = "http://download.jetbrains.com/teamcity/"
default["teamcity_server"]["build_agent"]["server"]             = nil
default["teamcity_server"]["build_agent"]["name"]               = nil
default["teamcity_server"]["build_agent"]["search_query"]       = "role\:teamcity_server"
default["teamcity_server"]["build_agent"]["server_url"]         = nil
default["teamcity_server"]["server"]["address"]                 = "0.0.0.0"
default["teamcity_server"]["server"]["port"]                    = 8111
default["teamcity_server"]["root_dir"]                          = "/opt/TeamCity"
default["teamcity_server"]["user"]                              = "teamcity"
default["teamcity_server"]["group"]                             = "teamcity"

default["teamcity_server"]["server"]["database_connection_url"] = nil
default["teamcity_server"]["server"]["database_user"]           = "teamcity"
default["teamcity_server"]["server"]["database_pass"]           = "teamcity"
default["teamcity_server"]["server"]["plugins"]                 = []
default["teamcity_server"]["server"]["plugins_dir"]             = node["teamcity_server"]["root_dir"]+'/.BuildServer/plugins/'
default["teamcity_server"]["server"]["path"]                    = nil
