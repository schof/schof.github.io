resource :iamrole, 'AWS::IAM::Role' do
  path '/dc/'
  assume_role_policy_document(
    Version: '2012-10-17',
    Statement: [
      {
        Effect: 'Allow',
        Principal: {
          Service: 'ec2.amazonaws.com'
        },
        Action: 'sts:AssumeRole'
      }
    ]
  )
  managed_policy_arns [
    'arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM',   # SSM for deploys
    'arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly', # pull docker images
  ]
end

## need this for launch config to reference
resource :iamprofile, 'AWS::IAM::InstanceProfile' do
  path '/dc/'
  roles [Fn::ref(:iamrole)]
end