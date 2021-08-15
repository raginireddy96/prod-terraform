# application loadbalancer for webapp
resource "aws_lb" "webapp-signeasy-cd" {
  name               = "webapp-signeasy-cd"
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_elb_prod_sg_http.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.public_signeasy_sb2.id]

  tags = {
    Environment = "prod"
  }
}

#Target group for webapp-signeasy-cd loadbalancer
resource "aws_lb_target_group" "webapp-signeasy-cd-tg" {
  name     = "webapp-signeasy-cd-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  deregistration_delay = 50
  health_check {
    interval = 30
    path = "/"
    healthy_threshold = 5
    unhealthy_threshold = 2
  }

}
#  Listener for webapp loadbalancer
resource "aws_lb_listener" "webapp-listner-1" {
  load_balancer_arn = aws_lb.webapp-signeasy-cd.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

#  Listener for webapp loadbalancer
#resource "aws_lb_listener" "webapp-listner-2" {
 # load_balancer_arn = aws_lb.webapp-signeasy-cd.arn
  #port              = "443"
  #protocol          = "HTTPS"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:acm:us-east-1:445819549122:certificate/30af9795-90bb-4dbb-a441-d132862f942a"

  #default_action {
    #type             = "forward"
    #target_group_arn = aws_lb_target_group.webapp-signeasy-cd-tg.arn
  #}
#}
# application loadbalancer for api-v4-2
resource "aws_lb" "api-v4-2" {
  name               = "api-v4-2"
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_elb_prod_sg_http.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.public_signeasy_sb2.id]
  idle_timeout = 120

  tags = {
    Environment = "prod"
  }
}
# Target group for api-v4-2 loadbalancer
resource "aws_lb_target_group" "APIV4-TG-2" {
  name     = "APIV4-TG-2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/v4/health/"
    healthy_threshold = 2
    unhealthy_threshold = 6
  }

}
#  Listener for api-v4-2 loadbalancer
resource "aws_lb_listener" "api-v4-2-listner-1" {
  load_balancer_arn = aws_lb.api-v4-2.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:us-east-2:445819549122:certificate/b6ab3f49-f75a-4e20-8a5d-396470b31270"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.APIV4-TG-2.arn
    
  }
}
# Target group for api-v4-2 loadbalancer
resource "aws_lb_target_group" "api-v4-2-upload" {
  name     = "api-v4-2-upload"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/v4/health/"
    healthy_threshold = 5
    unhealthy_threshold = 2
  }

}

# application loadbalancer for api-v4-internal
resource "aws_lb" "api-v4-internal" {
  name               = "api-v4-internal"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_elb_prod_sg_http.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Environment = "prod"
  }
}
# Target group for api-v4-internal lb loadbalancer
resource "aws_lb_target_group" "API-V4-2-internal-TG" {
  name     = "API-V4-2-internal-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/v4/health/"
    healthy_threshold = 2
    unhealthy_threshold = 6
    timeout = 15
  }

}
#  Listener for api-v4-internal loadbalancer
resource "aws_lb_listener" "api-v4-internal-listner-1" {
  load_balancer_arn = aws_lb.api-v4-internal.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.API-V4-2-internal-TG.arn
    
  }
}
# application loadbalancer for preference-asg-01
resource "aws_lb" "preference" {
  name               = "preference"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Environment = "prod"
  }
}
# Target group for preference  loadbalancer
resource "aws_lb_target_group" "preference-tg" {
  name     = "preference-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

}
#  Listener for preference loadbalancer
resource "aws_lb_listener" "preference-listner-1" {
  load_balancer_arn = aws_lb.preference.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.preference-tg.arn
    
  }
}
# application loadbalancer for website
resource "aws_lb" "signeasy-website-elb" {
  name               = "signeasy-website-elb"
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_elb_prod_sg_http.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.public_signeasy_sb2.id]

  tags = {
    Environment = "prod"
  }
}
#Target group forsigneasy-website-elb loadbalancer
resource "aws_lb_target_group" "signeasy-website-tg" {
  name     = "signeasy-website-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  deregistration_delay = 60
  health_check {
    interval = 5
    path = "/blog/"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 2
    matcher = "204,200,301"
  }

}
#  Listener for signeasy-website-elb loadbalancer
resource "aws_lb_listener" "signeasy-website-elb-listner-1" {
  load_balancer_arn = aws_lb.signeasy-website-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.signeasy-website-tg.arn
    
  }
}

