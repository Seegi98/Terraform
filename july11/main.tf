resource "aws_instance" "myvm" {
 ami           = "ami-0ec0e125bb6c6e8ec"#(we need to add from state file reference)
 instance_type = "t3.micro"#(we need to add from state file reference)


 tags ={
    Name = "meijfjnijdsd"
 }

 lifecycle{
    create_before_destroy = true 
}
}