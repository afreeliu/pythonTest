FROM centos:7.9.2009
RUN yum makecache fast;
RUN yum install python3-devel python3-pip -y
RUN pip3 install -i https://pypi.douban.com/simple flask

COPY main.py /opt
WORKDIR /opt
EXPOSE 8888
CMD ["python3","main.py"]