#This a script torun the Hadoop Sort


#Calculats the size of the file
size=`expr $1 \* 100`

#Displays the running processes of hadoop and their ports
jps

#displays the contents of the HDFS
hadoop fs -ls /


#Generates a file of size $1 using gensort
printf "\n\n\t ---------------------Generating $size Byte data----------------------\n\n"
sudo chmod 700 gensort
./gensort -a $1 /mnt/raid/input

#Imports the data from the disk to the HDFS
printf "\t\n\n ---------------------Importing $size Byte data to HDFS----------------------\n\n"
hadoop fs -copyFromLocal /mnt/raid/input /rohit


#Calculates the Start time
START=$(date +%s.%N)

#Sorting begins
printf "\t ---------------------Sorting $size Byte data----------------------\n"
hadoop jar HadoopSort.jar terasort /rohit /rohit1

#Calculates the END time
END=$(date +%s.%N)

#Finds the execution time
DIFF=$(echo "$END - $START" | bc)

printf "Time for Execution: $DIFF s \n"


#validates the sorted file using teravalidate
printf "\t---------------------Validating $size Byte data----------------------\n"

hadoop jar HadoopSort.jar teravalidate /rohit1 /val

printf "\t---------------------Sorted Output---------------------\n" 
printf "\t---------------------First 10 lines---------------------\n" 
hadoop fs -cat /rohit1/part-r-00000 | head -n 10 
printf "\t---------------------Last 10 lines----------------------\n" 
hadoop fs -cat /rohit1/part-r-00000 | tail -n 10

(printf "\t---------------------Sorted Output---------------------\n" 
printf "\t---------------------First 10 lines---------------------\n" 
hadoop fs -cat /rohit1/part-r-00000 | head -n 10 
printf "\t---------------------Last 10 lines----------------------\n" 
hadoop fs -cat /rohit1/part-r-00000 | tail -n 10
)> terasort-hadoop-single-10GB.txt
