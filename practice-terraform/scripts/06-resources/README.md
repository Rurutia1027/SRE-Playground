# Steps for Deploy NGINX on AWS via Terraform HCL


- Deploy a VPC and a subnet 
- Deploy an internet gateway and associate it with the VPC 
- Set up a route table with a route to the IGM (internet gate-way)
- Deploy an EC2 instance inside the created subnet
- Associate a public IP and a security group that allows public ingress 