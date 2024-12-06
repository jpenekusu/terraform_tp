resource "aws_instance" "instance-ec2" {
  count         = 3
  ami           = element(var.amis, count.index)
  instance_type = var.instance_type
  tags = {
    Name        = "${var.ec2_name}-${count.index}"
    Environment = var.environnement
  }
  subnet_id = var.subnet_id
}

terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-95100"
    key            = "tfstate/my_terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}


variable "environnement" {
  description = "environnement"
  default     = "DEV"
}

variable "amis" {
  description = "amis des instances EC2"
  type        = list(string)
  default     = ["ami-05edb7c94b324f73c", "ami-05edb7c94b324f73c"]
}

variable "instance_type" {
  type        = string
  description = "Type d'instance"
  default     = "t3.micro"
}

variable "ec2_name" {
  type        = string
  description = "Nom de la machine"
  default     = "jeromeTerraform"
}

variable "subnet_id" {
  type        = string
  description = "Sous réseau"
  default     = "subnet-02dbf55cf4ab64fc4"
}