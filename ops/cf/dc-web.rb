require 'coreos_ami'

description 'DumpComstock website stack'

## VPC stack to join for networking
parameter :vpc,       type: 'String',                      default: 'dc-vpc'
parameter :vpcid,     type: 'AWS::EC2::VPC::Id',           default: lookup_output(parameters[:vpc], 'VpcId')
parameter :cidr,      type: 'String',                      default: lookup_output(parameters[:vpc], 'Cidr')
parameter :subnetids, type: 'List<AWS::EC2::Subnet::Id>',  default: lookup_output(parameters[:vpc], 'SubnetIds')

## ECS cluster to join, name is a hack for now
# parameter :ecscluster, type: 'String', default: 'dc-vpc'

parameter :ami,       type: 'AWS::EC2::Image::Id',         default: CoreOS.channel('stable').ami
parameter :registry,  type: 'String',                      default: '232121879002.dkr.ecr.us-east-1.amazonaws.com'
parameter :alias,     type: 'String',                      default: 'dumpcomstock.com'
# parameter :domain,    type: 'String',                      default: parameters[:alias].split('.').last(2).join('.')

p parameters

include_template(
  'dc-web/iam.rb',
  'dc-web/security_groups.rb',
  'dc-web/elb.rb',
  # 'dc-web/log_group.rb',
  'dc-web/launch_config.rb',
  'dc-web/autoscaling.rb',
  # 'dc-web/route53.rb',
)