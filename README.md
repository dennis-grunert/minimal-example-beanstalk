Minimal Example to Reproduce a Bug in the Terraform AWS Provider
==

This minimal example written in Terraform shows an _inconsistent final plan_ for a CloudWatch alarm when a setting in the Beanstalk is changed.

# Steps to Reproduce
1. Set the local variables `vpc_id` and `subnet_ids` (comma-separated as string) in `main.tf` matching the VPC and subnet IDs of your AWS account.
2. Run `terraform init`.
3. Run `terraform apply`. An Elastic Beanstalk with application loadbalancer is created. Additionally, a CloudWatch alarm monitoring a specific metric for this loadbalancer is created.
4. Run `terraform apply -var='switch_instance_type=true'`. This only changes one setting (`InstanceType`) of the Beanstalk. The plan shows that "`data.aws_lb.beanstalk_lb` will be read during apply" and "`aws_cloudwatch_metric_alarm.loadbalancer_high5xx` will be updated in-place". The apply phase will not be successful with the "Error: Provider produced inconsistent final plan".
5. Do not forget to run `terrafrom destroy`.

This bug is reproducible with
* Terraform: v1.6.4
* AWS Provider: v5.28.0