/*run with command: spin -s -r -X -g file.pml */
 


//global thread counter
byte threadCounter = 0;

// max messages
//int bufferLength = 3;
int bufferLength = 26;

// int for signaling critical section
int criticalSection = 0;

// channel for sending messages


/*
M - thread number;
PRIORITY - message priority 0-9;
MESSAGE - the actual message text AA - ZZ 
*/
typedef msg {
	byte N; 
	byte PRIORITY; 
	mtype:msgText MESSAGE
};

chan data = [26] of { msg }

//message text data type
mtype = {ZZ, YY, XX, WW, VV, UU, TT, SS, RR, QQ, PP, OO, NN, MM, LL, KK, JJ, II, HH, GG, FF, EE, DD, CC, BB, AA};

// array of all incoming messages
msg messages[bufferLength];

//random number;
byte randNum;

//generates a random number from 1-26;
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
  :: randNum = 11
  :: randNum = 12
  :: randNum = 13
  :: randNum = 14
  :: randNum = 15
  :: randNum = 16
  :: randNum = 17
  :: randNum = 18
  :: randNum = 19
  :: randNum = 20
  :: randNum = 21
  :: randNum = 22
  :: randNum = 23
  :: randNum = 24
  :: randNum = 25
  :: randNum = 26
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
                            


/*
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
*/

 
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
                            
  // sending message in channel
  int k;
  for (k : 0..bufferLength-1) {
    printf("Sending message in element %d in channel\n",messages[k].MESSAGE);
    data!messages[k];
  }

  // enter critical section
  do
  :: (criticalSection == 0) -> criticalSection = 1; break
  od
  
  // queen reading data from channel
  msg receivedMessages[bufferLength];
  
  int l;
  for(l : 0..bufferLength - 1){
    data?receivedMessages[l];
    printf("Copied message %d from channel\n", receivedMessages[l].MESSAGE);
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




	
	int m;
	for (m : 0..bufferLength-1) { 
		printf("\nARR: Thread Index index: %d", messages[m].N);
		printf("\nARR: MSG PRIORITY index: %d", messages[m].PRIORITY);
 		printf("\nARR: MSG index: %d\n", messages[m].MESSAGE);
 		printf("ARR: Mesage text: ");
 		printm(messages[m].MESSAGE);
 		printf("\n");
	}
	
//goto loop;

  // end critical section
  criticalSection = 0;

}






init {
	run generateMessage();
}

 
