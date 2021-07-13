#!/bin/bash
sudo docker rm -f sample-app
sudo docker rmi sample-image
sudo docker-compose -f docker-compose.yml up -d
 
