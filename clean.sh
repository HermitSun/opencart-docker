sudo docker-compose down
sudo docker volume rm opencart-docker_mysql_data
sudo rm -rf ./*-logs/

# change workdir
sudo rm -rf upload/
