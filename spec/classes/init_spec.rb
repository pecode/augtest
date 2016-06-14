require 'spec_helper'
describe 'augtest' do
  context 'with default values for all parameters' do
    it { should contain_class('augtest') }
  end
end
