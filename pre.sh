if [[ -d "../upload_bak/" ]]; then
  cp -r ../upload_bak/ ../upload/
else
  cp -r ../upload/ ../upload_bak/
fi
sudo chmod 777 -R ../upload/
mkdir mysql-logs
sudo chmod 777 mysql-logs
sudo docker-compose up -d
# 这个确实没办法，现在的实现有问题
# FIXME: 后面用别的方法去启动ssh
sleep 10 && docker exec opencart-docker_provdb_1 /bin/sh -c 'service ssh start'