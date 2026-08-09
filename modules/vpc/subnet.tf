resource "aws_subnet" "privatethis-1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.az.names[0]
}

resource "aws_subnet" "privatethis-2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.az.names[0]
}

resource "aws_subnet" "publicthis-1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.az.names[1]
}


resource "aws_subnet" "publicthis-2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.az.names[1]
}



resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.this.id
    
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "public-route-table-2" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "publicassoc-1"{
    subnet_id =aws_subnet.publicthis-1.id
    route_table_id=aws_route_table.public-route-table.id

}

resource "aws_route_table_association" "publicassoc-2"{
    subnet_id =aws_subnet.publicthis-2.id
    route_table_id=aws_route_table.public-route-table.id

}

resource "aws_eip" "nat-1" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat-2" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.igw]
}


resource "aws_nat_gateway" "this-1" {
  allocation_id = aws_eip.nat-1.id
  subnet_id     = aws_subnet.publicthis-1.id

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "this-2" {
  allocation_id = aws_eip.nat-2.id
  subnet_id     = aws_subnet.publicthis-2.id

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private-route-table-1" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this-1.id
  }
}
resource "aws_route_table" "private-route-table-2" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this-2.id
  }
}

resource "aws_route_table_association" "privateassoc-1" {
  subnet_id      = aws_subnet.privatethis-1.id
  route_table_id = aws_route_table.private-route-table-1.id
}
resource "aws_route_table_association" "privateassoc-2" {
  subnet_id      = aws_subnet.privatethis-2.id
  route_table_id = aws_route_table.private-route-table-2.id
}