# application loadbalancer for notifications-api
resource "aws_lb" "notifications-api-elb" {
  name               = "notifications-api-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "notifications-api-elb"
    Environment = "prod"
  }
}
#Target group notifications-api-elb loadbalancer
resource "aws_lb_target_group" "notifications-api-tg" {
  name     = "notifications-api-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/notifications/health/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

}
 
#Target group attachment with notifications-api ec2 instances
resource "aws_lb_target_group_attachment" "notifications-api-attachment" {
  count = 2
  target_group_arn = aws_lb_target_group.notifications-api-tg.arn
  target_id        = element(aws_instance.notifications-api.*.id, count.index)
}
#  Listener for notifications-api-elb loadbalancer
resource "aws_lb_listener" "notifications-api-elb-listner-1" {
  load_balancer_arn = aws_lb.notifications-api-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.notifications-api-tg.arn
    
  }
}
# application loadbalancer for file-operation
resource "aws_lb" "file-operation-elb" {
  name               = "file-operation-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "file-operation-elb"
    Environment = "prod"
  }
}
#Target group file-operation-elb loadbalancer
resource "aws_lb_target_group" "file-operation-tg" {
  name     = "file-operation-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  deregistration_delay = 50
  health_check {
    interval = 30
    path = "/operation"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

}
#Target group attachment with file-operation ec2 instances
resource "aws_lb_target_group_attachment" "file-operation-attachment" {
  count = 2
  target_group_arn = aws_lb_target_group.file-operation-tg.arn
  target_id        = element(aws_instance.file-operation.*.id, count.index)
}
#  Listener for file-operation loadbalancer
resource "aws_lb_listener" "file-operation-elb-listner-1" {
  load_balancer_arn = aws_lb.file-operation-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.file-operation-tg.arn
    
  }
}
# application loadbalancer for file-system
resource "aws_lb" "preference-and-fs-service-api" {
  name               = "preference-and-fs-service-api"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = " preference-and-fs-service-api"
    Environment = "prod"
  }
}
#Target group preference-and-fs-service-api loadbalancer
resource "aws_lb_target_group" "preferences-and-fs-tg" {
  name     = "preferences-and-fs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

}
#Target group attachment with file-system ec2 instances
resource "aws_lb_target_group_attachment" "file-system-attachment" {
  count = 8
  target_group_arn = aws_lb_target_group.preferences-and-fs-tg.arn
  target_id        = element(aws_instance.filesystem.*.id, count.index)
}
#  Listener for preference-and-fs-service-api loadbalancer
resource "aws_lb_listener" "preference-and-fs-service-api-listner-1" {
  load_balancer_arn = aws_lb.preference-and-fs-service-api.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.preferences-and-fs-tg.arn
    
  }
}
# application loadbalancer for request-signature
resource "aws_lb" "request-signatures-elb" {
  name               = "request-signatures-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "request-signatures-elb"
    Environment = "prod"
  }
}
#Target group request-signatures loadbalancer
resource "aws_lb_target_group" "request-signatures-tg" {
  name     = "request-signatures-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/request_signatures/health/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with request-signature ec2 instances
resource "aws_lb_target_group_attachment" "request-signature-attachment" {
  count = 8
  target_group_arn = aws_lb_target_group.request-signatures-tg.arn
  target_id        = element(aws_instance.request-signatures.*.id, count.index)
}
#  Listener for request-signatures loadbalancer
resource "aws_lb_listener" "request-signatures-listner-1" {
  load_balancer_arn = aws_lb.request-signatures-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.request-signatures-tg.arn
    
  }
}
# application loadbalancer for aux-api
resource "aws_lb" "aux-api-elb" {
  name               = "aux-api-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "aux-api-elb"
    Environment = "prod"
  }
}
#Target group aux-api loadbalancer
resource "aws_lb_target_group" "aux-api-tg" {
  name     = "aux-api-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/health/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with aux-api ec2 instances
resource "aws_lb_target_group_attachment" "aux-api-attachment" {
  count = 2
  target_group_arn = aws_lb_target_group.aux-api-tg.arn
  target_id        = element(aws_instance.aux-api.*.id, count.index)
}
#  Listener for aux-api loadbalancer
resource "aws_lb_listener" "aux-api-listner-1" {
  load_balancer_arn = aws_lb.aux-api-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.aux-api-tg.arn
    
  }
}

