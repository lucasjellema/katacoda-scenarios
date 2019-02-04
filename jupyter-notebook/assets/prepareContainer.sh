pip install --upgrade pip
git clone https://github.com/kavgan/word_cloud 
cd word_cloud && pip install -e . 
pip install plotly 
pip install matplotlib_venn 
pip install cufflinks 
pip install gender-guesser
pip install -U nltk
jupyter labextension install @jupyterlab/plotly-extension
# perhaps clone a github repo into /home/jovyan/work
cd ~/work
git clone http://bitbucket.org/hrojas/learn-pandas
# round about way to get a single file into the running container
mkdir temp
cd temp
git clone https://github.com/lucasjellema/katacoda-scenarios
cp katacoda-scenarios/jupyter-notebook/assets/introPythonForDataAnalysis.ipynb ~/work
cd ~/work
rm -R temp 
