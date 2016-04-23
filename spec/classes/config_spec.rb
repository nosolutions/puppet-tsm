require 'spec_helper'

describe 'tsm::config' do
  on_supported_os.each do |os, facts|
    let(:pre_condition) { 'include tsm' }

    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