# application loadbalancer for eagle
resource "aws_lb" "eagle-elb" {
  name               = "eagle-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "eagle-elb"
    Environment = "prod"
  }
}
#Target group eagle loadbalancer
resource "aws_lb_target_group" "eagle-tg" {
  name     = "eagle-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/vpp-ms-api/health"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with eagle ec2 instances
resource "aws_lb_target_group_attachment" "eagle-attachment" {
  count = 6
  target_group_arn = aws_lb_target_group.eagle-tg.arn
  target_id        = element(aws_instance.eagle.*.id, count.index)
}
#  Listener for eagle loadbalancer
resource "aws_lb_listener" "eagle-listner-1" {
  load_balancer_arn = aws_lb.eagle-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.eagle-tg.arn
    
  }
}

# application loadbalancer for archiving-api
resource "aws_lb" "archiving-api-elb" {
  name               = "archiving-api-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "archiving-api-elb"
    Environment = "prod"
  }
}
#Target group archiving-api loadbalancer
resource "aws_lb_target_group" "archiving-api-tg" {
  name     = "archiving-api-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/health/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with archiving-api ec2 instances
resource "aws_lb_target_group_attachment" "archiving-api-attachment" {
  count = 2
  target_group_arn = aws_lb_target_group.archiving-api-tg.arn
  target_id        = element(aws_instance.archiving-api.*.id, count.index)
}
#  Listener for archiving-api loadbalancer
resource "aws_lb_listener" "archiving-api-listner-1" {
  load_balancer_arn = aws_lb.archiving-api-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.archiving-api-tg.arn
    
  }
}
# application loadbalancer for plans-api
resource "aws_lb" "plans-api-elb" {
  name               = "plans-api-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "plans-api-elb"
    Environment = "prod"
  }
}
#Target group plans-api loadbalancer
resource "aws_lb_target_group" "plans-api-tg" {
  name     = "plans-api-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/plans/health/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with plans-api ec2 instances
resource "aws_lb_target_group_attachment" "plans-api-attachment" {
  count = 1
  target_group_arn = aws_lb_target_group.plans-api-tg.arn
  target_id        = element(aws_instance.plans-api.*.id, count.index)
}
#  Listener for plans-api loadbalancer
resource "aws_lb_listener" "plans-api-listner-1" {
  load_balancer_arn = aws_lb.plans-api-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.plans-api-tg.arn
    
  }
}
# application loadbalancer for ms-team
resource "aws_lb" "ms-team-elb" {
  name               = "ms-team-elb"
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_team_ext_sg.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.public_signeasy_sb2.id]

  tags = {
    Name = "ms-team-elb"
    Environment = "prod"
  }
}
#Target group ms-team loadbalancer
resource "aws_lb_target_group" "ms-teams-tg" {
  name     = "ms-teams-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  deregistration_delay = 120
  health_check {
    interval = 30
    path = "/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with ms-team ec2 instances
resource "aws_lb_target_group_attachment" "ms-team-attachment" {
  count = 2
  target_group_arn = aws_lb_target_group.ms-teams-tg.arn
  target_id        = element(aws_instance.ms-teams.*.id, count.index)
}
#  Listener for ms-team loadbalancer
resource "aws_lb_listener" "ms-team-listner-1" {
  load_balancer_arn = aws_lb.ms-team-elb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:us-east-2:445819549122:certificate/b6ab3f49-f75a-4e20-8a5d-396470b31270"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ms-teams-tg.arn
    
  }
}

# application loadbalancer for conversion-bcl8
resource "aws_lb" "conversion-bcl8-elb" {
  name               = "conversion-bcl8-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "conversion-bcl8-elb"
    Environment = "prod"
  }
}
#Target group conversion-bcl8 loadbalancer
resource "aws_lb_target_group" "conversion-bcl8-tg" {
  name     = "conversion-bcl8-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/conversion/index.php"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 15
  }

} 
#Target group attachment with conversion-bcl8 ec2 instances
resource "aws_lb_target_group_attachment" "conversion-bcl8-attachment" {
  count = 3
  target_group_arn = aws_lb_target_group.conversion-bcl8-tg.arn
  target_id        = element(aws_instance.conversion-BCL8.*.id, count.index)
}
#  Listener for conversion-bcl8 loadbalancer
resource "aws_lb_listener" "conversion-bcl8-listner-1" {
  load_balancer_arn = aws_lb.conversion-bcl8-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.conversion-bcl8-tg.arn
    
  }
}

