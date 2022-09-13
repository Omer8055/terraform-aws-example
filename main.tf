provider "aws"{
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}                            
module "website" {
  source = "github.com/omer8055/code-x"
}
                               