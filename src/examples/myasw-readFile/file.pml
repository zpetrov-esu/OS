/*run with command: spin -s -r -X -g file.pml */
 


//global thread counter
byte threadCounter = 0;

// arbitrary number of max messageis
int bufferLength = 2;

/*
M - thread number;
PRIORITY - message priority 0-9;
MESSAGE - the actual message text MSG1 - MSG10 
*/

/*
typedef msg {
	byte N; 
	byte PRIORITY; 
	mtype:msgText MESSAGE
};
*/

//message text data type
mtype = {MSG10, MSG9, MSG8, MSG7, MSG6, MSG5, MSG4, MSG3, MSG2, MSG1};

// array of all incoming messages
msg messages[bufferLength];

mtype:msgText messageTest[9];

/*
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
 
*/
// Read file using embedded C code

c_state "FILE * f" "Global"
c_state "ssize_t read" "Global"
c_state "char * line" "Global"
c_state "size_t leng" "Global"
c_state "int counter" "Global"

proctype readFile(){
  c_code { now.f = fopen("messages.txt", "r"); };
  c_code { now.read = getline(&now.line, &now.leng, now.f); };
  c_code { now.leng = 0; };
  c_code { now.counter = 0; };
  do
  :: c_expr { now.read != -1 } ->
      c_code { now.messageTest[now.counter] = now.line; }; c_code { printf("%s", now.messageTest[now.counter]); }; c_code { now.counter++; }; c_code { now.read = getline(&now.line, &now.leng, now.f); }
  :: else -> break
  od;
}

/*
proctype generateMessage(){
 	int i;
	for (i : 0..bufferLength-1) { 
		run generateNum();
		messages[i].N = threadCounter; 
		messages[i].PRIORITY = randNum; 
		messages[i].MESSAGE = randNum; 
		threadCounter++;
	}
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
	
goto loop;

}
*/


init {
	//run generateMessage();
  run readFile();
}

 
