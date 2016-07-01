$SPARK_HOME/sbin/start-all.sh;
jps;

mv spark-terasort /mnt/raid/
mv gensort /mnt/raid/
mv spark-tera.sh /mnt/raid/
cd /mnt/raid/spark-terasort
sudo apt-get install maven
mvn install
cd /mnt/raid
