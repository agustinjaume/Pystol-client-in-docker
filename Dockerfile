

# We should use CentOS 8 as soon as possible but
# the container fails when building.
FROM registry.centos.org/centos/centos:centos8
LABEL maintainer="Agustin jaume <agustin@ideasextraordinarias.es>"
LABEL Owner project ="Carlos Camacho <carloscamachoucv@gmail.com>"
LABEL quay.expires-after=30w

ARG PYSTOL_LOG=/var/log/
RUN echo "root:root" | chpasswd
USER root
ENV  PYSTOL_LOG  $PYSTOL_LOG

RUN yum upgrade -y
RUN yum install python3 python3-pip git -y
RUN yum install  virtualenv -y

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin
RUN pip3 install  cryptography==2.7 --user
RUN pip3 install ansible==2.9.6  --user
RUN pip3 install hvac --user
RUN pip3 install boto --user
RUN pip3 install pystol --upgrade --force
VOLUME $PYSTOL_LOG



# We install the operator and dependencies
RUN echo "The pystol revision is ${revision}"
# Configure Ansible inventory
RUN mkdir /etc/ansible/ /ansible
RUN echo "localhost ansible_connection=local" >> /etc/ansible/hosts
EXPOSE 3000
EXPOSE 22
CMD [ "/bin/bash" ]