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

# Mount EFS
yum install -y amazon-efs-utils
mkdir /data
efs_dns=${efs_dns_name}
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_dns_name}:/ /data
echo $efs_dns:/ /data efs defaults,_netdev 0 0 >> /etc/fstab

/home/ec2-user/apache-tomcat-8.5.77/bin/startup.sh
