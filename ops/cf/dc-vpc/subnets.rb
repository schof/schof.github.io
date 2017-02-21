require 'ipaddress'

## get class C subnets for our cidr
subnets = IPAddress(parameters[:cidr]).subnet(24)

@subnets = self[:Mappings][:AZs][ENV['AWS_REGION']][:az].each_with_index.map do |zone, i|
  "subnet#{i}".tap do |id|
    resource id, 'AWS::EC2::Subnet' do
      availability_zone zone
      cidr_block subnets[i].to_string
      vpc_id Fn::ref(:vpc)
      tag :Name, Fn::ref('AWS::StackName')
    end

    resource "rt#{id}", 'AWS::EC2::SubnetRouteTableAssociation', DependsOn: [id] do
      subnet_id Fn::ref(id)
      route_table_id Fn::ref(:routetable)
    end
  end
end

output :SubnetIds, Fn::join(',', @subnets.map(&Fn.method(:ref)))