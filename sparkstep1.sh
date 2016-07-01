echo "Install Scala";
sudo apt-get install scala; 
scala -version; 

wget http://apache.mirrors.tds.net/spark/spark-1.4.1/spark-1.4.1-bin-hadoop2.4.tgz -P ~/Downloads; 
sudo tar zxvf ~/Downloads/spark-* -C /usr/local; 
sudo mv /usr/local/spark-* /usr/local/spark;

#sudo vi ~/.profile;
(echo export SPARK_HOME=/usr/local/spark
 echo export PATH=\$PATH:\$SPARK_HOME/bin) >> ~/.profile
sleep 5;

#########################################
source ~/.profile;
#########################################



