module Helper
  def instance_running?(*args)
    state = ec2_instance_state(*args)
    state == 'running' ? true : false
  end

  def instance_stopped?(*args)
    state = ec2_instance_state(*args)
    state == 'stopped' ? true : false
  end

  def instance_stopping?(*args)
    state = ec2_instance_state(*args)
    state == 'stopping' ? true : false
  end

  def instance_terminated?(*args)
    state = ec2_instance_state(*args)
    state == 'terminated' ? true : false
  end

  private
    def ec2_instance_state(instance_id,
                   aws_access_key_id = nil,
                   aws_secret_access_key = nil)
      aws_region = 'us-east-1'
      if node.ec2
         aws_region = node.ec2.placement_availability_zone.chop
      end
      if aws_access_key_id
        ec2_con = AWS::EC2::Client::V20130815.new(
            :access_key_id => aws_access_key_id,
            :secret_access_key => aws_secret_access_key,
            :region => aws_region)
      else
        ec2_con = AWS::EC2::Client::V20130815.new(:region => aws_region)
      end
      begin
        resp = ec2_con.describe_instance_status(
          :instance_ids => ["#{instance_id}"],
          :include_all_instances => true)

        instance = resp[:instance_status_set].first
        state = instance[:instance_state][:name]
        return state
      rescue AWS::EC2::Errors::InvalidInstanceID::NotFound
        return 'notfound'
      end
    end
end
