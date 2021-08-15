#launch configuration for webapp-asg
resource "aws_launch_configuration" "webapp-asg" {
  name = "webapp-asg"
  image_id = "ami-0e9311b85387ca953"
  instance_type = "t2.medium"
  security_groups = [aws_security_group.signeasy_webapp_sg.id]
  iam_instance_profile = "EC2-CodeDeploy"
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = "true"
  }
  lifecycle {
    create_before_destroy = true
  } 
}

#Autoscalling group for webapp
resource "aws_autoscaling_group" "webapp-asg" {
  name = "webapp-asg"
  vpc_zone_identifier = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]
  desired_capacity   = 2
  max_size           = 4
  min_size           = 2
  health_check_type = "EC2"
  health_check_grace_period = 300
  launch_configuration = aws_launch_configuration.webapp-asg.id
  target_group_arns = [aws_lb_target_group.webapp-signeasy-cd-tg.arn]
  tag {
    key = "Name"
    value = "webapp.signeasy.com{AutoScale}"
    propagate_at_launch = "true"
  }
  
}

#launch configuration for API-ASG-2
resource "aws_launch_configuration" "api-asg-2-V3" {
  name = "api-asg-2-V3"
  image_id = "ami-07c15759a84f6690b"
  instance_type = "m4.xlarge"
  security_groups = [aws_security_group.signeasy_prod_int_sg.id]
  iam_instance_profile = "EC2-CodeDeploy"
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "60"
    delete_on_termination = "true"
  }
  lifecycle {
    create_before_destroy = true
  } 
}
#Autoscalling group for API-ASG-2
resource "aws_autoscaling_group" "API-ASG-2" {
  name = "API-ASG-2"
  vpc_zone_identifier = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]
  desired_capacity   = 2
  max_size           = 4
  min_size           = 2
  health_check_type = "ELB"
  health_check_grace_period = 300
  launch_configuration = aws_launch_configuration.api-asg-2-V3.id
  target_group_arns = [aws_lb_target_group.APIV4-TG-2.arn]
  tag {
    key = "Name"
    value = "api-v4-blue.signeasy.io-{AutoScale}"
    propagate_at_launch = "true"
  }
  
}

#Autoscalling group for api-v4-2-upload
resource "aws_autoscaling_group" "api-v4-2-upload" {
  name = "api-v4-2-upload"
  vpc_zone_identifier = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]
  desired_capacity   = 6
  max_size           = 6
  min_size           = 1
  health_check_type = "ELB"
  health_check_grace_period = 300
  launch_configuration = aws_launch_configuration.api-asg-2-V3.id
  target_group_arns = [aws_lb_target_group.api-v4-2-upload.arn]
  tag {
    key = "Name"
    value = "api-v4-blue.signeasy.io-{upload}"
    propagate_at_launch = "true"
  }
  
}

#launch configuration for API-ASG-2-internal
resource "aws_launch_configuration" "api-asg-2-internal-V1" {
  name = "api-asg-2-internal-V1"
  image_id = "ami-026daeaced62fbb14"
  instance_type = "m4.xlarge"
  security_groups = [aws_security_group.signeasy_prod_int_sg.id]
  iam_instance_profile = "EC2-CodeDeploy"
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "60"
    delete_on_termination = "true"
  }
  lifecycle {
    create_before_destroy = true
  } 
}
#Autoscalling group for API-ASG-2-internal
resource "aws_autoscaling_group" "API-ASG-2-internal" {
  name = "API-ASG-2-internal"
  vpc_zone_identifier = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]
  desired_capacity   = 3
  max_size           = 3
  min_size           = 2
  health_check_type = "ELB"
  health_check_grace_period = 300
  launch_configuration = aws_launch_configuration.api-asg-2-internal-V1.id
  target_group_arns = [aws_lb_target_group.API-V4-2-internal-TG.arn]
  tag {
    key = "Name"
    value = "api-v4-internal-blue.signeasy.io-{AutoScale}"
    propagate_at_launch = "true"
  }
  
}
#launch configuration for notifications-worker
resource "aws_launch_configuration" "notifications-worker-v3" {
  name = "notifications-worker-v3"
  image_id = "ami-0a59500592ec745dd"
  instance_type = "t2.large"
  security_groups = [aws_security_group.signeasy_prod_int_sg.id]
  iam_instance_profile = "EC2-CodeDeploy"
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  lifecycle {
    create_before_destroy = true
  } 
}
#Autoscalling group for notifications-worker
resource "aws_autoscaling_group" "notifications-worker" {
  name = "notifications-worker"
  vpc_zone_identifier = [data.aws_subnet.int_signeasy_sb2.id]
  desired_capacity   = 3
  max_size           = 3
  min_size           = 2
  health_check_type = "EC2"
  health_check_grace_period = 300
  launch_configuration = aws_launch_configuration.notifications-worker-v3.id
  tag {
    key = "Name"
    value = "notifications-emails-worker.signeasy.io-{AutoScale}"
    propagate_at_launch = "true"
  }
  
}

#launch configuration for preference-asg-01
resource "aws_launch_configuration" "preference-LC-V2" {
  name = "preference-LC-V2"
  image_id = "ami-0d7baa0370b232375"
  instance_type = "t2.medium"
  security_groups = [aws_security_group.signeasy_prod_int_sg.id]
  iam_instance_profile = "EC2-CodeDeploy"
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
  }
  lifecycle {
    create_before_destroy = true
  } 
}
#Autoscalling group for preference-asg-01
resource "aws_autoscaling_group" "preference-asg-01" {
  name = "preference-asg-01"
  vpc_zone_identifier = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  health_check_type = "EC2"
  health_check_grace_period = 300
  launch_configuration = aws_launch_configuration.preference-LC-V2.id
  target_group_arns = [aws_lb_target_group.preference-tg.arn]
  tag {
    key = "Name"
    value = "preference.signeasy.io-{AutoScale}"
    propagate_at_launch = "true"
  }
  
}
#launch configuration for website-asg
resource "aws_launch_configuration" "website-as-v4" {
  name = "website-as-v4"
  image_id = "ami-0412c7710efc1922e"
  instance_type = "t2.medium"
  security_groups = [aws_security_group.signeasy_prod_int_sg.id]
  iam_instance_profile = "EC2-CodeDeploy"
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = "true"
  }
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "gp2"
    volume_size = "80"
  }
  lifecycle {
    create_before_destroy = true
  } 
}
#Autoscalling group for website-asg
resource "aws_autoscaling_group" "website-asg" {
  name = "website-asg"
  vpc_zone_identifier = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2
  health_check_type = "EC2"
  health_check_grace_period = 300
  launch_configuration = aws_launch_configuration.website-as-v4.id
  target_group_arns = [aws_lb_target_group.signeasy-website-tg.arn]
  tag {
    key = "Name"
    value = "website.signeasy.com-{AutoScale}"
    propagate_at_launch = "true"
  }
  
}