# Simple Python Flask Dockerized Application#

Build the image using the following command.

$ sudo docker build -t my-flask-app:latest .

Run the Docker Container using the following command below 

$ sudo docker run -d -p  5000:5000 my-flask-app 

The application will be accessible at http:127.0.0.1:5000

CI process with Github Action Workflows#

The docker image builds upon a push on the main braanch 

The image is push to Dockerhub periodically on Saturday's at 7pm



# Configuring Linux machine with Ansible #

Terraform for provisioning Ec2 Ubuntu Server.


Generate SSH key on local machine with the command:

$ ssh-keygen -t rsa -b 2048

Provide the right path to your ssh key in the provisioner block

Provide your public_key in resoure aws_key_pair block

Provide the private_key in variable.tf file

Terraform to provisioned Ec2 instance by running the following command:

$ terraform init

$ terraform plan

$ terraform apply

SSH into the Ec2 Instance

CD into the ansible folder

Install ansible on the Ubuntu server with the following command:

$ sudo apt install ansible-core

Run the Playbook with this command:

$ ansible-playbook -i inventory  configure_user.yml
