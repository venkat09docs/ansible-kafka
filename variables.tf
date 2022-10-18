variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "cidr_block" {
  type    = list(string)
  default = ["172.20.0.0/16", "172.20.10.0/24", "0.0.0.0/0"]
}

variable "availability_zone" {
  type    = string
  default = "ap-south-1a"
}

variable "ports" {
  type    = list(number)
  default = [22, 80, 8080, 9091, 9092, 9093, 2181, 2888, 3888]
}

variable "controller_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "kafka_instance_type" {
  type    = string
  default = "t2.small"
}

variable "keypair_name" {
  type    = string
  default = "kafka"
}

output "AnsibleController_Public_IP" {
  value = aws_instance.AnsibleController.public_ip
}

output "Kafka_node1_Public_IP" {
  value = aws_instance.Kafka_node1.public_ip
}

output "Kafka_node1_Private_IP" {
  value = aws_instance.Kafka_node1.private_ip
}

output "Kafka_node2_Public_IP" {
  value = aws_instance.Kafka_node2.public_ip
}

output "Kafka_node2_Private_IP" {
  value = aws_instance.Kafka_node2.private_ip
}

output "Kafka_node3_Public_IP" {
  value = aws_instance.Kafka_node3.public_ip
}

output "Kafka_node3_Private_IP" {
  value = aws_instance.Kafka_node3.private_ip
}
