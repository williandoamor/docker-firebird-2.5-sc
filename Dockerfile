#Versao a ser craida
FROM ubuntu:16.04
MAINTAINER Willian do Amor <willsazon@gmail.com>

#ENV FIREBIRD_PATH=/opt/firebird
#ENV FIREBIRD_DB_PASSWORD=masterkey
#ENV FIREBIRD_DB_PASSWORD_DEFAULT=masterkey
ENV VOLUME=/firebird

#Atualiza o sistema
RUN apt-get update
#Instala o net-tools para checkagem de rede
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y net-tools
#Instala o editor de texto nano
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nano
#instala o firebird 2.5 superclassic
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y firebird2.5-superclassic
    
#Limpa o cache do apt e remove as listas    
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#Alterar o arquivo firebird.conf para permitir conexao remota
#ao firebird
RUN sed -ri 's/RemoteBindAddress = localhost/RemoteBindAddress = /g' /etc/firebird/2.5/firebird.conf
    
#Cria a pasta /BANCOS para incluir os bancos de dados firebird
RUN mkdir -p /BANCOS && \
    chown -R firebird.firebird /BANCOS && \
    chown -R firebird:firebird /BANCOS      
    
#RUN ln -sf /dev/stdout /var/log/firebird/firebird2.5.log

VOLUME ["/firebird"]
#Libera a posrta pra conexao
EXPOSE 3050/tcp

CMD ["/usr/sbin/fbguard"]
