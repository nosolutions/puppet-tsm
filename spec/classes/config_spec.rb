require 'spec_helper'

describe 'tsm::config' do
  on_supported_os.each do |os, facts|

    tsm_class = <<-EOS
    class { tsm:
      tcp_server_address => "127.0.0.1",
      config_hash => { "key" => "value" },
    }
    EOS

    let(:pre_condition) { tsm_class }
    context "on #{os}" do
      let(:facts) { facts }
      it { is_expected.to compile.with_all_deps }
      it { should contain_concat__fragment('dsm_sys_template').with_content(/^\s+key\s+value/) }
    end
  end
end
