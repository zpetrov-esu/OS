/*run with command: spin -s -r -X -n3 -g hw1_v2.pml*/
 


//global thread counter
byte threadCounter = 0;

/*
M - thread number;
PRIORITY - message priority 0-9;
MESSAGE - the actual message text MSG1 - MSG10 
*/
typedef msg {
	byte N; 
	byte PRIORITY; 
	mtype:msgText MESSAGE
};

//message text data type
mtype = {MSG10, MSG9, MSG8, MSG7, MSG6, MSG5, MSG4, MSG3, MSG2, MSG1};

// array of all incoming messages
msg messages[20];

//random number;
byte randNum;

//generates a random number from 1-10;
proctype generateNum(){
if 
	:: randNum = 1 
	:: randNum = 2 
	:: randNum = 3 
	:: randNum = 4 
	:: randNum = 5 
	:: randNum = 6 
	:: randNum = 7 
	:: randNum = 8 
	:: randNum = 9 
	:: randNum = 10
fi		
	//printf("The number is %d\n" , randNum);

}
 

proctype test(){
	
 	int i;
	for (i : 0..19) { 

		run generateNum();
		/********************/
		messages[i].N = threadCounter; 
		messages[i].PRIORITY = randNum; 
		messages[i].MESSAGE = randNum; 
	}

	//print the generate data;
	for (i : 0..19) { 
		printf("\nARR: MSG PRIORITY index: %d", messages[i].PRIORITY);
 		printf("\nARR: MSG index: %d\n", messages[i].MESSAGE);
 		printf("ARR:  Mesage text: ");
 		printm(messages[i].MESSAGE);
 		printf("\n");
	}
}



init {
	run test();
}

 