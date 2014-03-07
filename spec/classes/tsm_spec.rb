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

    describe 'tsm::install RedHat 5' do
      it { should contain_package('TIVsm-BA').with_ensure('installed') }

      describe 'should allow package_ensure to be overridden'do
        let(:params) {{ :package_ensure => 'latest'}}

        it { should contain_package('TIVsm-BA').with_ensure('latest') }
      end

      describe 'should allow package_name to be overridden'do
        let(:params) {{ :tsm_packages => ['deadbeaf'] }}

        it { should contain_package('deadbeaf').with_ensure('installed') }
      end
    end

  end
end
