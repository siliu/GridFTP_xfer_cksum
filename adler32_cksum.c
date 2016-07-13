#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <zlib.h>

int main(){

//	char filestream[] = "globus-url-copy  ftp://cc117.fst.alcf.anl.gov:50000/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/";

	//read file into byte array
	FILE *file_ptr;
	char *buffer;
	long file_len;

	file_ptr = fopen("/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/1M.data", "rb");  // Open the file in binary mode
	fseek(file_ptr, 0, SEEK_END);          // Jump to the end of the file
	file_len = ftell(file_ptr);             // Get the current byte offset in the file
	rewind(file_ptr);                      // Jump back to the beginning of the file

	buffer = (char *)malloc(file_len * sizeof(char)); // Enough memory for file + \0
	memset(buffer, 0, file_len);
	fread(buffer, file_len, 1, file_ptr); // Read in the entire file
	fclose(file_ptr); // Close the file
	
	//printf("The 10th element of the  buffer is: %c . \n", buffer[10]);
	
	
 	//Calculate the adler32 of the file stream
	uLong adler = adler32(0L, Z_NULL, 0);
	
	int i = 0;

	for(i = 0 ; i < file_len ; i++){

		adler = adler32(adler, buffer, file_len);
	}
	
	printf("adler = %lu", adler);
	
	
	free(buffer);

}
