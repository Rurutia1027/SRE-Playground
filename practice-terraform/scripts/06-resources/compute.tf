resource "aws_instance" "web" {
  # https://cloud-images.ubuntu.com/locator/ec2/
  ami                         = "ami-0da9e85793f872825"
  associate_public_ip_address = true
  instance_type               = "t2.micro"

  subnet_id = aws_subnet.public.id
  #security_groups = []
  root_block_device {
    # whenever current scoped resources are destroyed or terminated by terraform
    # the root block device will be deleted too
    delete_on_termination = true
    volume_size           = 10 # GB
    volume_type           = "gp3"
  }
}