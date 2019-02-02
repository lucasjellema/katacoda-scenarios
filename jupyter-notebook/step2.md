## Access the Jupyter Notebook 

When the container is running, execute this statement:
`docker logs jupyter`{{execute}}

This will show something like:
```
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=f89b02dd78479d52470b3c3a797408b20cc5a11e067e94b8
```

The token is the value behind `/?token=`. You need that for logging in.

Next, you can open the Jupyter Notebook at 
 https://[[HOST_SUBDOMAIN]]-8888-[[KATACODA_HOST]].environments.katacoda.com/

Note: you need the value of the Jupyter Token to login to the environment.

The Notebook opens in a new browser window. You can create a new notebook or open a local one. For example: open and run `Example word clouds.ipynb` in the word_cloud folder. Do *not* open `Word Cloud Examples.ipynb` because it has an error and will fail to run. Or open folder learn-pandas/lessons and start with `01 - Lesson.ipynb`.

## Adding interesting Jupyter Notebooks to the container
You can easily add more notebooks to the container, by cloning them from GitHub straight into the container and subsequently opening them in Jupyter Notebook.

For example - to grab the world's most trivial notebook:

`docker exec -it jupyter git clone https://github.com/Noura/hello-jupyter`{{execute}}

After executing this command, this notebook can be opened in the Jupyter Notebook browser window from the folder `hello-jupyter`.