In this scenario, you will run a Jupyter Notebook in a Docker Container.

The underlying Docker Container Image is jupyter/scipy-notebook. It contains these contents:
* Minimally-functional Jupyter Notebook server (e.g., no pandoc for saving notebooks as PDFs)
* Miniconda Python 3.x in /opt/conda
* Pandoc and TeX Live for notebook document conversion
* git, emacs, jed, nano, and unzip
* pandas, numexpr, matplotlib, scipy, seaborn, scikit-learn, scikit-image, sympy, cython, patsy, statsmodel, cloudpickle, dill, numba, bokeh, sqlalchemy, hdf5, vincent, beautifulsoup, protobuf, and xlrd packages
* ipywidgets for interactive visualizations in Python notebooks
* Facets for visualizing machine learning datasets

For details on the [Jupyter Docker Stacks libary of container images](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html)

You will then add a number of supporting libraries into the running container. This scenario adds these libraries after the container has been started:
* Plotly
* MatplotLib
* Cufflinks
* Gender Guesser
* NLTK

The scenario also deploys a predefined Jupyter Notebook by cloning a GitHub repository. You are free to add additional notebooks in a similar way - or upload them from your own collection.  

Finally, you will access the Jupyter Notebook and start playing with it.
