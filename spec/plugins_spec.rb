require 'chefspec'
require 'chefspec/berkshelf'

describe 'teamcity_server::plugins' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set["teamcity_server"]["server"]["plugins"] = [{
        'name' => 'test1',
        'download_url' => 'http://test.com/test1.zip'
      }]
    end.converge(described_recipe)
  end

  it 'get test1 plugin' do
    expect(chef_run).to create_remote_file("#{chef_run.node["teamcity_server"]["server"]["plugins_dir"]}/test1.zip")
  end
end
