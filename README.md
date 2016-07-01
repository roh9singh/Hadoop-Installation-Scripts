# Hadoop-Installation-Scripts


################################################################################

1) This is an Stepwise instruction file for Running the Shared Memory Sort, Hadoop and Spark sort and Hadoop-Spark Installation 

2) Replace the words which are enclosed in <> with an IP or a value as directed in the documnet.2) 

3) The key file I have used is hadoopf.pem, so you need to change the key file name in the scptoinstance.sh file. 

4) Use a Terminator in case of Multiple Node installation





####################################Shared Memory###############################
1) Go to the folder Code
2) Give permission to the script
			sudo chmod 700 SharedMemory.sh
3) Run the script followed by the size of the file you want to generate and sort
			./SharedMemory.sh <File Size>
	File Size = 100000000 for 10GB and 10000000 for 1GB
	
	
	
####################################Hadoop Execution####################################

1) Go to the folder Code
2) Give permission to the script if running hadoop on local machine
			sudo chmod 700 Hadoop_Sort.sh
			
		#else SCP to the instance the script and the jar file then give permission to the script on that machine
			
			scp -i key.pem Hadoop_Sort.sh ubuntu@namenode:~/;		
			scp -i key.pem HadoopSort.jar ubuntu@namenode:~/;
		
3) Run the script followed by the size of the file you want to generate and sort
			./Hadoop_Sort.sh <File Size>
	File Size = 100000000 for 10GB and 10000000 for 1GB
	



####################################Spark Execution####################################

1) Go to the folder Code
2) Give permission to the script if running hadoop on local machine
			sudo chmod 700 spark-tear.sh
			
		#else SCP to the instance the script and the jar file then give permission to the script on that machine
			
			scp -i key.pem spark-tear.sh ubuntu@namenode:~/;		
			scp -r -i key.pem spark-terasort/ ubuntu@namenode:~/;
		
3) Run the script followed by the size of the file you want to generate and sort
			./spark-tear.sh <File Size>
	File Size = 100000000 for 10GB and 10000000 for 1GB

	
	
	
			
####################################Hadoop and Spark (Automated Installation Scripts for Multi Node)###############################
1)	Go to the folder Code and create a list of public dns for all the 17 nodes on your local machine

2)	Create a file named config in ~/.ssh on your local machine (a sample config file is present in the Code Folder)
			gedit ~/.ssh/config
	Note: Keep a copy of the .pem key file at ~/.ssh folder on your local machine

3)	Steps for Name Node only

		Type the comands on your local machine
			sudo chmod 700 scptoinstance.sh 
			./scptoinstance.sh <NameNode Public DNS>
			ssh namenode

		Following steps to be run on the Master node terminal
			# run permisssion script on master node, as it will give permisssion to all the scripts required for this installation
			sudo chmod 700 permission.sh	
			./permission.sh
			
			# Do Raid for master node
			vi raid.sh 
			./raid.sh
			
			#If you are trying to install Multiple Node then you need to UnComment the Autorization key section in hadoopstep1.sh and run it
			./hadoopstep1.sh 

			. ~/.profile	

			#run hadoopstep2 to set up to install Java Hadoop and the configuartion files
			./hadoopstep2.sh  <NameNode Public DNS>
			
			
			
			
3)	Steps for Data Nodes only

		Type the comands on your local machine
			
			First comment the the Autorization key section in hadoopstep1.sh in hadoopstep1.sh 
			
			./slaves.sh <datanode1 Public DNS> ..... <datanode16 Public DNS>
			ssh datanode1
			....
			ssh datanode16

		Following steps to be run on the Master node terminal	
			sudo chmod 700 permission.sh	
			./permission.sh
			
			# Do Raid for master node
			./raid.sh

			#comment the Com section in hadoopstep1.sh and run it
			./hadoopstep1.sh 

			. ~/.profile	
			
			#run hadoopstep3 to set up to install Java Hadoop and the configuartion files
			./hadoopstep3.sh  <NameNode Public DNS>


			#run this on all 16 nodes in the same order as written in config file that is datanode1 .... datanode16
			echo $(hostname) | ssh -i hadoopf.pem ubuntu@namenode "cat >> Hostnames.txt"


4) Configure the /etc/hosts master and slave files on the NameNode only in case of Multiple Nodes, as for the single node all configurations have been done by the hadoopstep2.sh script

			You can now access the Hostnames.txt file on the master node which contains the hostnames of all the slave nodes at one place

			#Append the dns and host names in /etc/hosts as shown in the screenshot of the report
			sudo vim /etc/hosts;
	
			#to feed the master file with the hostname of the namenode
			sudo echo $(hostname) > $HADOOP_CONF_DIR/masters;
			
			#append the ip of slaves
			sudo vim $HADOOP_CONF_DIR/slaves;			

5) Start hadoop


			#on all 16 nodes
			./hadoopstep4.sh 

			#if correct then on master node 
			./hadoopstep4.sh 

			
6) To install Spark

		# The following is to be done on all the nodes
			./sparkstep1.sh 

			. ~/.profile	

			./sparkstep2.sh <NameNode Public DNS>  

		#Only for Namenode in case of Multinode simulation 
			
			touch $SPARK_HOME/conf/slaves

			#add the 16 publiv DNS of the datanodes
			sudo vim $SPARK_HOME/conf/slaves

		#On the slave node in case of multiple node
			./sparkstep3.sh 

		#if correct then on master node 
			./sparkstep3.sh 
			
			

			
			

	

