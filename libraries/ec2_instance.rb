class Chef::Recipe::Jlaws

  def self.Ec2InstanceInfo(*args)
    return self.get_ec2_instance(*args)
  end

  def self.Ec2InstancePrivateIp(*args)
    instance =  self.get_ec2_instance(*args)
    return instance[:private_ip_address]
  end

  private
    def self.get_ec2_instance(instance_id,
                   aws_access_key_id = nil,
                   aws_secret_access_key = nil)
      if aws_access_key_id
        ec2_con = AWS::EC2::Client::V20140201.new(
            :access_key_id => aws_access_key_id,
            :secret_access_key => aws_secret_access_key)
      else
        ec2_con = AWS::EC2::Client::V20140201.new()
      end
      begin
        resp = ec2_con.describe_instances(:instance_ids => ["#{instance_id}"])
        instance = resp[:reservation_set].first[:instances_set].first
        return instance
      rescue AWS::EC2::Errors::InvalidInstanceID::NotFound
        raise "No instance #{instance_id}"
      end
    end
end
