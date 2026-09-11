resource "aws_instance" "web" {
    ami = var.ami_id
    instance_type = var.instance_type

    variave_inexistente = var.variave_inexistente

    tags = {
        Name = "HelloWorld"
    }
}