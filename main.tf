resource "aws_instance" "user" {

    ami = "ami-01376101673c89611"
    instance_type = "t2.micro"
    key_name = "cust-user"
    tags = {
      Name = "user" 
    }
  
}