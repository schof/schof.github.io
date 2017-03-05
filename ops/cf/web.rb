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

include_template(
  'web/iam.rb',
  'web/security_groups.rb',
  'web/elb.rb',
  # 'dc-web/log_group.rb',
  'web/launch_config.rb',
  'web/autoscaling.rb',
  # 'dc-web/route53.rb',
)