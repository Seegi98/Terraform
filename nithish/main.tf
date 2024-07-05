resource "aws_instance" "nsl" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        Name = "EC2"
    }
  
}