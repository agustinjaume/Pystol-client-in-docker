FROM alpine:3.11.5

LABEL maintainer="Agustin jaume <agustin@ideasextraordinarias.es>"
LABEL Owner project ="Carlos Camacho <carloscamachoucv@gmail.com>"
LABEL quay.expires-after=30w

ARG PYSTOL_LOG=/var/log/
RUN echo "root:root" | chpasswd
USER root
#COPY pystol-ui /home/
ENV  PYSTOL_LOG  $PYSTOL_LOG
ENV  FLASK_APP  /home/run.py 
 
# Update & Install dependencies
RUN apk add --no-cache --update 
RUN apk add linux-headers
RUN apk add --no-cache python3 
RUN apk add --no-cache  ansible==2.9.6-r0
RUN apk add --no-cache curl
RUN apk add --update bash
RUN apk add --update openssl
RUN pip3 install virtualenv 
RUN pip3 install --no-cache-dir --upgrade pip 
RUN pip3 install virtualenv 
RUN pip3 install pystol 
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin
RUN env
RUN mkdir /kubeconfig
RUN mkdir .kube
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN bash ./get_helm.sh 
RUN helm repo add brigade https://brigadecore.github.io/charts
RUN helm repo add stable https://kubernetes-charts.storage.googleapis.com
RUN helm repo add bitnami https://charts.bitnami.com/bitnami
RUN pip3 install flask 
RUN pip3 install flask_login flask_migrate flask_wtf flask_sqlalchemy gunicorn kubernetes pint



VOLUME $PYSTOL_LOG
VOLUME /home

RUN mkdir /etc/ansible/ /ansible
RUN echo "localhost ansible_connection=local" >> /etc/ansible/hosts
RUN pwd
RUN ls
#RUN cd /home && pip3 install -r requirements.txt 
#WORKDIR /home
EXPOSE 3000
EXPOSE 22
CMD [ "/bin/sh" ]
#ENTRYPOINT ["mysql"]