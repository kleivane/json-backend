data "aws_availability_zones" "available" {
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = module.bekk_test_static_json_label.tags

}

resource "aws_subnet" "private" {
  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id

  tags = module.bekk_test_static_json_label.tags

}
