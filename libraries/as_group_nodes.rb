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

      resp = asg_con.describe_auto_scaling_groups(
        :auto_scaling_group_names => ["#{autoscale_group}"])

      if resp[:auto_scaling_groups].length != 0
        group = resp[:auto_scaling_groups].first
        instances = group[:instances]
      else
        # if we got no instances using exact matche for group name
        # Try using the autoscale_group name as a wildcard
        all_asgs = asg_con.describe_auto_scaling_groups()
        found_asgs = []
        all_asgs[:auto_scaling_groups].each do |asgroup|
          if asgroup[:auto_scaling_group_name].include? autoscale_group
            found_asgs.push(asgroup)
          end
        end
        # Finding more than 1 autoscale group should result in an error
        if found_asgs.length == 1
          instances = found_asgs.first[:instances]
        elsif
          raise "Found multiple Auto Scale Groups matching #{autoscale_group}"
        else
          raise "No Auto Scale Groups match #{autoscale_group}"
        end
      end
      return instances
    end
end
