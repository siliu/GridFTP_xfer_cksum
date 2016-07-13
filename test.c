#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){

	
	char *file_list[] = {"10M.data","50M.data","100M.data","500M.data"};
	char filename[100];
	strcat(filename, file_list[1]);

	printf("filename: %s \n", filename);

	//Define different parts of transfer and checksum command string
	char str1[] = "globus-url-copy  ftp://cc117.fst.alcf.anl.gov:50000/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/";
	char str2[] = "globus-url-copy  -sync -sync-level 3  ftp://cc117.fst.alcf.anl.gov:50000/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/";
	char str3[] = " ftp://cc051.fst.alcf.anl.gov:40427/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/checksum_tests/";
	
	char *xfer_cmd;
	char *cksum_cmd;
	
	//Build transfer file command
	int xfer_len = strlen(str1) + strlen(str3) + strlen(filename) + 1;
	if((xfer_cmd = malloc(xfer_len)) != NULL){
		
		memset(xfer_cmd, 0 , xfer_len);
		strcat(xfer_cmd, str1);
		strcat(xfer_cmd, filename);
		strcat(xfer_cmd, str3);
	}

	//Build checksum command
	int cksum_len = strlen(str2) + strlen(filename) + strlen(str3) + strlen(filename) + 1;
		
	if((cksum_cmd = malloc(cksum_len)) != NULL){
		
		memset(cksum_cmd, 0 , cksum_len);	
		strcat(cksum_cmd, str2);
		strcat(cksum_cmd, filename);
		strcat(cksum_cmd, str3);
		strcat(cksum_cmd, filename);
	}

	printf("xfer_cmd = %s \n", xfer_cmd);
	printf("cksum_cmd = %s \n", cksum_cmd);
	
	free(xfer_cmd);
	free(cksum_cmd);
	
}
