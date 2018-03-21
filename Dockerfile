FROM python:3.5.2

RUN apt-get -y update && apt-get install -y \
    python-dev \
    python-setuptools

RUN pip install jupyter

RUN pip install --no-cache-dir numpy && \
    pip install --no-cache-dir pandas && \
    pip install --no-cache-dir scipy && \
    pip install --no-cache-dir pyyaml && \
    pip install --no-cache-dir configparser && \
    pip install --no-cache-dir jupyter

RUN cd /usr/local/src && mkdir xgboost && cd xgboost && \
    git clone --depth 1 --recursive https://github.com/dmlc/xgboost.git && cd xgboost && \
    make && cd python-package && python setup.py install

RUN mkdir /root/.jupyter/
ADD jupyter_notebook_config.py /root/.jupyter/

RUN apt-get -y update && \
    apt-get -y install graphviz && \
    pip install graphviz

RUN mkdir /data && \
    mkdir /jupyter

VOLUME /data
VOLUME /jupyter

EXPOSE 8888

WORKDIR /jupyter

ENV PYTHONPATH $PYTHONPATH:/jupyter

ADD docker_entrypoint.sh /tmp/
CMD ["sh", "/tmp/docker_entrypoint.sh"]
