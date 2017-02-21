require 'erb'
require 'base64'

@user_data_yml = File.read(File.join(__dir__, 'user_data.yml'))

resource :lc, 'AWS::AutoScaling::LaunchConfiguration' do
  image_id Fn::ref(:ami)
  instance_type 't2.nano'
  key_name 'ric'
  security_groups [
    Fn::ref(:sgssh),
  ]
  associate_public_ip_address true
  block_device_mappings [
    {
      DeviceName: '/dev/xvda',
      Ebs: {
        VolumeSize: 32,
        VolumeType: 'gp2',
        DeleteOnTermination: true
      }
    }
  ]
  instance_monitoring true
  iam_instance_profile Fn::ref(:iamprofile)
  user_data Base64.encode64(ERB.new(@user_data_yml).result(binding))
end