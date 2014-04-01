require 'chefspec'
require 'chefspec/berkshelf'

describe 'teamcity_server::server' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'include teamcity_server::common recipe' do
    expect(chef_run).to include_recipe('teamcity_server::common')
  end

  it 'create server.xml template' do
    expect(chef_run).to create_template("#{chef_run.node["teamcity_server"]["root_dir"]}/conf/server.xml")
  end

  it 'not create database.properties template' do
    expect(chef_run).not_to create_template("#{chef_run.node["teamcity_server"]["root_dir"]}/conf/database.properties")
  end

  it 'populate database attributes and create template' do
    pending 'no database.properties template defined'
    expect(chef_run).to create_template("#{chef_run.node["teamcity_server"]["root_dir"]}/conf/database.properties")
  end
end
