#This a script torun the Spark Sort

#Calculats the size of the file
size=`expr $1 \* 100`

#Displays the running processes of hadoop and their ports
jps

#Generates a file of size $1 using gensort
printf "\t\n\n ---------------------Generating $size Byte data----------------------\n\n"
sudo chmod 700 gensort
./gensort -a $1 /mnt/raid/input

#Imports the data from the disk to the HDFS
printf "\t\n\n ---------------------Importing $size Byte data to HDFS----------------------\n\n"
hadoop fs -copyFromLocal /mnt/raid/input /inputfile

#Calculates the Start time
START=$(date +%s.%N)

#Sorting begins
printf "\t ---------------------Sorting $size Byte data ----------------------\n"

spark-submit --class com.rohit.spark.terasort.TeraSort spark-terasort/target/spark-terasort-1.0-SNAPSHOT-jar-with-dependencies.jar hdfs:///inputfile hdfs:///outputfile

#Calculates the END time
END=$(date +%s.%N)

#Finds the execution time
DIFF=$(echo "$END - $START" | bc)

printf "Time for Execution : $DIFF s \n"


printf "\n"

#validates the sorted file using teravalidate
printf "\t---------------------Validating $size Byte data----------------------\n"

spark-submit --class com.rohit.spark.terasort.TeraValidate spark-terasort/target/spark-terasort-1.0-SNAPSHOT-jar-with-dependencies.jar hdfs:///outputfile hdfs:///validatefile

printf "\t---------------------Sorted Output---------------------\n" 
printf "\t---------------------First 10 lines---------------------\n" 
hadoop fs -cat /outputfile/part-r-00000 | head -n 10 
printf "\t---------------------Last 10 lines----------------------\n" 
hadoop fs -cat /outputfile/part-r-00074 | tail -n 10


(printf "\t---------------------Sorted Output---------------------\n" 
printf "\t---------------------First 10 lines---------------------\n" 
hadoop fs -cat /outputfile/part-r-00000 | head -n 10 
printf "\t---------------------Last 10 lines----------------------\n" 
hadoop fs -cat /outputfile/part-r-00074 | tail -n 10
)> terasort-spark-memory-10GB.txt
