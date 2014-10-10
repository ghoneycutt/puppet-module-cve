require 'spec_helper'
require 'pp'

describe 'cve' do

  context 'with defaults for all parameters' do
    it { should contain_class('cve') }
    it { should_not contain_notify('cve_vulnerabilities') }
  end

  describe 'with notify_vulnerabilities' do
    ['false',false].each do |value|
      context "set to #{value}" do
        let(:params) { { :notify_vulnerabilities => value } }

        it { should_not contain_notify('cve_vulnerabilities') }
      end
    end

    ['true',true].each do |value|
      context "set to #{value}" do
        context "and cve[vulnerable] empty" do
          let(:params) { { :notify_vulnerabilities => value } }
          let(:facts) { { :cve => { :vulnerable => nil } } }

          it { should_not contain_notify('cve_vulnerabilities') }
        end

        context "and cve[vulnerable] populated with cve's" do
          let(:params) { { :notify_vulnerabilities => value } }
          let(:facts) { { :cve => { 'vulnerable' => ['cve_1','cve_2'] } } }

          it { should contain_notify('cve_vulnerabilities') }
        end
      end
    end

    context 'set to an invalid type' do
      let(:params) { { :notify_vulnerabilities => ['invalid','type'] } }

      it 'should fail' do
        expect {
          should contain_class('cve')
        }.to raise_error(Puppet::Error)
      end
    end
  end
end
