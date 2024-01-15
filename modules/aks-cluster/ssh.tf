module "ssh" {
  source         = "./modules/ssh"
  public_ssh_key = var.public_ssh_key == "" ? "" : var.public_ssh_key
}
