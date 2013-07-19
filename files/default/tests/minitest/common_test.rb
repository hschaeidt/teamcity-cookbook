require File.expand_path("../support/helpers", __FILE__)

describe_recipe "teamcity_server::common" do
  include Helpers::TeamcityServer

  it "downloads teamcity archive" do
    file("/opt/TeamCity-#{node["teamcity_server"]["version"]}.tar.gz").must_exist
  end

  it "unarchives teamcity" do
    directory("/opt/TeamCity").must_exist
  end
end
