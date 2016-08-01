#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#define THREADS_NUM 4

//Define counter mutex
pthread_mutex_t counter_mutex;

//Define counter variable to identify the next file to transfer
//counter is accessed by all threads
int counter = 0;

//Declare the file list array
//char *file_list[] = {"10M.data","100M.data","500M.data","1G.data","2G.data","5G.data","10G.data","20G.data","50G.data","100G.data"};
char *file_list[] = {"10G.data1","10M.data1","10G.data2","10M.data2","10G.data3","10M.data3","10G.data4","10M.data4","10G.data5","10M.data5","10G.data6","10M.data6","10G.data7","10M.data7","10G.data8","10M.data8","10G.data9","10M.data9","10G.data10","10M.data10" };
//char *file_list[] = {"10G.data1","10G.data2","10G.data3","10G.data4","10G.data5","10G.data6","10G.data7","10G.data8","10G.data9","10G.data10","10G.data11","10G.data12","10G.data13","10G.data14","10G.data15","10G.data16","10G.data17","10G.data18","10G.data19","10G.data20"};

//Define the number of files to transfer
int N = 20;

//Declare the thread routine
void *xferFile(void *vargp);

int main(){
	
	//Define the thread id list
	pthread_t threads[THREADS_NUM];

	//Initialize the counter_mutex
	pthread_mutex_init(&counter_mutex, NULL);
	
	printf("Start transferring ... \n");

	//clock_t start = clock();

	//Create threads. tn is the index of the thread id in the thread id list
	int tn;
	for(tn = 0 ; tn < THREADS_NUM ; tn++){

		pthread_create(&threads[tn], NULL, xferFile, &tn);
	
	}


	//Wait for all threads to complete	
	for(tn = 0 ;  tn < THREADS_NUM ; tn++){	
	
		pthread_join(threads[tn], NULL);
	
	}
	
	//clock_t end = clock();
	
	printf("All transfers finished. \n");

	//double time_taken = (double)(end - start)/CLOCKS_PER_SEC;

	//printf("The time taken to transfer files is: %f. \n", time_taken);
	
	pthread_mutex_destroy(&counter_mutex);

	exit(0);
}


//Define different parts of transfers and checksum command string
char str1[] = "globus-url-copy  ftp://cc120.fst.alcf.anl.gov:37119/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/";
char str2[] = "globus-url-copy  -sync -sync-level 3  ftp://cc120.fst.alcf.anl.gov:37119/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/";
char str3[] = " ftp://cc112.fst.alcf.anl.gov:33825/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/";

//Thread routine: grab file from the file_list queue and start the transfer
void *xferFile(void *arg){

	int tn = *(int *)(arg);
	//printf(" tn =  %d \n", tn);

	char *xfer_cmd;
	char *cksum_cmd;

	int xfer_len;
	int cksum_len;

	int local_counter = 0;
	char filename[50];

	while(counter < N){

		//printf(" counter =  %d \n", counter);
		//printf("Thread: %p \n", (void *)pthread_self());
	
		printf("%d : %p \n", counter, (void *)pthread_self());
	
		pthread_mutex_lock(&counter_mutex);
		
		local_counter = counter;
		counter = counter + 1;

		pthread_mutex_unlock(&counter_mutex);

		char filename[50];		
		memset(filename, 0 , sizeof(filename));
		strcpy(filename, file_list[local_counter]);	

		//Build transfer file command
		xfer_len = strlen(str1) + strlen(str3) + strlen(filename) + 1;
        	if((xfer_cmd = malloc(xfer_len)) != NULL){

                	memset(xfer_cmd, 0 , xfer_len);
                	strcat(xfer_cmd, str1);
                	strcat(xfer_cmd, filename);
                	strcat(xfer_cmd, str3);
        	}else{
			exit(0);
		}		
		
	//	printf("xfer_cmd = %s \n", xfer_cmd);
		
		//Build checksum command
		cksum_len = strlen(str2) + strlen(filename) + strlen(str3) + strlen(filename) + 1;
		if((cksum_cmd = malloc(cksum_len)) != NULL){

                	memset(cksum_cmd, 0 , cksum_len);
                	strcat(cksum_cmd, str2);
                	strcat(cksum_cmd, filename);
                	strcat(cksum_cmd, str3);
                	strcat(cksum_cmd, filename);
        	}else{
			exit(0);
		}
		
	//	printf("cksum_cmd = %s \n", cksum_cmd);
		
		system(xfer_cmd);
		system(cksum_cmd);
		
		free(xfer_cmd);
		free(cksum_cmd);
	}

	return NULL;
} 
