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

  class Web < Stack
    include Asg, Elb, Ec2, Lmi, Keypair
    no_commands do
      def cfer_parameters
        {
          vpc: stack_prefix + 'vpc'
        }
      end
    end
  end
end