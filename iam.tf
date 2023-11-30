resource "aws_iam_instance_profile" "eb_ec2_instance_profile" {
  name = "test-elasticbeanstalk-ec2-profile"
  role = aws_iam_role.eb_ec2_instance_profile_role.name
}

resource "aws_iam_role" "eb_ec2_instance_profile_role" {
  name               = "test-elasticbeanstalk-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_assume_role_policy.json
}

data "aws_iam_policy_document" "ec2_instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}