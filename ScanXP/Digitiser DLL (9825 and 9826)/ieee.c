/* ieee.c */
/* -- code to control Elite 488 IEEE board */
/* part of SCAN97.dll project */

#include "scan97.h"


int cconv initieee()
	{
	ieeedata=open("IEEEDATA",2);
	ieeectrl=open("IEEECTRL",2);
	
	if ((ieeedata<0) || (ieeectrl<0)) return 0;
	
	return 1;
	}

void cconv finishieee()
	{
	int ret;
	ret=close(ieeedata);
	ret=close(ieeectrl);
	}

int cconv sendieeectrl (char *buffer)
	{
    return(dosend(buffer,ieeectrl));
	}

int cconv sendieeedata (char *buffer)
	{
	return(dosend(buffer,ieeedata));
	}

int dosend(char *buffer, int target)
	{
	int i=0;
	data=buffer; 
	
	if(*data=='\0') return(-1);

    while(*data!='\0') { data++;i++; }
	
	   *data++='\r';i++;
	   write(target,buffer,i);
	return i;
	}

int cconv getieeectrl (char *buffer)  
	{
	clearbuffer(buffer);
	return (read(ieeectrl,buffer,255));
	}

int cconv getieeedata (char *buffer)
	{
	clearbuffer(buffer);
	return (read(ieeedata,buffer,255));
	}

 double cconv readieeevalue (int ieee_addr, char *inp_cmd, short cmdlen)
	{
	itoa(ieee_addr,buff,10);
	sendieeectrl(buff);
	clearbuffer(buff);
	getieeedata(buff);
	return atof(buff);
	}
    
 void clearbuffer(char *buffer)
	 {
	 register int i;
	 for (i=0; i<255; i++)
		buffer[i]='\0';
	 }

