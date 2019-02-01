Install some additional libraries into the Jupyter Notebook container

docker exec –it <docker container id> /bin/bash

pip install --upgrade pip
git clone https://github.com/kavgan/word_cloud
cd word_cloud
pip install -e . 
pip install plotly 
pip install matplotlib_venn
pip install cufflinks
pip install gender-guesser

jupyter labextension install @jupyterlab/plotly-extension


Perhaps git clone some GitHub repo as well