terraform {
   backend "s3" {
      bucket = "my-bucket-03-08-2024"
      key    = "terraform.tfstate"
      region = "us-east-2"
      access_key = "AKIA5T6ODMDBD7NEOARO"
      secret_key = "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"	   
       }
	
 }	
	
provider "aws" {
   region   = var.region
   access_key = "AKIA5T6ODMDBD7NEOARO"
   secret_key = "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"	
 }

#resource "aws_s3_bucket_object" "folders" {
#    count   = "${length(var.s3_folders)}"
#    bucket = "${var.bucket}"
#    acl    = "private"
#    key    = "var.s3-folders"/
    #source = "/dev/null"
#}
 
resource "aws_s3_bucket_object" "folder" { 
 # count  = "${length(var.key)}"	
  bucket = "${var.bucket}"     
  acl    = "private"     
 # key    =  "var.key"/
  key    =  "${var.key}/"	
  source = "/dev/null" 
 }
  
resource "aws_instance" "server" {
  count = "${var.instance-count}" 
  ami           = var.ami
  instance_type = var.int_type
 # subnet_id     = "subnet-08bc8bc52fdf01323"
  vpc_security_group_ids = ["sg-0113fc96e2b47df24"]
  key_name      = "pentaho"
 user_data = <<-EOF
#! /bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
cd /opt/
sudo  /bin/git clone https://khimanand%40nagarro.com-at-591438155357:bqiKyqDMKcWBFMklJUmq3GylR7IlEVY6bZTXbSWdL6g%3D@git-codecommit.eu-central-1.amazonaws.com/v1/repos/terraform
cd terraform
aws s3 sync /opt/jmeter/bin/ s3://my-bucket-03-08-2022/"${var.key}/"
chmod 777 infra-destroy.sh
#sed -i 's/s3-folder/"${var.key}/g" /opt/terraform/bin/s3-script.sh
sleep 2m
#./infra-destroy.sh
EOF
	
  tags = {
    Name = "terraform-${count.index+1}"
	}
	
}
