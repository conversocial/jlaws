class Chef::Recipe::Jlaws
  # Provides an Arrary of instances given an AutoScale Group Name
  #
  # == Parameters:
  # autoscale_group_name:
  #   A String of the Autoscale group's name in AWS
  #
  # == Returns:
  # :instances - (Array)
  #   :instance_id - (String)
  #   :availability_zone - (String)
  #   :lifecycle_state - (String)
  #   :health_status - (String)
  #   :launch_configuration_name - (String
  #
  def self.AsgNodes(*args)
    pow = self.aws_autoscale_instances(*args)
    return pow
  end

  private
    def self.aws_autoscale_instances(autoscale_group,
                   aws_access_key_id = nil,
                   aws_secret_access_key = nil)
      if aws_access_key_id
        asg_con = AWS::AutoScaling::Client::V20110101.new(
            :access_key_id => aws_access_key_id,
            :secret_access_key => aws_secret_access_key)
      else
        asg_con = AWS::AutoScaling::Client::V20110101.new()
      end
      begin
        resp = asg_con.describe_auto_scaling_groups(
          :auto_scaling_group_names => ["#{autoscale_group}"])

        group = resp[:auto_scaling_groups].first
        instances = group[:instances]
        return instances
      rescue AWS::AutoScaling::Errors::InvalidInstanceID::NotFound
        return 'notfound'
      end
    end
end
