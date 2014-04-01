require 'chefspec'
require 'chefspec/berkshelf'

describe 'teamcity_server::build_agent' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['teamcity_server']['build_agents'] = {
        'buildAgent' => {},
        'buildAgent1' => {}
      }
    end.converge(described_recipe)
  end

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

  it 'create buildAgent.properties template for buildAgent' do
    expect(chef_run).to create_template("#{chef_run.node["teamcity_server"]["root_dir"]}/buildAgent/conf/buildAgent.properties")
  end

  it 'create buildAgent.properties template for buildAgent1' do
    expect(chef_run).to create_template("#{chef_run.node["teamcity_server"]["root_dir"]}/buildAgent1/conf/buildAgent.properties")
  end
end
