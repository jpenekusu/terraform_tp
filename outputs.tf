output "all_instance_ids" {
  value = [aws_instance.instance-ec2.*.id]
}

output "first_instance_id" {
  value = aws_instance.instance-ec2.0.id
}