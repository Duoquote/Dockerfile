FROM ubuntu:xenial
LABEL maintainer="duoquote"
LABEL description="AdvBox running in docker container with jupyter notebook."
LABEL version="1.0"
RUN /bin/bash -c '\
	apt-get update && \
	apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libglib2.0-0 libsqlite3-dev libsm6 libxext6 libxrender-dev wget git && \
	wget https://www.python.org/ftp/python/3.5.9/Python-3.5.9.tar.xz && \
	xz -d Python-3.5.9.tar.xz && \
	tar -xf Python-3.5.9.tar && \
	cd Python-3.5.9/ && \
	./configure --prefix=/usr/local/python3.5 --enable-optimizations && \
	make && make install && \
	/usr/local/python3.5/bin/python3.5 -m pip install pip --upgrade && \
	/usr/local/python3.5/bin/python3.5 -m pip install virtualenv && \
	mkdir /app && \
	cd /app && \
	/usr/local/python3.5/bin/python3.5 -m virtualenv . && \
	source bin/activate && \
	pip install jupyter ipykernel future futures torch torchvision opencv-python && \
	jupyter notebook --generate-config && \
	echo c.NotebookApp.password_required = False > /root/.jupyter/jupyter_notebook_config.py && \
	echo c.NotebookApp.password = \"\" >> /root/.jupyter/jupyter_notebook_config.py && \
	echo c.NotebookApp.token = \"\" >> /root/.jupyter/jupyter_notebook_config.py && \
	cat /root/.jupyter/jupyter_notebook_config.py && \
	git clone https://github.com/advboxes/AdvBox.git && \
	cd AdvBox && \
	git reset --hard 39acc46ef378c25f1ef6c2ff722b27c1128016ee && \
	sed -r "s/^futures=.*//gm" -i requirements.txt && \
	pip install -r requirements.txt && \
	python setup.py install'


EXPOSE 8888/tcp
WORKDIR /app/AdvBox
ENTRYPOINT /bin/bash -c 'source /app/bin/activate; JUPYTER_TOKEN=advbox; jupyter notebook --ip=$HOSTNAME --allow-root --notebook-dir=/app/AdvBox'