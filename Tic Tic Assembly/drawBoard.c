/*////////////////////////////////////////////////////////////////////////////////////////
/Author: Muhammed Muktar
/UMBC ID: mmuktar1@umbc.edu, Student ID: CV34619
/File Name: drawBoard.c
/Description: Code takes board and prints it out in proper formart using C
/
*////////////////////////////////////////////////////////////////////////////////////////


#include <stdio.h> 
#include <string.h>


void drawBoard(char board[]){  
 
  int lastIndex = 3;
  
  for (int r = 0; r < 16; r += 4){       //loops rows
    
    for (int c = r; c < (r + 4); c++){   //loops columns
      
      printf("%c", board[c]);            //prints board
      
      if (c != lastIndex)
	printf("%s", "|");               //prints row lines
      
    }
    
    lastIndex += 4;
    if (r != 12)
      printf("%s", "\n_______\n");       //prints col lines
  }

  printf("\n\n");

}
