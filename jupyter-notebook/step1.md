You will now run a Docker container for Jupyter Notebook. Note: this may take up to 3 minutes, because of the size of the container image.

## Task

Run the Jupyter Notebook container image:

`docker run -p 8888:8888 -d --name jupyter --volume "$PWD":/script  jupyter/scipy-notebook:2c80cf3537ca`{{execute}}

When the container is running, execute this statement:
`docker logs jupyter`{{execute}}

it would be nice to get hold of the token from the logs, but I have not yet got that working
`JUPYTER_TOKEN=$(docker logs jupyter | grep -oP "token=\K[a-z0-9^]+" )`{{execute}}

and check the value of the token:

`echo $JUPYTER_TOKEN`{{execute}}

Next, you can open the Jupyter Notebook at 
 https://[[HOST_SUBDOMAIN]]-8888-[[KATACODA_HOST]].environments.katacoda.com/

Note: you need the value of the Jupyter Token to login to the environment.
## Further prepare the container

To prepare the container we will run a script inside the container to install several Python packages
`docker exec -d jupyter /work/prepareContainer.sh`{{execute}}