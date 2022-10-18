resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.default.id

  cidr_block = "${var.public_subnet_cidrs[count.index]}"
  availability_zone = element(var.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "my-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.default.id

  cidr_block = "${var.private_subnet_cidrs[count.index]}"
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "my-private-subnet-${count.index}"
    Network = "Private"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "my-internet-gateway"
  }
}

#resource "aws_eip" "nat" {
#  count = length(var.availability_zones)
#  vpc = true
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}

#resource "aws_nat_gateway" "nat" {
#  count = length(var.availability_zones)
#  
#  allocation_id = element(aws_eip.nat.*.id, count.index)
#
#  subnet_id = element(aws_subnet.public.*.id, count.index)
#
#  lifecycle {
#    create_before_destroy = true
#  }
#
#  tags = {
#    Name = "my-nat-gateway-${count.index}"
#  }
#}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "private-route-table-${count.index}"
    Network = "Private"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

#resource "aws_route" "private_nat" {
#  count = length(var.availability_zones)
#  route_table_id = element(aws_route_table.private.*.id, count.index)
#  destination_cidr_block = "0.0.0.0/0"
#  nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
#}
