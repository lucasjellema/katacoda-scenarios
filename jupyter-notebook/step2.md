## Access the Jupyter Notebook 

When the container is running, execute this statement:
`docker logs jupyter`{{execute}}

it would be nice to get hold of the token from the logs, but I have not yet got that working
`JUPYTER_TOKEN=$(docker logs jupyter | grep -oP "token=\K[a-z0-9^]+" )`{{execute}}

and check the value of the token:

`echo $JUPYTER_TOKEN`{{execute}}

Next, you can open the Jupyter Notebook at 
 https://[[HOST_SUBDOMAIN]]-8888-[[KATACODA_HOST]].environments.katacoda.com/

Note: you need the value of the Jupyter Token to login to the environment.