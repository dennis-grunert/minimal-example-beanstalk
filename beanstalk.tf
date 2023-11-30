resource "aws_elastic_beanstalk_application" "test" {
  name        = "test-application"
  description = "Test Application"
}

resource "aws_elastic_beanstalk_environment" "test" {
  name                = "test-environment"
  application         = aws_elastic_beanstalk_application.test.name
  solution_stack_name = "64bit Amazon Linux 2 v3.6.4 running Docker"
  tier                = "WebServer"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = local.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = local.subnet_ids
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_ec2_instance_profile.name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.switch_instance_type ? "t3.nano" : "t3.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
}