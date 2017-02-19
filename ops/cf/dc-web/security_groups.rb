## security groups for ssh (ingress will be populated by let-me-in)
resource 'sgssh', 'AWS::EC2::SecurityGroup' do
  group_description 'SSH access'
  vpc_id Fn::ref(:vpcid)
  tag :Name, Fn::ref('AWS::StackName')
  security_group_egress [
    { CidrIp: '0.0.0.0/0', IpProtocol: '-1', FromPort: 0, ToPort: 0 }
  ]
end