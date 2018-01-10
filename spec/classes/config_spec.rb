require 'spec_helper'

describe 'tsm::config' do
  on_supported_os.each do |os, facts|

    tsm_class = <<-EOS
    class { tsm:
      tcp_server_address => '127.0.0.1',
      tcp_port           => 1234,
      config_hash        => {
        'errorlogname'      => '/var/log/dsmerror.log',
        'errorlogretention' => '31 D',
        'schedlogname'      => '/var/log/dsmsched.log',
        'schedlogretention' => '30 d',
        'nodename'          => 'node01',
        'passwordaccess'    => 'generate',
        'domain'            => 'all-local',
        'makesparsefile'    => 'no',
      },
    }
    EOS


    context "on #{os} with class variable definitions" do
      let(:pre_condition) { tsm_class }
      let(:dsm_sys_fragment_tsm) { my_fixture_read('dsm_sys_fragment_tsm') }
      let(:facts) { facts }
      it { is_expected.to compile.with_all_deps }
      it { should contain_concat__fragment('dsm_sys_stanza_tsm').with_content(dsm_sys_fragment_tsm) }
    end

    tsm_class_stanzas = <<-EOS
    class { tsm:
      stanzas => {
        'tsmserver1' => {
          'tcp_server_address' => "127.0.0.1",
          'tcp_port'           => 1234,
          'config_hash'        => {
            'errorlogname'      => '/var/log/dsmerror.log',
            'errorlogretention' => '31 D',
            'schedlogname'      => '/var/log/dsmsched.log',
            'schedlogretention' => '30 d',
            'nodename'          => 'node01',
            'passwordaccess'    => 'generate',
            'domain'            => 'all-local',
            'makesparsefile'    => 'no',
          },
        },
        'tsmserver2' => {
          'tcp_server_address' => '127.0.0.2',
          'config_hash' => { 'other_key' => 'other_value' },
        },
      }
    }
    EOS

    context "on #{os} with stanza definitions" do
      let(:pre_condition) { tsm_class_stanzas }
      let(:dsm_sys_fragment_tsmserver1) { my_fixture_read('dsm_sys_fragment_tsmserver1') }
      let(:dsm_sys_fragment_tsmserver2) { my_fixture_read('dsm_sys_fragment_tsmserver2') }
      let(:facts) { facts }
      it { is_expected.to compile.with_all_deps }
      it { should contain_concat__fragment('dsm_sys_stanza_tsmserver1').with_content(dsm_sys_fragment_tsmserver1) }
      it { should contain_concat__fragment('dsm_sys_stanza_tsmserver2').with_content(dsm_sys_fragment_tsmserver2) }
    end

  end
end
