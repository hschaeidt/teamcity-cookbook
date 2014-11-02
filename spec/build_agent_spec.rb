require 'chefspec'
require 'chefspec/berkshelf'

describe 'teamcity::build_agent' do
  let(:chef_run) do
    File.stub(:directory?).and_call_original
    File.should_receive(:directory?).with("/opt/TeamCity/agents/buildAgent").and_return(true)
    ChefSpec::SoloRunner.new do |node|
      node.set['teamcity_server']['build_agents'] = {
        'buildAgent' => {},
        'buildAgent1' => {}
      }
    end.converge(described_recipe)
  end

  it 'include teamcity_server::common recipe' do
    expect(chef_run).to include_recipe('teamcity::common')
  end

  it 'update teamcity_server build_agent server attribute' do
    expect(chef_run.node['teamcity_server']['build_agent']['server']).to eq('127.0.0.1')
  end

  it 'create agents directory' do
    expect(chef_run).to create_directory("#{chef_run.node["teamcity_server"]["root_dir"]}/agents")
  end

  it 'not to create builAgent directory for buildAgent' do
    expect(chef_run).to_not run_execute("copy_buildAgent_to_buildAgent")
  end

  it 'not to create builAgent directory for buildAgent' do
    expect(chef_run).to run_execute("copy_buildAgent_to_buildAgent1")
  end

  it 'create buildAgent.properties template for buildAgent' do
    expect(chef_run).to create_template("#{chef_run.node["teamcity_server"]["root_dir"]}/agents/buildAgent/conf/buildAgent.properties")
  end

  it 'create buildAgent.properties template for buildAgent1' do
    expect(chef_run).to create_template("#{chef_run.node["teamcity_server"]["root_dir"]}/agents/buildAgent1/conf/buildAgent.properties")
  end
end
