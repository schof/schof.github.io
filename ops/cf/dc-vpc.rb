description 'VPC stack'

parameter :cidr, default: '10.0.0.0/16', description: 'CIDR block for VPC; should have no need to change this'

output :Cidr, Fn::ref(:cidr)

mappings(
  AZs: { ## need to know these in advance for loop on variable number of subnets
    'us-east-1' => { az: %w(us-east-1a us-east-1b us-east-1d us-east-1e) },
    'us-west-2' => { az: %w(us-west-2a us-west-2b us-west-2c) },
  }
)

include_template(
  'dc-vpc/vpc.rb',
  'dc-vpc/subnets.rb',
  # 'vpc/security_groups.rb',
  # 'vpc/iam-packer.rb',
  # 'vpc/iam-ecs.rb',
)