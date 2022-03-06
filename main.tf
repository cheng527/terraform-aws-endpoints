module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = var.vpc_id
  security_group_ids = ["sg-0d147a063f3eb011f"]

  endpoints = {
    s3 = {
      service             = "s3"
      tags                = { Name = "s3-vpc-endpoint" }
      service_type        = "Gateway"
      route_table_ids = ["rtb-014bf846be2eb0547", "rtb-078963c7b4bd289c3"]
    }
    
    # dynamodb = {
      #service         = "dynamodb"
      #route_table_ids = ["rtb-014bf846be2eb0547", "rtb-078963c7b4bd289c3"]
     # tags            = { Name = "dynamodb-vpc-endpoint" }
    #}
  }  
}      
