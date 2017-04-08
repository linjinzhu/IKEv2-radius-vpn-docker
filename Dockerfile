#centos7:latest image
FROM centos

MAINTAINER Yifeng,http://www.cnblogs.com/hanyifeng

USER root

# Install dep packge
RUN yum install pam-devel openssl-devel make gcc wget iptables-services -y && yum clean all && rm -rf /var/cache/yum/* 
#RUN systemctl stop firewalld && systemctl disable firewalld && systemctl start iptables && systemctl enable iptables

# Download strongswan soft
RUN wget -c https://download.strongswan.org/strongswan-5.5.2.tar.gz
RUN tar -xf strongswan-5.5.2.tar.gz 

# Configure,make and install
RUN cd /strongswan-5.5.2 && ./configure  --enable-eap-identity --enable-eap-md5 --enable-eap-mschapv2 --enable-eap-tls --enable-eap-ttls --enable-eap-peap --enable-eap-tnc --enable-eap-dynamic --enable-eap-radius --enable-xauth-eap --enable-xauth-pam  --enable-dhcp  --enable-openssl  --enable-addrblock --enable-unity --enable-certexpire --enable-radattr --enable-swanctl --enable-openssl --disable-gmp && make && make install

RUN rm -rf /strongswan-5.5.2 && rm -f /strongswan-5.5.2.tar.gz
RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

# Open udp 500\4500 port
EXPOSE 500:500/udp
EXPOSE 4500:4500/udp
#CMD ["/usr/bin/initvpn.sh","start"]
CMD ["/usr/bin/echo","hello"]