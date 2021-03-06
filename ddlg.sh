#! /bin/bash
# ____  ____  _     ____ 
#|  _ \|  _ \| |   / ___|
#| | | | | | | |  | |  _ 
#| |_| | |_| | |__| |_| |
#|____/|____/|_____\____|
                        # v0.1
#A script to dynamically generate dmenu based dialog's on demand
#Sections marked with 'TRBL' are used to troubleshoot any errors. Enable the respective 'echo' to see if the value flow is correct and the value being output is the one you desire.

#ALGORITHM
#1.Check first if number of arguments is 1+even : 1st is the prompt message itself and  rest are the pair of values and its corresponding command to be executed in the format: "PromptText" label1 command1 label2 command2 label3 command3..........label* command*
#2.Pipe alternate values of args(starting from 2nd to the last) to dmenu along with the prompt(first arg).
#3.Store the output generated by dmenu into a variable
#4.Compare this value against the list of alternate args and get the position of the argument that matches.
#5.Increment the position value and execute the command.


#CODE

if [ "$(($#%2))" == "1" ]
   then


  #---!Custom-Colors:If you uncomment this make sure to comment the Default-Colors
 	CHOICE=$( for((i=2;i<=$#;i=i+2));do echo "${!i}"; done | dmenu -sb '#A52A2A' -sf black -nf '#A52A2A' -nb black -i -p "$1" )		

  #---!Default-Colors:If you uncomment this make sure to comment the Custom-Colors
#	CHOICE=$( for((i=2;i<=$#;i=i+2));do echo "${!i}"; done | dmenu -i -p "$1" )		


	#TRBL: To test if dmenu's outputs the correct choice
	#echo $CHOICE


	#Running the same loop again to compare to CHOICE
	MATCH=0
	for((i=2;i<=$#;i=i+2));
	do
	  if [ "$CHOICE" == "${!i}" ];
	  then 
		  let MATCH=i+1  &&  break
	  fi
	done

	#TRBL: To check what code executes -this will be the command that you decided to execute if the preceding label was selected.
	#echo ${!MATCH}

	#The execution
	${!MATCH}

fi




