docker cp prepareContainer.sh jupyter:/script/prepareContainer.sh
docker exec -d jupyter bash -c 'cp /script/prepareContainer.sh ~/prepareContainer.sh && chmod +x ~/prepareContainer.sh'
docker exec -d jupyter sh /home/jovyan/prepareContainer.sh