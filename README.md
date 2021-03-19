# SimpleTerraform
A simple install of Nginx server on EC2 server

In case of an error for secutiry groups, please change this:  
["aws_security_group.instance.id"]  
to:  
["${aws_security_group.instance.id}"]  

And re-run terraform plan & and terraform apply
