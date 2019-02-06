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

The Notebook opens in a new browser window. You can create a new notebook or open a local one. Check out the local folder `work` for several sample notebooks. For example: open and run `pythonForDataAnalysis.ipynb` in the `work` folder. Or open and run `Example_word_clouds.ipynb`. Or open folder learn-pandas/lessons and start with `Python_101.ipynb` or `Cookbook - Select.ipynb`. 

The folder `work/Data-Analysis` contains many notebooks created by Will Koehrsen, who writes many great articles about Data Science and uses Jupyter Notebooks frequently (see his GitHub Repo: https://github.com/WillKoehrsen/Data-Analysis ). 

### Interactive Widgets
A nice advanced feature in Jupyter Notebooks are the interactive widgets. To have a quick tour of what these widgets can add to a notebook, open `work\widgets\Widgets-Overview.ipynb`.
The code cell under the *Data heading* contains an erroneous file reference - or it did when I last checked. Change the contents of the cell to:
```
df = pd.read_parquet('https://github.com/WillKoehrsen/Data-Analysis/blob/master/medium/data/medium_data_2019_01_26?raw=true')
df.head()
```
Now the cell will correctly retrieve and process the data.

This article on Medium introduced the interactive widgets demonstrated in this notebook: [Interactive Controls for Jupyter Notebooks](https://link.medium.com/vXntNOep3T).

## Adding interesting Jupyter Notebooks to the container
You can easily add more notebooks to the container, by cloning them from GitHub straight into the container and subsequently opening them in Jupyter Notebook.

For example - to grab the world's most trivial notebook:

`docker exec -it jupyter bash -c 'cd ~/work && git clone https://github.com/Noura/hello-jupyter'`{{execute}}

After executing this command, this notebook can be opened in the Jupyter Notebook browser window from the folder `work/hello-jupyter`.
