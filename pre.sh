# TODO: if upload_bak/ exists, copy & use it
if [[ -f "upload_bak/" ]]; then
  cp -r ../upload_bak/ ../upload/
else
  cp -r ../upload/ ../upload_bak/
fi
sudo chmod 777 -R ../upload/
mkdir mysql-logs
sudo chmod 777 mysql-logs
sudo docker-compose up -d