resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.keypair.key_name}.pem"
  content = tls_private_key.mykey.private_key_pem
}