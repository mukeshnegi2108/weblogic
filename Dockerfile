FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y vim-tiny wget net-tools iputils-ping

RUN groupadd -g 1000 oinstall
RUN useradd -u 1100 -g oinstall oracle
RUN mkdir -p /u01/app/oracle/middleware /u01/app/oracle/config/domains /u01/app/oracle/config/applications
RUN chown -R oracle:oinstall /u01
RUN chmod -R 775 /u01/

RUN wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz -P /u01/app/oracle/
RUN tar -xvzf /u01/app/oracle/jdk-8u131-linux-x64.tar.gz -C /u01/app/oracle/ && rm /u01/app/oracle/jdk-8u131-linux-x64.tar.gz

ENV MW_HOME=/u01/app/oracle/middleware
ENV WLS_HOME=$MW_HOME/wlserver
ENV WL_HOME=$WLS_HOME
ENV JAVA_HOME=/u01/app/oracle/jdk1.8.0_131
ENV PATH=$PATH:$JAVA_HOME/bin

RUN mkdir /u01/software/
COPY configuration/* /u01/software/

RUN chmod 777 /u01/software/oradown.sh 

RUN wget -O - -q https://raw.githubusercontent.com/typekpb/oradown/master/oradown.sh  | bash -s -- --cookie=accept-weblogicserver-server --username=negimukesh21@gmail.com --password=August@2019 http://download.oracle.com/otn/nt/middleware/12c/12212/fmw_12.2.1.2.0_wls_Disk1_1of1.zip -P /u01/software

CMD ["tail","-f","/dev/null"]