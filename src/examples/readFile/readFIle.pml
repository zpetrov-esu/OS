/*
execue with commands
spin -a readFIle.pml 
cc -o pan pan.c
./pan

*/

active proctype example(){
	c_code {	
	    FILE *f = fopen("input.txt", "r");
	    char x[1024];

    	while (fscanf(f, " %1023s", x) == 1) {
	        //puts(x);
	        printf("String read: %s\n", x);
	        
    	}
    fclose(f);

	}
}