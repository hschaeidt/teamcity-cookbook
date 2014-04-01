require 'chefspec'
require 'chefspec/berkshelf'

describe 'teamcity_server::build_agent' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'include teamcity_server::common recipe' do
    expect(chef_run).to include_recipe('teamcity_server::common')
  end

  it 'update teamcity_server build_agent server attribute' do
    expect(chef_run.node['teamcity_server']['build_agent']['server']).to eq('127.0.0.1')
  end

  context 'read buildAgent.properties file' do
    it 'should set the authorization_token variable' do
      pending 'stub File.readlines method'
    end

    it 'should set the build agent name attribute' do
      pending 'stub File.readlines method'
    end
  end

  it 'create buildAgent.properties template' do
    expect(chef_run).to create_template("#{chef_run.node["teamcity_server"]["root_dir"]}/buildAgent/conf/buildAgent.properties")
  end
end
