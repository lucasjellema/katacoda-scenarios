# copy the script into the container; note: the resulting file is owned by root and it not executable
docker cp prepareContainer.sh jupyter:/script/prepareContainer.sh
# copy the script to make it accessible and executable 
docker exec -d jupyter bash -c 'cp /script/prepareContainer.sh ~/prepareContainer.sh && chmod +x ~/prepareContainer.sh'
# execute the script inside the container - to install a number of packages
docker exec -it jupyter sh /home/jovyan/prepareContainer.sh
# restart the docker container
docker restart jupyter