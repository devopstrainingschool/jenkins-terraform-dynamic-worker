resource "tls_private_key" "anael" {     
  algorithm = "RSA" #"ED25519"
  rsa_bits  = 4096  # remove rsa key because error
}
resource "aws_key_pair" "anael" {
  key_name   = "anael"    # key name
  public_key = tls_private_key.anael.public_key_openssh
  

}
# lines below are to download the key locally

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.anael.key_name}.pem"
  content = tls_private_key.anael.private_key_pem
}