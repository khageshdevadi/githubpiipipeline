while getopts ":hdpt" opt; do
  case ${opt} in
    h )
      printf "USAGE: ./spinup.sh [OPTION]... \n\n"
      printf "-h for HELP, -d for DEV, -p for PROD, or -t for TEARDOWN \n\n"
      exit 1
      ;;
    d )
      # Rebuild image sample_image
      docker-compose build --no-cache

      # Create sample-net bridge network for container(s) to communicate
      #docker network create --driver bridge sample-net

      # Spin up hquinn-app container
      #docker run -d --name sample-app --restart always -p 3000:3000 -v sample_app_home:/var/www/html --network sample-net>
      docker-compose up -d
      exit 1
      ;;
    p )
      # Rebuild image
      docker-compose build

      # Spin up container
      docker-compose up -d

      exit 1
      ;;
    t )
      # If sample-app container is running, turn it off.
      running_app_container=`docker ps | grep sample-app | wc -l`
      if [ $running_app_container -gt "0" ]
      then
        docker kill sample-app
      fi

      # If turned off hquinn-app container exists, remove it.
      existing_app_container=`docker ps -a | grep sample-app | grep Exit | wc -l`
      if [ $existing_app_container -gt "0" ]
      then
        docker rm sample-app
      fi

      # If image for sample_image exists, remove it.
      existing_app_image=`docker images | grep sample-image | wc -l`
      if [ $existing_app_image -gt "0" ]
      then
        docker rmi sample-image
      fi

      # If hquinn_app_home volume exists, remove it.
      #existing_app_volume=`docker volume ls | grep sample_app_home | wc -l`
      #$if [ $existing_app_volume -gt "0" ]
      #then
        #docker volume rm sample_app_home
      #fi
      # If hquinn-net network exists, remove it.
      #existing_hquinnnet_network=`docker network ls | grep hquinn-net | wc -l`
      #if [ $existing_hquinnnet_network -gt "0" ]
      #then
        #docker network rm sample-net
      #fi

      exit 1
      ;;
    \? )
      printf "Invalid option: %s" "$OPTARG" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

printf "USAGE: ./spinup.sh [OPTION]... \n\n"
printf "-h for HELP, -d for DEV, -p for PROD, or -t for TEARDOWN \n\n"
exit 1
;;
