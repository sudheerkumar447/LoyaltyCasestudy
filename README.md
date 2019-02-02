# LoyaltyCasestudy
LoyaltyCasestudy

Step 1: Configure the AWS Cli to Communicate with AWS Account.

        Download and Install AWS Cli MSI package in Windows System
        
Step 2: Create User in IAM to connect with AWS Console.

        aws configure
        AWS Access Key ID [None]: Access ID
        AWS Secret Access Key [None]: Secret Access Key
        Default region name [None]: ap-south-1
        Default output format [None]: json

Step 3: VPC Creation
        aws ec2 create-vpc --cidr-block 10.0.0.0/16
        aws ec2 create-subnet --vpc-id vpc-036cd6f3f6c369a61 --cidr-block 10.0.1.0/24
        aws ec2 create-subnet --vpc-id vpc-036cd6f3f6c369a61 --cidr-block 10.0.2.0/24
        aws ec2 create-internet-gateway
        aws ec2 attach-internet-gateway --internet-gateway-id igw-0098454e2b8601559 --vpc-id vpc-036cd6f3f6c369a61
        aws ec2 create-route --route-table-id rtb-0c4f00c3ad7c7a098 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-  0098454e2b8601559
        aws ec2 associate-route-table --route-table-id rtb-0c4f00c3ad7c7a098 --subnet-id subnet-047bcfb88f2a8ff24

Step 4: Launching Ec2 
 aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
 chmod 400 MyKeyPair.pem
 aws ec2 create-security-group --group-name SSHAccess --description "Security group for SSH access" --vpc-id vpc-036cd6f3f6c369a61
{
    "GroupId": "sg-0da938a9a541e0b29"
}
 aws ec2 authorize-security-group-ingress --group-id sg-0da938a9a541e0b29 --protocol tcp --port 22 --cidr 106.200.141.80/32, 183.83.93.37/32
 aws ec2 run-instances --image-id ami-0ad42f4f66f6c1cc9 --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-0da938a9a541e0b29 --subnet-id subnet-047bcfb88f2a8ff24 --associate-public-ip-address

Login to the server:   ssh -i "MyKeyPair.pem" ec2-user@ec2-13-233-192-86.ap-south-1.compute.amazonaws.com

Step 5: Clone from GitHub
        Install GIT Package to communicate with Github.
        yum install git (if it is Centos)
        git clone URL (https://github.com/nginx/nginx.git)

Step 6: Installing Nginx using Yum
        yum install nginx -y
        Configuration: 
vi /etc/nginx/conf.d/loyalty.conf
server {
     listen       80;
     server_name loyalty.devopsind.com;
     location / {
     root   /usr/share/nginx/html/loyalty;
     index index.html index.htm;
     }
}
Create the root directory to upload a file to it.
 mkdir /usr/share/nginx/html/loyalty
Create Index.html page.

OutPut: Welcome to Loyalty Case Study From Nginx Web Server

Restart the Nginx service to replect change to display.
service nginx restart

Url to Access : loyalty.devopsind.com
                ( Note: Subdomain was mapped to My Domain which is available in Cloudflare)

Step 7: Installing Docker.
        Yum install Docker -y
        service docker start
        chkconfig docker on

Build Docker Image:
docker build -t dockernginx1 .
Run Image as a Container:
docker run -d -p 8080:80 dockernginx1
docker stop 87b(87b is container ID)
docker start 87b

Ip Address to Access Docker Container: 13.233.192.86:8080
Output: Welcome to Loyalty Case Study From Docker

Restricting Application to specific ISP:
aws ec2 authorize-security-group-ingress --group-id sg-0da938a9a541e0b29 --protocol tcp --port 8080 --cidr 106.200.141.80/32, 183.83.93.37/32

Step 8: Created a Account in Pingdom.com to monitor the Traffic of the websites which was created in ec2 server.
        Send emails if the website goes down for every 5 min interval
        Receving emails to devops@lji.io and jnskumar47@gmail.com(My Email)
 
