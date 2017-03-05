resource :asg, 'AWS::AutoScaling::AutoScalingGroup' do
  VPCZoneIdentifier Fn::ref(:subnetids)
  launch_configuration_name Fn::ref(:lc)
  load_balancer_names [Fn::ref(:elb)]
  min_size 0
  max_size 3
  desired_capacity 1
  tag :Name, Fn::ref('AWS::StackName'), PropagateAtLaunch: true
end