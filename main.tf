################################################################################
# Endpoint(s)
################################################################################

data "aws_vpc_endpoint_service" "service" {
  for_each = { for k, v in var.endpoints : k => v }

  service      = lookup(each.value, "service", null)
  service_name = lookup(each.value, "service_name", null)

  filter {
    name   = "service-type"
    values = [lookup(each.value, "service_type", "Interface")]
  }
}

resource "aws_vpc_endpoint" "endpoint" {
  for_each = { for k, v in var.endpoints : k => v }

  vpc_id            = var.vpc_id
  service_name      = data.aws_vpc_endpoint_service.service[each.key].service_name
  vpc_endpoint_type = lookup(each.value, "service_type", "Interface")

  security_group_ids  = distinct(concat(var.security_group_ids, lookup(each.value, "security_group_ids", [])))
  subnet_ids          = distinct(concat(var.subnet_ids, lookup(each.value, "subnet_ids", [])))
  route_table_ids     = lookup(each.value, "route_table_ids", null)
  policy              = lookup(each.value, "policy", null)
  private_dns_enabled = lookup(each.value, "private_dns_enabled", null)

  tags = merge(var.tags, lookup(each.value, "tags", {}))

}
