require 'chefspec'
require 'chefspec/berkshelf'

describe 'teamcity_server::common' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  before do
    @archive_name = "TeamCity-#{chef_run.node["teamcity_server"]["version"]}.tar.gz"
    @full_url     = "#{chef_run.node["teamcity_server"]["base_url"]}#{@archive_name}"
    @archive      = "#{Chef::Config[:file_cache_path]}/#{@archive_name}"
  end

  it 'include java::default recipe' do
    expect(chef_run).to include_recipe('java::default')
  end

  it 'create teamcity group' do
    expect(chef_run).to create_group(chef_run.node["teamcity_server"]["group"])
  end

  it 'create teamcity user' do
    expect(chef_run).to create_user(chef_run.node["teamcity_server"]["group"])
  end

  it 'create root dir' do
    expect(chef_run).to create_directory(chef_run.node["teamcity_server"]["root_dir"])
  end

  it 'get teamcity archive' do
    expect(chef_run).to create_remote_file_if_missing(@archive)
  end

  it 'remote_file[archive] to notify execute[unarchive] to run' do
    r = chef_run.remote_file(@archive)
    expect(r).to notify('execute[unarchive]').to(:run)
  end
end
