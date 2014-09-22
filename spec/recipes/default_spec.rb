require_relative '../spec_helper'

describe 'elasticsearch::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs a package with the elasticsearch' do
    expect(chef_run).to install_package('elasticsearch')
  end
end
