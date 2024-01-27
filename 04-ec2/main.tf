module "mongodb" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-mongodb"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "mongodb"
    }
  )
}

module "redis" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-redis"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "redis"
    }
  )
}

module "mysql" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-mysql"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "mysql"
    }
  )
}

module "rabbitmq" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-rabbitmq"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "rabbitmq"
    }
  )
}

module "catalogue" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-catalogue"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "catalogue"
    }
  )
}

module "cart" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-cart"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.cart_sg_id.value]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "cart"
    }
  )
}

module "user" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-user"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.user_sg_id.value]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "user"
    }
  )
}

module "shipping" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-shipping"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.shipping_sg_id.value]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "shipping"
    }
  )
}

module "payments" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-payments"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.payments_sg_id.value]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "payments"
    }
  )
}

module "web" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${var.project_name}-web"
  instance_type          = "t2.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value]
  subnet_id              = local.public_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "web"
    }
  )
}

#creating route53 records
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name

  records = [
    {
      name    = "mongodb"
      type    = "A"
      ttl     = 1
      records = [
        "${module.mongodb.private_ip}"
      ]
    },
    {
      name    = "redis"
      type    = "A"
      ttl     = 1
      records = [
        "${module.redis.private_ip}"
      ]
    },
    {
      name    = "mysql"
      type    = "A"
      ttl     = 1
      records = [
        "${module.mysql.private_ip}"
      ]
    },
    {
      name    = "rabbitmq"
      type    = "A"
      ttl     = 1
      records = [
        "${module.rabbitmq.private_ip}"
      ]
    },
    {
      name    = "catalogue"
      type    = "A"
      ttl     = 1
      records = [
        "${module.catalogue.private_ip}"
      ]
    },
    {
      name    = "cart"
      type    = "A"
      ttl     = 1
      records = [
        "${module.cart.private_ip}"
      ]
    },
    {
      name    = "user"
      type    = "A"
      ttl     = 1
      records = [
        "${module.user.private_ip}"
      ]
    },
    {
      name    = "shipping"
      type    = "A"
      ttl     = 1
      records = [
        "${module.shipping.private_ip}"
      ]
    },
    {
      name    = "payments"
      type    = "A"
      ttl     = 1
      records = [
        "${module.payments.private_ip}"
      ]
    },
    {
      name    = "web"
      type    = "A"
      ttl     = 1
      records = [
        "${module.web.private_ip}"
      ]
    }
  ]
}