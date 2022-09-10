provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
module "umar-webserver-1" {
  source = ".//module-1"

}
module "umar-webserver-2" {
  source = ".//module-2"

}