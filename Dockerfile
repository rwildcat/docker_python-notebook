# Debian-based Python Jupyter Notenbook
# Updated on 2019-05-22
# R. Solano <ramon.solano@gmail.com>

FROM debian:9.9-slim

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get install -qy sudo python ipython python-pip \
	jupyter-notebook python-notebook \
	#
	# cleanup
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* 

# users and groups
RUN echo "root:debian" | /usr/sbin/chpasswd \
    && useradd -m debian -s /bin/bash \
    && echo "debian:debian" | /usr/sbin/chpasswd \
    && echo "debian    ALL=(ALL) ALL" >> /etc/sudoers 

# ports (Jupyter)
EXPOSE 8888

# Seaborn (via PIP) provides numpy, pandas, matplotlib and scipy 

USER debian
WORKDIR /home/debian

# install pip libs
RUN pip install plotly seaborn

# enable user aliases
RUN sed 's/#alias/alias/'< .bashrc > .bashrc \
	&& echo "alias lla='ls -al'" >> .bashrc
