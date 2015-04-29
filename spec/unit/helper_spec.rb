require 'spec_helper'
require 'aws-sdk'


describe Helper do
  describe '#instance_running?' do
    let(:dummy_class) { Class.new { include Helper } }
    let(:response) {
      ec2c.stub_for(:describe_instance_status)
        resp.data[:instance_status_set] = [
          {
            :instance_id => 'id-111111',
            :instance_state => {
              :name => 'running'
            }
          }
        ]
    }

    let(:ec2c) { AWS::EC2::Client::V20130815.new }

    before {
      AWS.stub!
    }

    context 'when running' do
      let(:resp) { ec2c.stub_for(:describe_instance_status)
        resp.data[:instance_status_set] = [
          {
            :instance_id => 'id-111111',
            :instance_state => {
              :name => 'running'
            }
          }
        ]
      }
      #resp[:called] = 1
      it 'says the instance is started' do
        expect(ec2c.describe_instance_status).and_return(:resp)
        #expect(dummy_class.new.instance_running?('id-111111')).to be_true
      end
    end

    it 'is instance_stoping?' do
      expect(dummy_class.new.instance_stopping?('id-111111')).to be_true
    end

    it 'works?' do
      resp = ec2c.stub_for(:describe_instance_status)
    end
  end
end
