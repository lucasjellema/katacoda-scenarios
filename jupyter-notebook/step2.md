Install some additional libraries into the Jupyter Notebook container

docker exec –it jupyter /bin/bash

`docker exec -d jupyter pip install --upgrade pip`{{execute}}
`docker exec -d jupyter bash -c 'git clone https://github.com/kavgan/word_cloud `{{execute}}
`docker exec -d jupyter bash -c ' cd word_cloud && pip install -e . '`{{execute}}
`docker exec -d jupyter bash -c 'pip install plotly && pip install matplotlib_venn && pip install cufflinks && pip install gender-guesser'`{{execute}}

`docker exec -d jupyter jupyter labextension install @jupyterlab/plotly-extension`{{execute}}

`docker restart jupyter`{{execute}}



Perhaps git clone some GitHub repo as well