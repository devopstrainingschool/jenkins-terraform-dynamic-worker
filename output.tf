output "jenkins-subnet-id" { 
    value = aws_subnet.jenkins.id
}



output "bastion-ip" { 
    value = aws_instance.bastion.public_ip
    
}

output "jenkins-ip" { 
    value = aws_instance.jenkins.private_ip
    
}
output "Instances-keypair" { 
    value = aws_instance.bastion.key_name
    
}

output "Jenkins-AMI" { 
    value = aws_instance.jenkins.ami
    
}
output "jenkins-az" { 
    value = aws_instance.jenkins.availability_zone
    
}