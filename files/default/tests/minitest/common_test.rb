require File.expand_path("../support/helpers", __FILE__)

describe_recipe "teamcity_server::common" do
  include Helpers::TeamcityServer

  it "downloads teamcity archive" do
    assert ::File.exists? "/opt/TeamCity-#{node["teamcity_server"]["version"]}.tar.gz"
  end

  it "unarchives teamcity" do
    assert ::File.exists? "/opt/TeamCity"
    assert ::File.directory? "/opt/TeamCity"
  end
end
