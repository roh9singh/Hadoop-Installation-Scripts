//This code is to sort data using shared memory on java using merge sort as the base sort

import java.util.*;
import java.io.*;
import java.util.Scanner;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


/*Shared Memory Sort*/
public class SharedMemorySort 
{
    public static void main(String[] args) 
    {    
		//It uses the Executer service to call the threads
        ExecutorService executorService = null;
		
		//The Executer Service is initialized with the nuber of threads passes as an argument by the user
 		executorService=Executors.newFixedThreadPool(Integer.parseInt(args[0]));   		 
        executorService.submit(new MySort(Integer.parseInt(args[0])));			
        executorService.shutdown();
		
    }
}

/*MyMergeSort*/
public class MyMergeSort implements Runnable
{
    int id;
	
	//Constructor for MySort
    public MyMergeSort(int th) throws IOException
	{
        id=th;
    }
    
    public void run() 
	{
        String InpFile = "inputfile", OutFile = "outputfile",line="";
		File file=new File(InpFile);
        double Split=0,i,sizeBlock=0,j,k;
		
		//Creates a list of File and String pointers
		List<File> partiFiles = new ArrayList<File>();
		List<String> temporaryList =  new ArrayList<String>();
        BufferedReader bufferedReader = new BufferedReader(new FileReader(file));
        
		//Calculate size in which the files need to be split based on the freememory 
        double Split=file.length()/1024;
        Split=(Split<(Runtime.getRuntime().freeMemory())/2)?(Runtime.getRuntime().freeMemory())/2:null;
        
        
		do  
		{
           sizeBlock = 0;
           while(((line = bufferedReader.readLine())!=null) && (sizeBlock < Split) )
		   {
			   temporaryList.add(line);
			   i++;
           }
           sizeBlock =sizeBlock+(i*line.length()*2);
		   i=0;
		   //The files are partitioned and sent to SortFile function to get sorted individually
           partiFiles.add(SortFile(temporaryList,comparator));
           temporaryList.clear();
        }while(line != null);
		
		//after the files have beeen partitioned then we merge these files
        mergeFiles(partiFiles,comparator);
    }

    public File SortFile(List<String> tmp, String comp)   
	{
		//Each file is sorted in this function
		tmp=Partition_sort(tmp,comp);  
        File tmpfile = File.createTempFile("sortInBatch", "flatfile",new File("/mnt/raid"));
        
		BufferedWriter fbw = new BufferedWriter(new FileWriter(newtmpfile));
        for(String r : tmp) 
		{
                fbw.write(r);
                fbw.newLine();
        }
        
		return tmpfile;
    }
	
	public Partition_sort(List<String> tmp, String comp,int l, int h)
	{
		int m=l + (h-l)/2;
		
		if (l < h) 
		{
            //This sorts the left side of the array
			Partition_sort(tmp,comp,l,m);
			
            // This sorts the right side of the array
			Partition_sort(tmp,comp,m+1,h);

            // Now merge both sides

            for (int i = lowerIndex; i <= higherIndex; i++) 
			{
				tempArr[i] = tmp[i];		//copy the section to a temporary array
			}
			int i = l,j = m+1,k=l;			//initialize the values
			
			while (i <= m && j <= h) 
			{
				if (tempArr[i] <= tempArr[j]) 
				{
					tmp[k] = tempArr[i];
					i++;
				}
				else 
				{
					tmp[k] = tempArr[j];
					j++;
				}
				k++;
			}
			
			//rest of the array left is copied 
			while (i <= middle) 
			{
				tmp[k] = tempMergArr[i];
				k++;
				i++;
			}
			
			return tmp		//return the sorted array
 
        }
		
		
	}
	//Files are merged in this function
    public static int mergeFiles(List<File> files, String> comp)
	{
		String r ="";
        Prioritybuffeue<BinaryFileBuffer> buff = new Prioritybuffeue<BinaryFileBuffer>();

        while(File fi : files) 
		{
            BinaryFileBuffer buff = new BinaryFileBuffer(fi);
            qu.add(buff);
        }
       
        BufferedWriter fbw = new BufferedWriter(new FileWriter(outputfile));
     
        do  
		{
            fbw.write(buff.pop());
        }while(qu.size()>0);
         
    }
 }

	
	
 
 

