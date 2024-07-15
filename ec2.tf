resource "aws_instance" "this" {
  ami = ""
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet[0].id
  security_groups = [ aws_security_group.ec2-sg.id ]
  key_name = "test-prj-15-07-24"
  tags = {
    Name = "${var.name}-${var.environment}-ec2"
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "ec2-sg" {
    vpc_id = aws_vpc.this.id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 22
        to_port = 22
        cidr_blocks = [ "10.1.0.10" ]
    }
  
}

resource "null_resource" "trigger_rerun" {
    triggers = {
        file_change = filebase64sha256("index.html")
    }

    provisioner "local-exec" {
      command = "terraform plan"
    }
  
}