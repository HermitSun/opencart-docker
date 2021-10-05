# TODO: if upload_bak/ exists, copy & use it
cp -r upload/ upload_bak/
sudo chmod 777 -R upload/

# change workdir
mkdir mysql-logs && sudo chmod 777 mysql-logs
sudo docker-compose up -d