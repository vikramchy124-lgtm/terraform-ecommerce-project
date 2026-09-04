resource "aws_subnet" "public" {
  cidr_block              = var.public_subnet[count.index]
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true
  count                   = length(var.public_subnet)

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  cidr_block              = var.private_subnet[count.index]
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = false
  count                   = length(var.private_subnet)

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
  }
}

