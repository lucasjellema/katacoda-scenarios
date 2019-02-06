pip install --upgrade pip
pip install --upgrade pandas
git clone https://github.com/kavgan/word_cloud 
cd word_cloud && pip install -e . 
cp  ~/word_cloud/*clouds.ipynb  ~/work
pip install plotly 
pip install matplotlib_venn 
pip install cufflinks 
pip install gender-guesser
pip install -U nltk
pip install ipywidgets
pip install pyarrow

jupyter nbextension enable --py widgetsnbextension
jupyter labextension install @jupyterlab/plotly-extension
# perhaps clone a github repo into /home/jovyan/work
cd ~/work
git clone http://bitbucket.org/hrojas/learn-pandas
# round about way to get a single file into the running container
mkdir temp
cd temp
git clone https://github.com/lucasjellema/katacoda-scenarios
cp katacoda-scenarios/jupyter-notebook/assets/introPythonForDataAnalysis.ipynb ~/work
# adding notebook to play with ipywidgets
git clone https://github.com/WillKoehrsen/Data-Analysis
cp Data-Analysis/widgets ~/work

cd ~/work
rm -Rf temp 
