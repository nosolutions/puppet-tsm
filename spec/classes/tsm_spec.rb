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
        'ensure'  => 'present',
        'replace' => false,
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644'
      })
    end

    it do
      should contain_concat__fragment('dsm_sys_header').with({
        'target' => '/opt/tivoli/tsm/client/ba/bin/dsm.sys',
      })
    end

    it do
      should contain_concat__fragment('dsm_sys_global').with({
        'target' => '/opt/tivoli/tsm/client/ba/bin/dsm.sys',
      })
    end

    it do
      should contain_concat__fragment('dsm_sys_stanza_tsm').with({
        'target' => '/opt/tivoli/tsm/client/ba/bin/dsm.sys',
      })
    end

  it do
      should contain_concat__fragment('dsm_sys_local').with({
        'target' => '/opt/tivoli/tsm/client/ba/bin/dsm.sys',
        'source' => '/opt/tivoli/tsm/client/ba/bin/dsm.sys.local',
        'order'  => '31',
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
      should contain_file('/opt/tivoli/tsm/client/ba/bin/dsm.opt').with_ensure('present')
    end

    context 'on AIX' do

      let :facts do
        {
          :osfamily      => 'AIX',
          :concat_basedir => '/dne',
        }
      end

      it do
        should contain_concat('/usr/tivoli/tsm/client/ba/bin64/dsm.sys').with({
          'ensure'  => 'present',
          'replace' => false,
          'owner'   => 'root',
          'group'   => 'system',
          'mode'    => '0644'
        })
      end

      it do
        should contain_concat__fragment('dsm_sys_header').with({
          'target' => '/usr/tivoli/tsm/client/ba/bin64/dsm.sys',
        })
      end

      it do
        should contain_concat__fragment('dsm_sys_global').with({
          'target' => '/usr/tivoli/tsm/client/ba/bin64/dsm.sys',
        })
      end

      it do
        should contain_concat__fragment('dsm_sys_stanza_tsm').with({
          'target' => '/usr/tivoli/tsm/client/ba/bin64/dsm.sys',
        })
      end

      it do
        should contain_concat__fragment('dsm_sys_local').with({
          'target' => '/usr/tivoli/tsm/client/ba/bin64/dsm.sys',
          'source' => '/usr/tivoli/tsm/client/ba/bin64/dsm.sys.local',
          'order'  => '31',
        })
      end

      it do
        should contain_file('/usr/tivoli/tsm/client/ba/bin64/dsm.sys.local').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'system',
          'mode'    => '0644'
        })
      end

      it { should contain_concat__fragment('dsm_sys_local').that_requires('File[/usr/tivoli/tsm/client/ba/bin64/dsm.sys.local]') }

      it do
        should contain_file('/usr/tivoli/tsm/client/ba/bin64/InclExcl').with({
          'ensure'  => 'file',
          'replace' => 'false',
          'owner'   => 'root',
          'group'   => 'system',
          'mode'    => '0644'
        })
      end

      it do
        should contain_file('/usr/tivoli/tsm/client/ba/bin64/InclExcl.local').with({
          'ensure'  => 'file',
          'replace' => 'false',
          'owner'   => 'root',
          'group'   => 'system',
          'mode'    => '0644'
        })
      end

      it do
        should_not contain_file('//usr/tivoli/tsm/client/ba/bin64/dsm.opt').with({
          'ensure'  => 'file',
          'replace' => 'false',
          'owner'   => 'root',
          'group'   => 'system',
          'mode'    => '0644'
        })
      end
    end

    context 'tsm::config with dsm.opt file' do
      config_opt_hash = {
        'key1' => 'val1',
        'key2' => 'val2',
        'key3' => 'val3',
        'key4' => [ 'val41', 'val42', ],
      }

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
          if v.is_a?(String)
            should contain_file('/opt/tivoli/tsm/client/ba/bin/dsm.opt').with_content(/#{k}\s+#{v}/)
          elsif v.is_a?(Array)
            v.each do |a|
              should contain_file('/opt/tivoli/tsm/client/ba/bin/dsm.opt').with_content(/#{k}\s+#{a}/)
            end
          else
            fail "value is neither String nor Array"
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
          :architecure               => 'amd64',
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

    context 'on AIX' do
      let :facts do
        {
          :osfamily                  => 'AIX',
          :concat_basedir            => '/dne',
        }
      end

      it do
        should contain_file('/usr/tivoli/tsm/client/ba/bin64/InclExcl').with({
          'ensure'  => 'file',
          'replace' => 'false',
          'owner'   => 'root',
          'group'   => 'system',
          'mode'    => '0644',
          'source'  => 'puppet:///modules/tsm/InclExcl.AIX'
        })
      end
    end

  end

  context 'tsm::config with config_replace set to true' do
    let(:params) do
      {
        :tcp_server_address => 'tsm',
        :config_replace => true,
      }
    end

    it do
      should_not contain_file('/opt/tivoli/tsm/client/ba/bin/dsm.opt').with({
          'ensure'  => 'file',
          'replace' => true,
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644'
        })
    end

    it do
        should contain_concat('/opt/tivoli/tsm/client/ba/bin/dsm.sys').with({
          'ensure'  => 'present',
          'replace' => true,
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644'
        })
    end

    context 'on AIX' do

      let :facts do
        {
          :osfamily                  => 'AIX',
          :concat_basedir            => '/dne',
        }
      end

      let(:params) do
        {
          :tcp_server_address => 'tsm',
          :config_replace => true,
        }
      end

      it do
        should_not contain_file('/usr/tivoli/tsm/client/ba/bin64/dsm.opt').with({
            'ensure'  => 'file',
            'replace' => true,
            'owner'   => 'root',
            'group'   => 'system',
            'mode'    => '0644'
          })
      end

      it do
          should contain_concat('/usr/tivoli/tsm/client/ba/bin64/dsm.sys').with({
            'ensure'  => 'present',
            'replace' => true,
            'owner'   => 'root',
            'group'   => 'system',
            'mode'    => '0644'
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
          'subscribe'  => 'Concat[/opt/tivoli/tsm/client/ba/bin/dsm.sys]',
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
  context 'tsm::service::dsmcad on Redhat 6' do
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
          :tcp_server_address    => 'tsm',
          :service_manage        => true,
          :service_script        => '/etc/init.d/dsmcad',
          :service_name          => 'dsmcad',
          :service_script_source => 'puppet:///modules/tsm/dsmcad.redhat',

        }
      end

      it { should contain_class('tsm::service::redhat')}

      it do
        should contain_file('/etc/init.d/dsmcad').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0755',
          'source'  => 'puppet:///modules/tsm/dsmcad.redhat'
        })
      end

      it do
        should contain_service('dsmcad').with({
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasstatus'  => 'true',
          'hasrestart' => 'true',
          'subscribe'  => 'Concat[/opt/tivoli/tsm/client/ba/bin/dsm.sys]',
        })
      end

      it { should contain_service('dsmcad').that_requires('File[/etc/init.d/dsmcad]') }
    end

    describe 'when service_manage is true and set_intial_password is true' do
      let(:params) do
        {
          :tcp_server_address    => 'tsm',
          :service_manage        => true,
          :initial_password      => 'start',
          :set_initial_password  => true,
          :service_script        => '/etc/init.d/dsmcad',
          :service_name          => 'dsmcad',
          :service_script_source => 'puppet:///modules/tsm/dsmcad.redhat',
        }
      end

      it do
        should contain_exec('generate-tsm.pwd').with({
          'creates' => '/etc/adsm/TSM.PWD',
          'path'    => ['/bin', '/usr/bin'],
        })
      end

      it { should contain_exec('generate-tsm.pwd').with_command(/dsmc set password start .*/) }

      it { should contain_service('dsmcad').that_requires('Exec[generate-tsm.pwd]') }

    end
  end


  context 'tsm::service::dsmcad on Redhat 7' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '7',
        :architecure               => 'i386',
        :concat_basedir            => '/dne',
        :service_script            => '/etc/systemd/system/dsmcad.service',
        :service_name              => 'dsmcad',
        :service_script_source     => 'puppet:///modules/tsm/dsmcad.redhat7',
      }
    end

    describe 'when tsm::service_manage is true' do
      let(:params) do
        {
          :tcp_server_address    => 'tsm',
          :service_manage        => true,
          :service_script        => '/etc/systemd/system/dsmcad.service',
          :service_name          => 'dsmcad',
          :service_script_source => 'puppet:///modules/tsm/dsmcad.redhat7',
        }
      end

      it { should contain_class('tsm::service::redhat')}

      it do
        should contain_file('/etc/systemd/system/dsmcad.service').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'source'  => 'puppet:///modules/tsm/dsmcad.redhat7'
        })
      end

      it do
        should contain_service('dsmcad').with({
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasstatus'  => 'true',
          'hasrestart' => 'true',
          'subscribe'  => 'Concat[/opt/tivoli/tsm/client/ba/bin/dsm.sys]',
        })
      end

      it { should contain_service('dsmcad').that_requires('File[/etc/systemd/system/dsmcad.service]') }
    end
  end

  context 'tsm::service on Redhat 7' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '7',
        :architecure               => 'i386',
        :concat_basedir            => '/dne',
      }
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
        should contain_file('/etc/systemd/system/dsmsched.service').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'source'  => 'puppet:///modules/tsm/dsmsched.redhat7'
        })
      end

      it do
        should contain_service('dsmsched').with({
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasstatus'  => 'true',
          'hasrestart' => 'true',
          'subscribe'  => 'Concat[/opt/tivoli/tsm/client/ba/bin/dsm.sys]',
        })
      end

      it { should contain_service('dsmsched').that_requires('File[/etc/systemd/system/dsmsched.service]') }
    end
  end

  context 'tsm::install on Debian 7' do
    let :facts do
      {
        :osfamily                  => 'Debian',
        :operatingsystemmajrelease => '7',
        :architecture              => 'amd64',
        :concat_basedir            => '/dne',

      }
    end

    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::debian')}
    end

    describe 'should install tsm packages ' do
      let(:params) do
        {
          :tcp_server_address => 'tsm',
        }
      end

      it { should contain_tsm__installpkg('tivsm-ba').with_ensure('installed') }
      it { should contain_tsm__installpkg('tivsm-api64').with_ensure('installed') }
      it { should contain_tsm__installpkg('gskcrypt64').with_ensure('installed') }
      it { should contain_tsm__installpkg('gskssl64').with_ensure('installed') }
    end

    describe 'should allow package_ensure to be overridden'do
      let(:params) do {
        :tcp_server_address => 'tsm',
        :package_ensure     => 'latest'
      }
      end

      it do
        should contain_tsm__installpkg('tivsm-api64').with({
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

  context 'tsm::service on Debian 7' do
    let :facts do
      {
        :osfamily                  => 'Debian',
        :operatingsystemmajrelease => '7',
        :architecture              => 'amd64',
        :concat_basedir            => '/dne',
      }
    end

    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::debian')}
    end

    describe 'when tsm::service_manage is true' do
      let(:params) do
        {
          :tcp_server_address => 'tsm',
          :service_manage     => true,
        }
      end

      it { should contain_class('tsm::service::debian')}

      it do
        should contain_file('/etc/init.d/dsmsched').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0755',
          'source'  => 'puppet:///modules/tsm/dsmsched.debian'
        })
      end

      it do
        should contain_service('dsmsched').with({
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasstatus'  => 'true',
          'hasrestart' => 'true',
          'subscribe'  => 'Concat[/opt/tivoli/tsm/client/ba/bin/dsm.sys]',
        })
      end

      it { should contain_service('dsmsched').that_requires('File[/etc/init.d/dsmsched]') }
    end
  end
  context 'tsm::service::dsmcad on Debian 7' do
    let :facts do
      {
        :osfamily                  => 'Debian',
        :operatingsystemmajrelease => '7',
        :architecture              => 'amd64',
        :concat_basedir            => '/dne',
      }
    end

    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::debian')}
    end

    describe 'when tsm::service_manage is true' do
      let(:params) do
        {
          :tcp_server_address    => 'tsm',
          :service_manage        => true,
          :service_script        => '/etc/init.d/dsmcad',
          :service_name          => 'dsmcad',
          :service_script_source => 'puppet:///modules/tsm/dsmcad.debian',
        }
      end

      it { should contain_class('tsm::service::debian')}

      it do
        should contain_file('/etc/init.d/dsmcad').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0755',
          'source'  => 'puppet:///modules/tsm/dsmcad.debian'
        })
      end

      it do
        should contain_service('dsmcad').with({
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasstatus'  => 'true',
          'hasrestart' => 'true',
          'subscribe'  => 'Concat[/opt/tivoli/tsm/client/ba/bin/dsm.sys]',
        })
      end

      it { should contain_service('dsmcad').that_requires('File[/etc/init.d/dsmcad]') }
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
          'ensure'    => 'running',
          'enable'    => 'true',
          'manifest'  => '/var/svc/manifest/site/tsmsched.xml',
          'subscribe' => 'Concat[/opt/tivoli/tsm/client/ba/bin/dsm.sys]',
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

  context 'tsm::service::dsmcad on Solaris 10' do
    let :facts do
      {
        :osfamily       => 'Solaris',
        :kernelrelease  => '5.10',
        :hardwareisa    => 'i386',
        :concat_basedir => '/dne',
      }
    end

    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::solaris')}
    end

    describe 'when tsm::service_manage is true' do
      let(:params) do
        {
          :tcp_server_address      => 'tsm',
          :service_manage          => true,
          :service_manifest        => '/var/svc/manifest/site/tsmcad.xml',
          :service_manifest_source => 'puppet:///modules/tsm/tsmcad.xml',
          :service_script          => '/lib/svc/method/tsmcad',
          :service_name            => 'tsm',
          :service_script_source   => 'puppet:///modules/tsm/tsmcad.solaris',
        }
      end

      it { should contain_class('tsm::service::solaris')}

      it do
        should contain_file('/lib/svc/method/tsmcad').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0755',
          'replace' => 'true',
          'source'  => 'puppet:///modules/tsm/tsmcad.solaris'
        })
      end

      it do
        should contain_file('/var/svc/manifest/site/tsmcad.xml').with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0444',
          'source'  => 'puppet:///modules/tsm/tsmcad.xml'
        })
      end

      it do
        should contain_service('tsm').with({
          'ensure'    => 'running',
          'enable'    => 'true',
          'manifest'  => '/var/svc/manifest/site/tsmcad.xml',
          'subscribe' => 'Concat[/opt/tivoli/tsm/client/ba/bin/dsm.sys]',
        })
      end

      it { should contain_service('tsm').that_requires('File[/var/svc/manifest/site/tsmcad.xml]') }
      it { should contain_service('tsm').that_requires('File[/lib/svc/method/tsmcad]') }
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

  context 'tsm::install on AIX' do
    let :facts do
      {
        :osfamily                  => 'AIX',
        :concat_basedir            => '/dne',

      }
    end

    let(:params) do
      {
        :tcp_server_address => 'tsm',
        :package_uri        => 'lpp_aix71tl3sp4',
      }
    end

    it do
      should contain_tsm__installpkg('tivoli.tsm.client.ba.64bit.base').with({
          'ensure'    => 'installed',
          'uri'       => 'lpp_aix71tl3sp4',
          'provider'  => 'nim',
        })
    end
  end

  context 'tsm::service on AIX' do
    let :facts do
      {
        :osfamily                  => 'AIX',
        :concat_basedir            => '/dne',
      }
    end

    describe 'when tsm::service_manage is false' do
      it { should_not contain_class('tsm::service::aix')}
    end

    describe 'when tsm::service_manage is true' do
      let(:params) do
        {
          :tcp_server_address => 'tsm',
          :service_manage     => true,
        }
      end

      it { should contain_class('tsm::service::aix')}

      it do
        should contain_exec('mkssys').with({
          'command'  => '/usr/bin/mkssys -s dsmsched -p /usr/bin/dsmc -u 0 -a "sched" -S -n 15 -f 9 -R -q',
          'unless'   => '/usr/bin/lssrc -s dsmsched'
        })
      end

      it do
        should contain_service('dsmsched').with({
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasstatus'  => 'true',
          'hasrestart' => 'false',
          'subscribe'  => 'Concat[/usr/tivoli/tsm/client/ba/bin64/dsm.sys]',
        })
      end

      it { should contain_service('dsmsched').that_requires('Exec[mkssys]') }
    end
  end

end
