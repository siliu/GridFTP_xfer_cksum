#include <stdio.h>

int main(int argc, char **argv) {

  char input[1024*1024*10];
  int size = 1024*1024*10;

  int k;
  for(k = 0 ; k < size ; k++){
    input[k] = 'a';
  }

  FILE *fp = fopen("10M.data", "w");

  fwrite(input, 1, sizeof(input), fp);

  fclose(fp);

  /*FILE *fp;*/
  /*char str[] = "This is tutorialspoint.com";*/

  /*fp = fopen( "file.txt" , "w" );*/
  /*fwrite(str , 1 , sizeof(str) , fp );*/

  /*fclose(fp);*/

  return 0;
}
