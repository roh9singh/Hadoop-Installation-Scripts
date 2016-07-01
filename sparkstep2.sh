sudo chown -R ubuntu $SPARK_HOME; 

cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh; 


(echo #!/usr/bin/env bash
echo # This file is sourced when running various Spark programs.
echo # Copy it as spark-env.sh and edit that to configure Spark for your site.
echo export JAVA_HOME=/usr
echo export SPARK_PUBLIC_DNS="$1"
echo export SPARK_WORKER_CORES=6) >> $SPARK_HOME/spark-env.sh

#sudo vi $SPARK_HOME/spark-env.sh;





 



