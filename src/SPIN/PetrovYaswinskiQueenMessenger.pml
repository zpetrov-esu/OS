/* Authors: Jason Petrov & Matthew Yaswinski
 * Emails: zpetrov@live.esu.edu & myaswinski@live.esu.edu
 * Queen and Messengers
 * November 23, 2021 */
 

//global thread counter
byte threadCounter = 0;

// max messages
int bufferLength = 26;

// int for signaling critical section
int criticalSection = 0;

// counter for loop in queen process
int loopCounter = 0;

/*
* M - thread number;
* PRIORITY - message priority 0-26;
* MESSAGE - the actual message text AA - ZZ 
*/
typedef msg {
	byte N; 
	byte PRIORITY; 
	mtype:msgText MESSAGE
};

// channel for sending messages
chan data = [26] of { msg }

// message text data type
mtype = {ZZ, YY, XX, WW, VV, UU, TT, SS, RR, QQ, PP, OO, NN, MM, LL, KK, JJ, II, HH, GG, FF, EE, DD, CC, BB, AA};

// array of all incoming messages
msg messages[bufferLength];

// random number;
byte randNum;

// generates a random number from 1-26;
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
}
 
// create messages to send to queen
proctype generateMessage(){
 	int i;
	for (i : 0..bufferLength-1) { 
		run generateNum();
		/********************/
		messages[i].N = threadCounter; 
		messages[i].PRIORITY = randNum; 
		run generateNum(); // used to assign different priorities for each message
		messages[i].MESSAGE = randNum; 
		threadCounter++;
	}

	// sending message in channel
	int k;
	for (k : 0..bufferLength-1) {
		data!messages[k];
	}
}


// queen processes for reading channel and determining message to consume
proctype queen(){
	do
	:: loopCounter != bufferLength ->
		// default priority and consumed message index for each iteration
		byte highestPriority = 27;
		int indexRedMsg = -1;
  
		// beginning of critical section using counting semaphore
		criticalSection = 1;

		atomic{
			if
			:: (criticalSection == 1) -> 
				printf("****************Entering Queen's Chamber**********\n");
				// queen reading data from channel
		  		msg receivedMessages[bufferLength];
		  		int l;
				for(l : 0..bufferLength - 1){
		    			data?receivedMessages[l];

		    			// checks the message with the lowest priority 
		    			if
		    			:: (highestPriority > receivedMessages[l].PRIORITY ) -> 
		    				highestPriority = receivedMessages[l].PRIORITY;
		    				indexRedMsg = l;
		    			:: else skip;
					fi
				}

				// decrement the priority for all messages with a priority higher than 1 and less than 101
				int z;
				for (z : 0..bufferLength-1) { 
					if
					::(receivedMessages[z].PRIORITY > 1 && receivedMessages[z].PRIORITY < 101) -> receivedMessages[z].PRIORITY = receivedMessages[z].PRIORITY - 1;
					::else skip;
					fi

		  		}
			fi

			// end of critical section
			criticalSection = 0;


			// remainder section

			// print messages with priorities
			printf("Messages received from channel:\n"); 
			int m;
			for (m : 0..bufferLength-1) { 
				printf(" Message priority: %d", receivedMessages[m].PRIORITY);
		 		printf(" Message index: %d", receivedMessages[m].MESSAGE);
				printf(" Mesage text: ");
		 		printm(receivedMessages[m].MESSAGE);
				printf("\n");
			}
			printf("\n\n");
      
			printf("Message received by Queen: ");
			printm(receivedMessages[indexRedMsg].MESSAGE);
			printf("\n\n");
      
			// set the message as red by changing the priority
			receivedMessages[indexRedMsg].PRIORITY = 101;

			// repopulate channel
			int k;
			for (k : 0..bufferLength-1) {
				data!receivedMessages[k];
			}

			loopCounter++;

	}
	od
}

init {
	run generateMessage();
	run queen();
}

