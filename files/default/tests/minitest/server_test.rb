require "nokogiri"
require File.expand_path("../support/helpers", __FILE__)

describe_recipe "teamcity_server::server" do
  include Helpers::TeamcityServer

  it "configures teamcity server" do
    file("/opt/TeamCity/conf/server.xml").must_exist

    xml = Nokogiri::XML(File.read("/opt/TeamCity/conf/server.xml"))
    connector = xml.xpath("/Server/Service/Connector").first

    connector["address"].must_equal node["teamcity_server"]["server"]["address"].to_s
    connector["port"].must_equal node["teamcity_server"]["server"]["port"].to_s
  end
end
