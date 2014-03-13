require 'spec_helper'

describe 'tsm' do

  ['RedHat', 'Solaris'].each do |system|

    let :facts do
      {
        :osfamily      => system,
        :kernelrelease => '5.10'
      }
    end

    it { should contain_class('tsm::install') }
    it { should contain_class('tsm::config') }
    it { should contain_class('tsm::service') }
  end

  context 'tsm::install on RedHat 6' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '6',
        :architecure               => 'i386'
      }
    end

    it { should contain_tsm__installpkg('TIVsm-BA').with_ensure('installed') }

    describe 'should allow package_ensure to be overridden'do
      let(:params) {{ :package_ensure => 'latest'}}

      it do
        should contain_tsm__installpkg('TIVsm-BA').with({
                                                         'ensure' => 'latest',
                                                       })
      end
    end

    describe 'should allow package_name to be overridden'do
      let(:params) {{ :packages => ['deadbeaf'] }}

      it { should contain_tsm__installpkg("deadbeaf").with_ensure('installed') }
    end
  end


  context 'tsm::service on Redhat 6' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '6',
        :architecure               => 'i386'
      }
    end

    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::redhat')}
    end

    describe 'when tsm::service_manage is true' do
      let :params do
        { :service_manage => true }
      end
      it { should contain_class('tsm::service::redhat')}
    end
  end

  describe 'tsm::install on Solaris 10' do
    let :facts do
      {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      }
    end

    it do
      should contain_tsm__installpkg('TIVsmCba').with({
                                                         'uri'    => /^http:\/\/.*/,
                                                         'adminfile' => '/var/sadm/install/admin/puppet',
                                                       })
    end

    it do
      should contain_tsm__installpkg('TIVsmCapi').with({
                                                         'uri'    => /^http:\/\/.*/,
                                                         'adminfile' => '/var/sadm/install/admin/puppet',
                                                       })
    end
  end

  context 'tsm::service on Solaris 10' do
    let :facts do
      {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
        :architecure   => 'i386',
      }
    end

    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::redhat')}
    end

    describe 'when tsm::service_manage is true' do
      let :params do
        { :service_manage => true }
      end
      it { should contain_class('tsm::service::solaris')}
    end
  end
end
