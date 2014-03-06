require 'spec_helper'

describe 'tsm' do
  describe 'Redhat 5 i386' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '5',
        :architecure               => 'i386'
      }
    end

    it { should contain_class('tsm::install') }
    it { should contain_class('tsm::config') }
    it { should contain_class('tsm::service') }

  end
end
