module Stax
  class Stack
    no_commands do
      def cfer_template
        File.join('cf', "#{class_name.downcase}.rb")
      end
    end
  end

  add_stack :vpc
  add_stack :web

  class Docker < Base

    no_commands do
      def registry
        @_registry ||= '232121879002.dkr.ecr.us-east-1.amazonaws.com'
      end

      def repository
        @_repository ||= "#{registry}/dumpcomstock"
      end
    end
  end

  class Web < Stack
    include Asg, Elb, Ec2, Lmi, Keypair, Ssm

    no_commands do
      def cfer_parameters
        {vpc: stack_prefix + 'vpc'}
      end
    end
  end
end