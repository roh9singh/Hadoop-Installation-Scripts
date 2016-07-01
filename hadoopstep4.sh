echo "Format HDFS";
hdfs namenode -format;

echo "start dfs, yarn and daemon";
$HADOOP_HOME/sbin/start-dfs.sh; 

$HADOOP_HOME/sbin/start-yarn.sh;

$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver; 

jps;	
