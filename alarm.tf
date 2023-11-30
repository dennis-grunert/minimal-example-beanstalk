resource "aws_cloudwatch_metric_alarm" "loadbalancer_high5xx" {
  alarm_name                = "test-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  alarm_description         = "Test Alarm"

  metric_query {
    id          = "m1"
    return_data = true

    metric {
      metric_name = "HTTPCode_Target_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = 60
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = data.aws_lb.beanstalk_lb.arn_suffix
      }
    }
  }
}

data "aws_lb" "beanstalk_lb" {
  arn = aws_elastic_beanstalk_environment.test.load_balancers[0]
}