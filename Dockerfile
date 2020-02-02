FROM centos:7
RUN yum install -y wget
RUN yum install -y tar
RUN yum install -y dos2unix
RUN yum install -y unzip
#Needed for loading the JCO .so dynamic libraries
# Update the image with the latest packages (recommended)
RUN yum install epel-release -y; yum clean all

RUN yum update -y; yum clean all
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y install python36u python36u-libs python36u-devel python36u-pip

RUN \
    mkdir -p /opt/awscli && \
    cd /opt/awscli && wget -q https://s3.amazonaws.com/aws-cli/awscli-bundle.zip && \
    cd /opt/awscli && unzip awscli-bundle.zip && \
    /opt/awscli/awscli-bundle/install -i /opt/awscli/current && \
    ln -s /opt/awscli/current /opt/awscli/latest && \
    rm -rf /opt/awscli/awscli-bundle.zip /opt/awscli/awscli-bundle && \
    /opt/awscli/current/bin/aws --version

RUN cd /tmp
RUN useradd javaadmin

# get jdk and tomcat packages
RUN /opt/awscli/current/bin/aws --region=us-east-1 s3 cp s3://cf-templates--ssriche/test.zip /tmp/DataCache.tar.gz
