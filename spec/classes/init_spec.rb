require 'spec_helper'

describe 'postfix' do
  context 'with defaults for all parameters on RedHat' do
    let :facts do
      {
        :kernel   => 'Linux',
        :osfamily => 'RedHat',
      }
    end
    it { should contain_class('postfix') }
  end
end
