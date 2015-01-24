require 'chefspec'
require 'chefspec/berkshelf'

describe 'teamcity::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'include teamcity_server::server recipe' do
    expect(chef_run).to include_recipe('teamcity::server')
  end

  it 'include teamcity_server::build_agent recipe' do
    expect(chef_run).to include_recipe('teamcity::build_agent')
  end

  it 'include teamcity_server::plugins recipe' do
    expect(chef_run).to include_recipe('teamcity::plugins')
  end
end
