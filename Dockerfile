FROM registry.centos.org/centos/centos:centos8
LABEL maintainer="Agustin jaume <agustin@ideasextraordinarias.es>"
LABEL Owner project ="Carlos Camacho <carloscamachoucv@gmail.com>"
LABEL quay.expires-after=30w

ARG PYSTOL_LOG=/var/log/
RUN echo "root:root" | chpasswd
USER root
COPY pystol-ui /home/
ENV  PYSTOL_LOG  $PYSTOL_LOG
ENV  FLASK_APP  /home/run.py   
ENV  UPLOAD_FOLDER '/home/upload/'
ENV  UPLOAD_FOLDER_KUBECONFIG '/home/upload/kubeconfig/'


RUN yum upgrade -y
RUN yum install python3 python3-pip git -y
RUN yum install  virtualenv -y

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin
RUN pip3 install  cryptography==2.7 
RUN pip3 install ansible==2.9.6   
RUN pip3 install pystol 
RUN env
RUN mkdir /kubeconfig
RUN mkdir /home/upload/
RUN mkdir /home/upload/kubeconfig
RUN mkdir .kube
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN  chmod 700 get_helm.sh
RUN ./get_helm.sh
RUN helm repo add brigade https://brigadecore.github.io/charts
RUN helm repo add stable https://kubernetes-charts.storage.googleapis.com
RUN helm repo add bitnami https://charts.bitnami.com/bitnami
RUN yum install python3-flask -y
RUN pip3 install flask_login flask_migrate flask_wtf flask_sqlalchemy gunicorn kubernetes  pint

VOLUME $PYSTOL_LOG

RUN mkdir /etc/ansible/ /ansible
RUN echo "localhost ansible_connection=local" >> /etc/ansible/hosts
RUN pwd
RUN ls
RUN cd /home/  && pip3 install -r requirements.txt
EXPOSE 3000
EXPOSE 22
CMD [ "/bin/bash" ]