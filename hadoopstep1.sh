ssh-keygen -f ~/.ssh/id_rsa -t rsa -P "";
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; 


###############multi copy authrization keys only for Multiple node simulation

<<Com
cat ~/.ssh/id_rsa.pub | ssh datanode1 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode2 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode3 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode4 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode5 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode6 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode7 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode8 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode9 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode10 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode11 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode12 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode13 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode14 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode15 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh datanode16 'cat >> ~/.ssh/authorized_keys'
Com

####################################################################################
sudo apt-get update;
sudo apt-get install openjdk-7-jdk; 
java -version;
wget http://apache.mirrors.tds.net/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz -P ~/Downloads;
sudo tar zxvf ~/Downloads/hadoop-* -C /usr/local; 
sudo mv /usr/local/hadoop-* /usr/local/hadoop;

(echo export JAVA_HOME=/usr
 echo export PATH=\$PATH:\$JAVA_HOME/bin
 echo export HADOOP_HOME=/usr/local/hadoop
 echo export PATH=\$PATH:\$HADOOP_HOME/bin
 echo export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop )>> ~/.profile

 #sudo vi ~/.profile;
 #sleep 5

##################################################################################
source ~/.profile;
echo $HADOOP_CONF_DIR
###################################################################################

