#!/bin/bash

yum update
yum install -y httpd git java-1.8.0-openjdk ruby wget

service httpd start

cd /home/ec2-user
wget https://aws-codedeploy-ap-northeast-2.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent status
rm -rf ./install

cat >/etc/init.d/codedeploy-start.sh <<EOL
#!/bin/bash
sudo service codedeploy-agent restart
EOL
chmod +x /etc/init.d/codedeploy-start.sh

echo ${ALB_DNS} > /home/ec2-user/userdata.log
sed -i s/ALB_DNS/${ALB_DNS}/g /etc/httpd/conf/httpd.conf > /home/ec2-user/userdata.log
service httpd restart