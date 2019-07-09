FROM centos:7.6.1810

RUN yum -y install gcc libffi-devel make openssl-devel python-devel python-setuptools

RUN easy_install pip 

RUN pip install --upgrade setuptools --user

RUN curl -L https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz | tar xz -C /usr/src && \
    cd /usr/src/Python-3.7.4 && \
    ./configure --prefix=/usr --enable-optimizations && \
    make altinstall

RUN pip3.7 install --upgrade setuptools --user

