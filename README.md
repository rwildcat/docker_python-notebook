# Python Jupyter Notebook

A [Debian](https://hub.docker.com/_/debian)-based personal Jupyter Python workstation. Provides Python + basic engineering modules, iPython and Jupyter Notebook.

*Ramon Solano <<ramon.solano@gmail.com>>*

**Last update:** May/22/2019   
**Debian version:** 9.9

## Main packages

* Python[2,3]
	* Modules: Numpy, Pandas, SciPy
	* Plotting: Matplotlib, Seaborn, Plotly
* IPython
* Jupyter Notebook

## Users

User/pwd:

* root/debian
* debian/debian (sudoer)

## To build from `Dockerfile`

```sh
$ docker build -t rsolano/python-notebook .
```

## To run container

```sh
$ docker run [-it] [--rm] [--detach] [-h HOSTNAME] [-p LNOTEBOOKPORT:8888] [-v LDIR:DIR] rsolano/python-notebook [cmd]
```

where:

* `LNOTEBOOKPORT`: Local HTTP Jupyter Notebook port to connecto to (e.g. 8888). Requires IP=0.0.0.0 when running Jupyter in your container for connecting from your locahost, otherwise IP=127.0.0.1 for internal access only.

* `LDIR:DIR`: Local directory to mount on container. `LDIR` is the local directory to export; `DIR` is the target dir on the container.  Both sholud be specified as absolute paths. For example: `-v $HOME/worskpace:/home/debian/workspace`.

* `cmd`: User command to run inside the container

### Examples

* Run image, keep terminal open (interactive terminal session); remove container from memory once exited from container;  map Jupyter Notebooks to 8888; mount local `$HOME/workspace` on container's `/home/debian/workspace`:

	```sh
	$ docker run -it --rm -p 8888:8888 -v $HOME/workspace:/home/debian/workspace rsolano/python-notebook
	```
* As above, but running immediately Jupyter:

	```sh
	$ docker run -it --rm -p 8888:8888 -v $HOME/workspace:/home/debian/workspace rsolano/python-notebook jupyter-notebook --ip 0.0.0.0 --no-browser
	```

* Run image, detach to background and keep running in memory (control returns to user immediately, Notebook keep  running in background); map Jupyter Notebook to 8888; mount local `$HOME/workspace` on container's `/home/debian/workspace`:

	```sh
	$ docker run --detach -p 8888:8888 -v $HOME/workspace:/home/debian/workspace rsolano/python-notebook jupyter-notebook --ip 0.0.0.0 --no-browser
	```

**NOTES**

* There is no graphical desktop; just the Jupyter Notebook engine to serve Notebooks

* Mapping Jupyter container port 8888 to our host's port 8888, allows us to connect to our computer (`localhost:8888`), which is actually forwarding to the container.

* To run Jupyter in a headless container (no graphical display), you shoukd specify:

	* Option `--no-browser` : Do not open a local web browser
	* Option `--ip 0.0.0.0` : Allow connecting to Jupyter server from external computers

	This means, run jupyter as:

	```
	$ jupyter-notebook --ip 0.0.0.0 --no-browser
	```

	

## To stop container

* If running an Jupyter in an interactive session:

  * Just press `CTRL-C` in the interactive terminal to quit Jupyter.
  * Just press `CTRL-D` or key in `exit` end finish the session.


* If running *detached* (background) session:

	1. Look for the container Id with `docker ps`:   
	
		```
		$ docker ps
		CONTAINER ID        IMAGE                     COMMAND                  CREATED             STATUS              PORTS                                          NAMES
		ac46f0cf41d1        rsolano/python-notebook   "/usr/bin/supervisor…"   58 seconds ago      Up 57 seconds       0.0.0.0:5900->5900/tcp, 0.0.0.0:2222->22/tcp   wizardly_bohr
		```

	2. Stop the desired container Id (ac46f0cf41d1 in this case):

		```sh
		$ docker stop ac46f0cf41d1
		```
