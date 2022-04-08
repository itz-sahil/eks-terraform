output "ec2_instance_id" {
    value = aws_instance.ec2_instance.id  
}

output "key_name" {
    value = aws_key_pair.generated_key.key_name
}