# application loadbalancer for permissions
resource "aws_lb" "permissions-elb" {
  name               = "permissions-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.public_signeasy_sb2.id]

  tags = {
    Name = "permissions-elb"
    Environment = "prod"
  }
}
#Target group permissions loadbalancer
resource "aws_lb_target_group" "permissions-tg" {
  name     = "permissions-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/permissions/health/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with permissions ec2 instances
resource "aws_lb_target_group_attachment" "permissions-attachment" {
  count = 1
  target_group_arn = aws_lb_target_group.permissions-tg.arn
  target_id        = element(aws_instance.permissions.*.id, count.index)
}
#  Listener for permissions loadbalancer
resource "aws_lb_listener" "permissions-listner-1" {
  load_balancer_arn = aws_lb.permissions-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.permissions-tg.arn
    
  }
}

# application loadbalancer for template
resource "aws_lb" "template-elb" {
  name               = "template-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "template-elb"
    Environment = "prod"
  }
}
#Target group template loadbalancer
resource "aws_lb_target_group" "template-tg" {
  name     = "template-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/admin/healthcheck"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with template ec2 instances
resource "aws_lb_target_group_attachment" "template-attachment" {
  count = 4
  target_group_arn = aws_lb_target_group.template-tg.arn
  target_id        = element(aws_instance.template.*.id, count.index)
}
#  Listener for template loadbalancer
resource "aws_lb_listener" "template-listner-1" {
  load_balancer_arn = aws_lb.template-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.template-tg.arn
    
  }
}
# application loadbalancer for users-ms
resource "aws_lb" "users-ms-elb" {
  name               = "users-ms-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]

  tags = {
    Name = "users-ms-elb"
    Environment = "prod"
  }
}
#Target group users-ms loadbalancer
resource "aws_lb_target_group" "users-ms-tg" {
  name     = "users-ms-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/users/health/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with new-user-ms-accounts ec2 instances
resource "aws_lb_target_group_attachment" "users-ms-attachment" {
  count = 2
  target_group_arn = aws_lb_target_group.users-ms-tg.arn
  target_id        = element(aws_instance.new-user-ms-accounts.*.id, count.index)
}
#  Listener for users-ms  loadbalancer
resource "aws_lb_listener" "users-ms-listner-1" {
  load_balancer_arn = aws_lb.users-ms-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.users-ms-tg.arn
    
  }
}

