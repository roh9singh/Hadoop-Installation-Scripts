echo "Hadoop Configurations for allnodes";


echo "Configure:$HADOOP_CONF_DIR/hadoop-env.sh";
sudo sed -i 's@${JAVA_HOME}@/usr@' $HADOOP_CONF_DIR/hadoop-env.sh;
#sudo vim $HADOOP_CONF_DIR/hadoop-env.sh;



echo "Configure:$HADOOP_CONF_DIR/core-site.xml";
sudo sed -i "/<configuration>/a<property>\n  <name>fs.defaultFS</name>\n  <value>hdfs://$1:9000</value>\n</property>\n<property>\n  <name>hadoop.tmp.dir</name>\n  <value>/mnt/raid/</value>\n</property>" $HADOOP_CONF_DIR/core-site.xml;
#sudo vim $HADOOP_CONF_DIR/core-site.xml;




echo "Configure:$HADOOP_CONF_DIR/yarn-site.xml";
sudo sed -i "/<configuration>/a<property>\n  <name>yarn.nodemanager.aux-services</name>\n  <value>mapreduce_shuffle</value>\n</property>\n<property>\n  <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>\n  <value>org.apache.hadoop.mapred.ShuffleHandler</value>\n</property>\n<property>\n  <name>yarn.resourcemanager.hostname</name>\n  <value>$1</value>\n</property>" $HADOOP_CONF_DIR/yarn-site.xml;
#sudo vim $HADOOP_CONF_DIR/yarn-site.xml;



echo "Configure:$HADOOP_CONF_DIR/mapred-site.xml";
source ~/.profile;

##########################################################################

sudo cp $HADOOP_CONF_DIR/mapred-site.xml.template $HADOOP_CONF_DIR/mapred-site.xml;
sudo sed -i "/<configuration>/a<property>\n  <name>mapreduce.jobtracker.address</name>\n  <value>$1:54311</value>\n</property>\n<property>\n  <name>mapreduce.framework.name</name>\n  <value>yarn</value>\n</property>\n<property>\n  <name>mapred.tasktracker.map.tasks.maximum</name>\n  <value>4</value>\n  <final>true</final>\n</property>\n<property>\n      <name>mapred.tasktracker.reduce.tasks.maximum</name>\n  <value>4</value>\n  <final>true</final>\n</property>" $HADOOP_CONF_DIR/mapred-site.xml;
#sudo vim $HADOOP_CONF_DIR/mapred-site.xml;

########################################Datanode##########################


echo "Configure:$HADOOP_CONF_DIR/hdfs-site.xml"
sudo sed -i "/<configuration>/a<property>\n  <name>dfs.replication</name>\n  <value>1</value>\n</property>\n<property>\n  <name>dfs.datanode.data.dir</name>\n  <value>file:///mnt/raid/hdfs/datanode</value>\n</property>" $HADOOP_CONF_DIR/hdfs-site.xml;	
#sudo vim $HADOOP_CONF_DIR/hdfs-site.xml;

sudo mkdir -p $HADOOP_HOME/hadoop_data/hdfs/datanode;
sudo chown -R ubuntu $HADOOP_HOME;



######################################################################3





