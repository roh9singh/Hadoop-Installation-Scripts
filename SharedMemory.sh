#This a script torun the Shared Memory Sort

#To install dos2unix command
sudo apt-get install dos2unix

#Calculats the size of the file
size=`expr $1 \* 100`

#Generates a file of size $1 using gensort
printf "\n\t ---------------------Generating $size Byte data----------------------\n"
sudo chmod 700 gensort
./gensort -a $1 inputfile


#A loop for number of threads
for i in 1 2 4 8
do

#Sorting begins
printf "\t ---------------------Sorting $size Byte data for $i Threads ----------------------\n"

#Calculates the Start time
START=$(date +%s.%N)

#Runs the jar file
java -jar SharedMemorySort.jar $i

#Calculates the END time
END=$(date +%s.%N)

#Finds the execution time
DIFF=$(echo "$END - $START" | bc)


printf "Time for Execution for Thread $i : $DIFF s \n"
printf "\n"

#converts the file from unix to dos format
unix2dos outputfile

#validates the sorted file using valsort
printf "\t---------------------Validating $size Byte data----------------------\n"

./valsort outputfile 

done
#loop ends

#prints the first and last 10 lines of the outputfile
printf "\t---------------------Sorted Output---------------------\n" 
printf "\t---------------------First 10 lines---------------------\n" 
head outputfile -n 10 
printf "\t---------------------Last 10 lines----------------------\n" 
tail outputfile -n 10 

#redirects the first and last 10 lines of the outputfile to another file
(printf "\t---------------------Sorted Output---------------------\n" 
printf "\t---------------------First 10 lines---------------------\n" 
head outputfile -n 10 
printf "\t---------------------Last 10 lines----------------------\n" 
tail outputfile -n 10 
)> terasort-shared-memory-10GB.txt
