FROM alpine

RUN mkdir /.apkcache && \
	apk update --cache-dir /.apkcache && \
	apk add --cache-dir /.apkcache \
	python3 python3-dev py3-pyzmq gcc libxslt libxml2-dev py3-libxml2 libc-dev libxslt-dev


# Install Python modules
RUN python3 -m pip install --no-cache-dir \
	requests \
	bs4 \
	lxml \
	jupyter \
	zeep
	

# Cleanup
RUN rm -rf /.apkcache

EXPOSE 8888:8888

CMD ["/usr/bin/jupyter", "notebook", "--no-browser", "--allow-root", "--notebook-dir=/app", "--NotebookApp.token=''", "--NotebookApp.password=''", "--ip=0.0.0.0"]