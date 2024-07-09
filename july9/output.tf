#printing instance attributes

output "public_ip" {
    value = aws_instance.user.public_ip
    description = "getting value of public ip"
  
}

output "private_ip" {
    value = aws_instance.user.private_ip
    description = "getting value of private ip"
    sensitive = true
  
}

output "ami" {
    value = aws_instance.user.ami
    description = "getting value of ami"
  
}