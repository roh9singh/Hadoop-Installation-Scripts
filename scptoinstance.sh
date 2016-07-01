#This script willscp the required files and shell required for the installation

#edit config
#(printf "Host namenode\n" 
#printf "  User ubuntu\n" 
#printf "  HostName $1\n"
#printf "  IdentityFile ~/.ssh/$2\n"
#)> ~/.ssh/config;

#touch list.txt 
echo $1 >> list.txt

#upload the general files
scp -i hadoopf.pem permission.sh ubuntu@$1:~/;
scp -i hadoopf.pem hadoopf.pem ubuntu@$1:~/.ssh;
scp -i hadoopf.pem hadoopf.pem ubuntu@$1:~/;
scp -i hadoopf.pem ~/.ssh/config ubuntu@$1:~/.ssh;

#upload the hadoop install scripts
scp -i hadoopf.pem raid.sh ubuntu@$1:~/;
scp -i hadoopf.pem hadoopstep1.sh ubuntu@$1:~/;
scp -i hadoopf.pem hadoopstep2.sh ubuntu@$1:~/;
scp -i hadoopf.pem hadoopstep3.sh ubuntu@$1:~/;
scp -i hadoopf.pem hadoopstep4.sh ubuntu@$1:~/;
scp -r -i hadoopf.pem HadoopSort.jar ubuntu@namenode:~/;

#upload the spark install scripts
scp -i hadoopf.pem sparkstep1.sh ubuntu@$1:~/;
scp -i hadoopf.pem sparkstep2.sh ubuntu@$1:~/;
scp -i hadoopf.pem sparkstep3.sh ubuntu@$1:~/;


#upload the spark folder

#scp -r -i hadoopf.pem spark-terasort/ ubuntu@$1:~/;
scp -i hadoopf.pem share/gensort ubuntu@$1:~/;
scp -i hadoopf.pem spark-tera.sh ubuntu@$1:~/;

#ssh to namenode
#ssh namenode;


#ssh -i hadoopf.pem ubuntu@ec2-52-29-207-141.eu-central-1.compute.amazonaws.com "echo $(hostname)" | ssh -i hadoopf.pem ubuntu@ec2-52-28-153-79.eu-central-1.compute.amazonaws.com "cat >> output.txt"
