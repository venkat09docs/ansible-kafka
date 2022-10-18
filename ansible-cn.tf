# Create an AWS EC2 Instance to host Ansible Controller (Control node)

resource "aws_security_group" "MyLab_Sec_Group" {
  name        = "MyLab Security Group"
  description = "Allow inbound and outbound traffic"
  vpc_id      = aws_vpc.MyLab-VPC.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr_block[2]]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_trafic"
  }
}

data "aws_ami" "aws-linux-2-latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_instance" "AnsibleController" {
  ami           = data.aws_ami.aws-linux-2-latest.id
  instance_type = var.controller_instance_type
  key_name = var.keypair_name
  vpc_security_group_ids = [aws_security_group.MyLab_Sec_Group.id]
  subnet_id = aws_subnet.MyLab-Subnet1.id
  associate_public_ip_address = true
  user_data = file("./scripts/InstallAnsibleCN.sh")

  tags = {
    Name = "Ansible-ControllerNode"
  }
}

resource "aws_instance" "Kafka_node1" {
  ami           = data.aws_ami.aws-linux-2-latest.id
  instance_type = var.kafka_instance_type
  key_name = var.keypair_name
  vpc_security_group_ids = [aws_security_group.MyLab_Sec_Group.id]
  subnet_id = aws_subnet.MyLab-Subnet1.id
  associate_public_ip_address = true
  user_data = file("./scripts/AnsibleManagedNode.sh")

  tags = {
    Name = "Kafka_node1"
  }
}

resource "aws_instance" "Kafka_node2" {
  ami           = data.aws_ami.aws-linux-2-latest.id
  instance_type = var.kafka_instance_type
  key_name = var.keypair_name
  vpc_security_group_ids = [aws_security_group.MyLab_Sec_Group.id]
  subnet_id = aws_subnet.MyLab-Subnet1.id
  associate_public_ip_address = true
  user_data = file("./scripts/AnsibleManagedNode.sh")

  tags = {
    Name = "Kafka_node2"
  }
}

resource "aws_instance" "Kafka_node3" {
  ami           = data.aws_ami.aws-linux-2-latest.id
  instance_type = var.kafka_instance_type
  key_name = var.keypair_name
  vpc_security_group_ids = [aws_security_group.MyLab_Sec_Group.id]
  subnet_id = aws_subnet.MyLab-Subnet1.id
  associate_public_ip_address = true
  user_data = file("./scripts/AnsibleManagedNode.sh")

  tags = {
    Name = "Kafka_node3"
  }
}
