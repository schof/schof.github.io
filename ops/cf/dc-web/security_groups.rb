## security groups for ssh (ingress will be populated by let-me-in)
resource :sgssh, 'AWS::EC2::SecurityGroup' do
  group_description 'SSH access'
  vpc_id Fn::ref(:vpcid)
  tag :Name, Fn::ref('AWS::StackName')
  security_group_egress [
    { CidrIp: '0.0.0.0/0', IpProtocol: '-1', FromPort: 0, ToPort: 0 }
  ]
end

## security group for http from internet to ELB
resource :sgelb, 'AWS::EC2::SecurityGroup' do
  group_description 'HTTP access to ELB from internet'
  vpc_id Fn::ref(:vpcid)
  tag :Name, Fn::ref('AWS::StackName')
  security_group_egress [
    { CidrIp: '0.0.0.0/0', IpProtocol: '-1', FromPort: 0, ToPort: 0 }
  ]
  security_group_ingress [
    { CidrIp: '0.0.0.0/0', IpProtocol: 'tcp', FromPort: 80,  ToPort: 80 },
    { CidrIp: '0.0.0.0/0', IpProtocol: 'tcp', FromPort: 443, ToPort: 443 }
  ]
end

## security group for http from ELB to instances
resource :sghttp, 'AWS::EC2::SecurityGroup' do
 group_description 'HTTP access from ELB to instances'
  vpc_id Fn::ref(:vpcid)
  tag :Name, Fn::ref('AWS::StackName')
  security_group_egress [
    { CidrIp: Fn::ref(:cidr), IpProtocol: 'tcp', FromPort: 0, ToPort: 0 }
  ]
end

## separate resource so we can point sg to itself
resource :sghttpingress, 'AWS::EC2::SecurityGroupIngress' do
  group_id Fn::ref(:sghttp)
  ip_protocol :tcp
  from_port 80
  to_port 80
  source_security_group_id Fn::ref(:sghttp)
end