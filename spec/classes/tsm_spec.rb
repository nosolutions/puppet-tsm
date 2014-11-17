require 'spec_helper'

describe 'tsm' do

  ['RedHat', 'Solaris', 'Debian'].each do |system|

    let :facts do
      {
        :osfamily       => system,
        :kernelrelease  => '5.10',
        :hardwareisa    => 'i386',
        :concat_basedir => '/dne',
      }
    end

    let(:params) do
      {
        :tcp_server_address => 'tsm',
      }
    end

    it { should contain_class('tsm::install') }
    it { should contain_class('tsm::config') }
    it { should contain_class('tsm::service') }
  end

  context 'tsm::config with default options' do
    it do
      should contain_concat('/opt/tivoli/tsm/client/ba/bin/dsm.sys').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644'
      })
    end

    it do
      should contain_concat__fragment('dsm_sys_template').with({
        'target' => '/opt/tivoli/tsm/client/ba/bin/dsm.sys',
      })
    end

    it do
      should contain_concat__fragment('dsm_sys_local').with({
        'target' => '/opt/tivoli/tsm/client/ba/bin/dsm.sys',
        'source' => '/opt/tivoli/tsm/client/ba/bin/dsm.sys.local',
        'order'  => '02',
      })
    end

    it do
      should contain_file('/opt/tivoli/tsm/client/ba/bin/dsm.sys.local').with({
        'ensure'  => 'file',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644'
      })
    end

    it { should contain_concat__fragment('dsm_sys_local').that_requires('File[/opt/tivoli/tsm/client/ba/bin/dsm.sys.local]') }

    it do
      should contain_file('/opt/tivoli/tsm/client/ba/bin/InclExcl').with({
        'ensure'  => 'file',
        'replace' => 'false',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644'
      })
    end

    it do
      should contain_file('/opt/tivoli/tsm/client/ba/bin/InclExcl.local').with({
        'ensure'  => 'file',
        'replace' => 'false',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644'
      })
    end

    it do
      should_not contain_file('/opt/tivoli/tsm/client/ba/bin/dsm.opt').with({
        'ensure'  => 'file',
        'replace' => 'false',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644'
      })
    end

    context 'tsm::config with dsm.opt file' do

      config_opt_hash ={
        'key1' => 'val1',
        'key2' => 'val2',
        'key3' => 'val3',
      }

      describe 'should install tsm packages ' do
        let(:params) {{
          :tcp_server_address => 'tsm',
          :config_opt_hash    => config_opt_hash,
        }}

        it do
          should contain_file('/opt/tivoli/tsm/client/ba/bin/dsm.opt').with({
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0644'
          })

          config_opt_hash.each do |k,v|
            should contain_file('/opt/tivoli/tsm/client/ba/bin/dsm.opt').with_content(/#{k}( +)#{v}/)
          end

        end
      end
    end

    context 'on Redhat 6' do
      let :facts do
        {
          :osfamily                  => 'RedHat',
          :operatingsystemmajrelease => '6',
          :architecure               => 'i386',
          :concat_basedir            => '/dne',
        }
      end

      it do
        should contain_file('/opt/tivoli/tsm/client/ba/bin/InclExcl').with({
          'ensure'  => 'file',
          'replace' => 'false',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'source'  => 'puppet:///modules/tsm/InclExcl.redhat'
        })
      end
    end
    
    context 'on Debian 7' do
      let :facts do
        {
          :osfamily                  => 'Debian',
          :operatingsystemmajrelease => '7',
          :architecure               => 'i386',
          :concat_basedir            => '/dne',
        }
      end

      it do
        should contain_file('/opt/tivoli/tsm/client/ba/bin/InclExcl').with({
          'ensure'  => 'file',
          'replace' => 'false',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'source'  => 'puppet:///modules/tsm/InclExcl.debian'
        })
      end
    end

    context 'on Solaris' do
      let :facts do
        {
          :osfamily       => 'Solaris',
          :hardwareisa    => 'i386',
          :concat_basedir => '/dne',
        }
      end

      it do
        should contain_file('/opt/tivoli/tsm/client/ba/bin/InclExcl').with({
          'ensure'  => 'file',
          'replace' => 'false',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'source'  => 'puppet:///modules/tsm/InclExcl.solaris'
        })
      end
    end


  end

  context 'tsm::install on RedHat 6' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '6',
        :architecure               => 'i386',
        :concat_basedir            => '/dne',
      }
    end

    describe 'should install tsm packages ' do
      let(:params) do
        {
          :tcp_server_address => 'tsm',
        }
      end

      it { should contain_tsm__installpkg('TIVsm-BA').with_ensure('installed') }
    end

    describe 'should allow package_ensure to be overridden'do
      let(:params) do {
        :tcp_server_address => 'tsm',
        :package_ensure     => 'latest'
      }
      end

      it do
        should contain_tsm__installpkg('TIVsm-BA').with({
          :ensure => 'latest',
        })
      end
    end

    describe 'should allow package_name to be overridden'do
      let(:params) {{
        :tcp_server_address => 'tsm',
        :packages           => ['deadbeaf']
      }}

      it { should contain_tsm__installpkg("deadbeaf").with_ensure('installed') }
    end
  end


  context 'tsm::service on Redhat 6' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '6',
        :architecure               => 'i386',
        :concat_basedir            => '/dne',
      }
    end

    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::redhat')}
    end

    describe 'when tsm::service_manage is true' do
      let(:params) do
        {
          :tcp_server_address => 'tsm',
          :service_manage     => true,
        }
      end

      it { should contain_class('tsm::service::redhat')}

      it do
        should contain_file('/etc/init.d/dsmsched').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0755',
          'source'  => 'puppet:///modules/tsm/dsmsched.redhat'
        })
      end

      it do
        should contain_service('dsmsched').with({
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasstatus'  => 'true',
          'hasrestart' => 'true',
        })
      end

      it { should contain_service('dsmsched').that_requires('File[/etc/init.d/dsmsched]') }
    end

    describe 'when service_manage is true and set_intial_password is true' do
      let(:params) do
        {
          :tcp_server_address   => 'tsm',
          :service_manage       => true,
          :initial_password     => 'start',
          :set_initial_password => true,
        }
      end

      it do
        should contain_exec('generate-tsm.pwd').with({
          'creates' => '/etc/adsm/TSM.PWD',
          'path'    => ['/bin', '/usr/bin'],
        })
      end

      it { should contain_exec('generate-tsm.pwd').with_command(/dsmc set password start .*/) }

      it { should contain_service('dsmsched').that_requires('Exec[generate-tsm.pwd]') }

    end
  end
  
  context 'tsm::install on Debian 7' do
    let :facts do
      {
        :osfamily                  => 'Debian',
        :operatingsystemmajrelease => '7',
        :architecure               => 'i386',
        :concat_basedir            => '/dne',

      }
    end
    
    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::debian')}
    end

  end

  context 'tsm::install on Solaris 10 i386' do
    let :facts do
      {
        :osfamily       => 'Solaris',
        :kernelrelease  => '5.10',
        :hardwareisa    => 'i386',
        :concat_basedir => '/dne',

      }
    end

    it do
      should contain_tsm__installpkg('TIVsmCba').with({
       :uri       => /^http:\/\/.*/,
       :adminfile => '/var/sadm/install/admin/puppet',
      })
    end

    it do
      should contain_tsm__installpkg('TIVsmCapi').with({
        :uri       => /^http:\/\/.*/,
        :adminfile => '/var/sadm/install/admin/puppet',
      })
    end

    it { should contain_package('TIVsmCba').that_requires('Package[TIVsmCapi]') }
    it { should contain_package('TIVsmCapi').that_requires('Package[gsk8ssl64]') }
    it { should contain_package('gsk8ssl64').that_requires('Package[gsk8cry64]') }
    it { should contain_package('gsk8cry64').that_requires('Package[gsk8ssl32]') }
    it { should contain_package('gsk8ssl32').that_requires('Package[gsk8cry32]') }
  end

  context 'tsm::install on Solaris 10 sparc' do
    let :facts do
      {
        :osfamily       => 'Solaris',
        :kernelrelease  => '5.10',
        :hardwareisa    => 'sparc',
        :concat_basedir => '/dne',
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

    it { should contain_package('TIVsmCba').that_requires('Package[TIVsmCapi]') }
    it { should contain_package('TIVsmCapi').that_requires('Package[gsk8ssl64]') }
    it { should contain_package('gsk8ssl64').that_requires('Package[gsk8cry64]') }
   end

  context 'tsm::service on Solaris 10' do
    let :facts do
      {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
        :hardwareisa   => 'i386',
        :concat_basedir => '/dne',
      }
    end

    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::solaris')}
    end

    describe 'when tsm::service_manage is true' do
      let(:params) do
        {
          :tcp_server_address => 'tsm',
          :service_manage     => true,
        }
      end

      it { should contain_class('tsm::service::solaris')}

      it do
        should contain_file('/lib/svc/method/tsmsched').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0755',
          'replace' => 'true',
          'source'  => 'puppet:///modules/tsm/tsmsched.solaris'
        })
      end

      it do
        should contain_file('/var/svc/manifest/site/tsmsched.xml').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0444',
          'source'  => 'puppet:///modules/tsm/tsmsched.xml'
        })
      end

      it do
        should contain_service('tsm').with({
          'ensure'  => 'running',
          'enable'  => 'true',
          'manifest' => '/var/svc/manifest/site/tsmsched.xml'
        })
      end

      it { should contain_service('tsm').that_requires('File[/var/svc/manifest/site/tsmsched.xml]') }
      it { should contain_service('tsm').that_requires('File[/lib/svc/method/tsmsched]') }
    end

    describe 'when service_manage is true and set_intial_password is true' do
      let(:params) do
        {
          :tcp_server_address   => 'tsm',
          :service_manage       => true,
          :initial_password     => 'start',
          :set_initial_password => true,
        }
      end

      it do
        should contain_exec('generate-tsm.pwd').with({
          'creates' => '/etc/adsm/TSM.PWD',
          'path'    => ['/bin', '/usr/bin'],
        })
      end

      it { should contain_exec('generate-tsm.pwd').with_command(/dsmc set password start .*/) }

      it { should contain_service('tsm').that_requires('Exec[generate-tsm.pwd]') }
    end
  end
end
