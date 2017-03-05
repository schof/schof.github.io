resource :elb, 'AWS::ElasticLoadBalancing::LoadBalancer' do
  subnets Fn::ref(:subnetids)
  security_groups [
    Fn::ref(:sgelb),
    Fn::ref(:sghttp),
  ]
  listeners [
    {
      LoadBalancerPort: 80,
      InstancePort:     80,
      Protocol:         'HTTP',
      InstanceProtocol: 'HTTP',
    },
    # {
    #   LoadBalancerPort: 443,
    #   InstancePort:     80,
    #   Protocol:         'HTTPS',
    #   InstanceProtocol: 'HTTP',
    #   SSLCertificateId: Fn::ref(:cert)
    # }
  ]
  health_check(
    HealthyThreshold:   2,
    UnhealthyThreshold: 2,
    Timeout:            5,
    Target:             'HTTP:80/',
    Interval:           60
  )
end

output 'Elb', Fn::ref(:elb)