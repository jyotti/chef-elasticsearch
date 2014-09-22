require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe package('elasticsearch') do
    it { should be_installed }
end
