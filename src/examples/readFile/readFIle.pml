/*
execue with commands
spin -a readFIle.pml 
cc -o pan pan.c
./pan

*/

int count = 0;

active proctype example(){
	c_code {	
	    FILE *f = fopen("input.txt", "r");
	    char x[1024];

    	while (fscanf(f, " %1023s", x) == 1) {
	        //puts(x);
	        printf("String read: %s\n", x);

		now.count++;
    	}
	
    fclose(f);

	}	

	c_code {printf("%d", now.count);}
}
