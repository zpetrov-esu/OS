/*run with command: spin -s -r -X -g file.pml */
 


//global thread counter
byte threadCounter = 0;

// max messages
int bufferLength = 3;

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
msg messages[bufferLength];

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
 

proctype generateMessage(){
 	int i;
	for (i : 0..bufferLength-1) { 
		run generateNum();
		/********************/
		messages[i].N = threadCounter; 
		messages[i].PRIORITY = randNum; 
		messages[i].MESSAGE = randNum; 
		threadCounter++;
	}


	//sort the array
	int mCounter = 0;
	int m;
	int n;
	for (m: 0..bufferLength-1){
		printf("\nWelcome from m: %d",m);
			for (n: 0..bufferLength-m-2){
				printf("\n\tWelcome from n: %d",n);
				//msg x = messages[n];
				//messages[n] = messages[n+1];
				//messages[n+1] = x;
				printf(" Sort %d >  %d", messages[n].PRIORITY,messages[n+1].PRIORITY);
			}
	}


 
 /*
printf("\nSort %d >  %d", messages[arrCount].PRIORITY,messages[arrCount+1].PRIORITY);
 */


	//print the generate data;
	int j;
	for (j : 0..bufferLength-1) { 
		printf("\nARR: Thread Index index: %d", messages[j].N);
		printf("\nARR: MSG PRIORITY index: %d", messages[j].PRIORITY);
 		printf("\nARR: MSG index: %d\n", messages[j].MESSAGE);
 		printf("ARR: Mesage text: ");
 		printm(messages[j].MESSAGE);
 		printf("\n");
	}

// testing block for adding an new message after the one with the highest priority is red by the queen
// assumes that the message with the highest priority is at index 0 in the array
// as I dont see a better way to implement a priority queue in promela I would say that we have to sort the array by priority 
// the message with the highest priority have to be at index 0, this way we can send message at index 0 to the queen to read
loop:

	messages[0].PRIORITY = 99 

	if
	::messages[0].PRIORITY == 99 ->
		printf("\nUpdating the priority");
		run generateNum();
		messages[0].N = threadCounter; 
		messages[0].PRIORITY = randNum; 
		messages[0].MESSAGE = randNum; 
		threadCounter++;
	fi




	
	int k;
	for (k : 0..bufferLength-1) { 
		printf("\nARR: Thread Index index: %d", messages[k].N);
		printf("\nARR: MSG PRIORITY index: %d", messages[k].PRIORITY);
 		printf("\nARR: MSG index: %d\n", messages[k].MESSAGE);
 		printf("ARR: Mesage text: ");
 		printm(messages[k].MESSAGE);
 		printf("\n");
	}
	
//goto loop;

}






init {
	run generateMessage();
}

 