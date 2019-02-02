You will now run a Docker container for Jupyter Notebook. Note: this may take up to 3 minutes, because of the size of the container image.

## Run the Jupyter Notebook 

Run the Jupyter Notebook container image:

`docker run -p 8888:8888 -d --name jupyter --volume "$PWD":/script  jupyter/scipy-notebook:2c80cf3537ca`{{execute}}

## Further prepare the container
To prepare the container we will run a script inside the container to install several Python packages

Run this script to execute these steps:
* copy the script prepareContainer.sh into the container
* copy the script, make the copy executable and then run the script inside the container
* restart the container

`sh runPrep.sh`{{execute}}

## Notes
These are the individual steps inside this script. You do not have to execute them - because they are in the *runPrep.sh* script.

First, copy the script into the container
`docker cp prepareContainer.sh jupyter:/script/prepareContainer.sh`{{execute}}
This will copy the local file prepareContainer.sh into the container's /script directory; it will be a root owned file that cannot be run straightaway.

Next, copy the script, make the copy executable and then run the script inside the container:
`docker exec -d jupyter bash -c 'cp /script/prepareContainer.sh ~/prepareContainer.sh && chmod +x ~/prepareContainer.sh && ~/prepareContainer.sh'`{{execute}}

Next, run the script inside the container:
`docker exec -d jupyter sh /home/jovyan/prepareContainer.sh`{{execute}}

Finally restart the docker container
`docker restart jupyter`{{execute}}