
#include <stdio.h>  /* printf */
#include <stdlib.h> /* fopen, fseek, ... */
#include <time.h>
#include <math.h>

void readFileFun(char file[]);

int main(){

  char file1[] = "/gpfs/mira-fs1/projects/Concerted_Flows/EPSON/md5_data/1K.data";

//  clock_t start = clock();

  readFileFun(file1);

  //clock_t end = clock();

  //double time_taken = ((double)(end - start))/CLOCKS_PER_SEC;

  //printf("The time taken to read the file is: %f. \n", time_taken);

}

void readFileFun(char file[]){


    char *buffer = NULL;
    size_t size = 0;

    /* Open your_file in read-only mode */
    FILE *fp = fopen(file, "r");

    /* Get the buffer size */
    fseek(fp, 0, SEEK_END); /* Go to end of file */
    size = ftell(fp); /* How many bytes did we pass ? */

    /* Set position of stream to the beginning */
    rewind(fp);

    /* Allocate the buffer (no need to initialize it with calloc) */
    buffer = malloc((size + 1) * sizeof(*buffer)); /* size + 1 byte for the \0 */

    /* Read the file into the buffer */
    fread(buffer, size, 1, fp); /* Read 1 chunk of size bytes from fp into buffer */

    /* NULL-terminate the buffer */
    buffer[size] = '\0';

}
