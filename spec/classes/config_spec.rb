require 'spec_helper'

describe 'tsm::config' do
  on_supported_os.each do |os, facts|

    tsm_class = <<-EOS
    class { tsm:
      tcp_server_address => "127.0.0.1",
      config_hash => { "key" => "value" },
    }
    EOS

    context "on #{os}" do
      let(:pre_condition) { tsm_class }
      let(:facts) { facts }
      it { is_expected.to compile.with_all_deps }
      it { should contain_concat__fragment('dsm_sys_stanza_tsm').with_content(/^\s+key\s+value/) }
    end

    tsm_class_stanzas = <<-EOS
    class { tsm:
      stanzas => {
        'tsmserver1' => {
          'tcp_server_address' => "127.0.0.1",
          'config_hash' => { "key" => "value" },
        },
        'tsmserver2' => {
          'tcp_server_address' => "127.0.0.2",
          'config_hash' => { "other_key" => "other_value" },
        },
      }
    }
    EOS

    context "on #{os}" do
      let(:pre_condition) { tsm_class_stanzas }
      let(:facts) { facts }
      it { is_expected.to compile.with_all_deps }
      it { should contain_concat__fragment('dsm_sys_stanza_tsmserver1').with_content(/^\s+key\s+value/) }
      it { should contain_concat__fragment('dsm_sys_stanza_tsmserver2').with_content(/^\s+other_key\s+other_value/) }
    end


  end
end
