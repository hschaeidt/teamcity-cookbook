require File.expand_path("../support/helpers", __FILE__)

describe_recipe "teamcity_server::build_agent" do
  include Helpers::TeamcityServer

  it "configures teamcity build agent" do
    propertiesFile = file("/opt/TeamCity/buildAgent/conf/buildAgent.properties")
    propertiesFile.must_exist
    propertiesFile.must_match /^serverUrl=http:\/\/127\.0\.0\.1\/$/
    propertiesFile.must_match /^name=$/
    propertiesFile.must_match /^ownAddress=127\.0\.0\.1$/
    propertiesFile.must_match /^authorizationToken=$/
  end
end