# application loadbalancer for api-v3
resource "aws_lb" "api-v2-v3-elb" {
  name               = "api-v2-v3-elb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_prod_int_sg.id]
  subnets            = [data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]
  idle_timeout = 120

  tags = {
    Name = "api-v2-v3-elb"
    Environment = "prod"
  }
}
#Target group api-v2-v3- loadbalancer
resource "aws_lb_target_group" "api-v2-v3-tg" {
  name     = "api-v2-v3-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 6
    path = "/health-index.php"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with api-v3 ec2 instances
resource "aws_lb_target_group_attachment" "api-v2-v3-attachment" {
  count = 2
  target_group_arn = aws_lb_target_group.api-v2-v3-tg.arn
  target_id        = element(aws_instance.api-v3.*.id, count.index)
}
#  Listener for api-v2-v3   loadbalancer
resource "aws_lb_listener" "api-v2-v3-listner-1" {
  load_balancer_arn = aws_lb.api-v2-v3-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.api-v2-v3-tg.arn
    
  }
}

# application loadbalancer for api-demo
resource "aws_lb" "api-demo-elb" {
  name               = "api-demo-elb"
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_elb_prod_sg_http.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.public_signeasy_sb2.id]
  
  tags = {
    Name = "api-demo-elb"
    Environment = "prod"
  }
}
#Target group api-demo loadbalancer
resource "aws_lb_target_group" "api-demo-tg" {
  name     = "api-demo-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 30
    path = "/elb-status"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with api-demo ec2 instances
resource "aws_lb_target_group_attachment" "api-demo-attachment" {
  count = 1
  target_group_arn = aws_lb_target_group.api-demo-tg.arn
  target_id        = element(aws_instance.api-demo.*.id, count.index)
}
#  Listener for api-demo  loadbalancer
resource "aws_lb_listener" "api-demo-listner-1" {
  load_balancer_arn = aws_lb.api-demo-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
    
  }
}
#  Listener for api-demo  loadbalancer
resource "aws_lb_listener" "api-demo-listner-2" {
  load_balancer_arn = aws_lb.api-demo-elb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:us-east-2:445819549122:certificate/b6ab3f49-f75a-4e20-8a5d-396470b31270"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.api-demo-tg.arn
    
  }
}

# application loadbalancer for dashboard
resource "aws_lb" "dashboard-elb" {
  name               = "dashboard-elb"
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.signeasy_elb_prod_sg_http.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.public_signeasy_sb2.id]
  
  tags = {
    Name = "dashboard-elb"
    Environment = "prod"
  }
}
#Target group dashboard loadbalancer
resource "aws_lb_target_group" "dashboard-tg" {
  name     = "dashboard-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.signeasy.id
  health_check {
    interval = 6
    path = "/check.mmi"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
  }

} 
#Target group attachment with dashboard  ec2 instances
resource "aws_lb_target_group_attachment" "dashboard-attachment" {
  count = 1
  target_group_arn = aws_lb_target_group.dashboard-tg.arn
  target_id        = element(aws_instance.dashboard.*.id, count.index)
}
#  Listener for dashboard  loadbalancer
resource "aws_lb_listener" "dashboard-listner-1" {
  load_balancer_arn = aws_lb.dashboard-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.dashboard-tg.arn
    
  }
}

# classic loadbalancer for developer-api
resource "aws_elb" "developer-api-elb" {
  name               = "developer-api-elb"
  internal           = "false"
  security_groups    = [aws_security_group.signeasy_elb_prod_sg_http.id]
  subnets            = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.public_signeasy_sb2.id]
  idle_timeout = 300
  #access_logs {
   # bucket        = "developer-api-dr"
   # bucket_prefix = "developer-api-dr"
   # interval      = 60
  #}
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "https"
    ssl_certificate_id = "arn:aws:acm:us-east-2:445819549122:certificate/b6ab3f49-f75a-4e20-8a5d-396470b31270"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 10
    target              = "HTTP:80/health"
    interval            = 20
  }
  
  tags = {
    Name = "developer-api-elb"
    Environment = "prod"
  }
}

#attaching api-ext ec2 instances with developer-api elb
resource "aws_elb_attachment" "developer-api" {
  count = 2
  elb      = aws_elb.developer-api-elb.id
  instance = element(aws_instance.api-ext.*.id, count.index)
}