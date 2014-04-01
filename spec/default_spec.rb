require 'chefspec'
require 'chefspec/berkshelf'

describe 'teamcity_server::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'include teamcity_server::server recipe' do
    expect(chef_run).to include_recipe('teamcity_server::server')
  end

  it 'include teamcity_server::build_agent recipe' do
    expect(chef_run).to include_recipe('teamcity_server::build_agent')
  end

  it 'include teamcity_server::plugins recipe' do
    expect(chef_run).to include_recipe('teamcity_server::plugins')
  end
end
