#!/usr/bin/bash
sudo docker stop sample-app
sudo docker rm sample-app
sudo docker rmi sample-image
sudo docker-compose -f docker-compose.yml up -d
 
