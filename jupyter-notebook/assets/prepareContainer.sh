pip install --upgrade pip
git clone https://github.com/kavgan/word_cloud 
cd word_cloud && pip install -e . 
cp  ~/word_cloud/*clouds.ipynb  ~/work/Example_word_clouds.ipynb
pip install plotly 
pip install matplotlib_venn 
pip install cufflinks 
pip install gender-guesser
pip install -U nltk
pip install ipywidgets
pip install pyarrow
pip install --upgrade pandas


jupyter nbextension enable --py widgetsnbextension
# perhaps clone a github repo into /home/jovyan/work
cd ~/work
git clone http://bitbucket.org/hrojas/learn-pandas
git clone https://github.com/WillKoehrsen/Data-Analysis
cp -R Data-Analysis/widgets ~/work
# next follows a round about way to get a single file into the running container
mkdir temp
cd temp
git clone https://github.com/lucasjellema/katacoda-scenarios
cp katacoda-scenarios/jupyter-notebook/assets/introPythonForDataAnalysis.ipynb ~/work
# adding notebook to play with ipywidgets


cd ~/work
rm -Rf temp 
