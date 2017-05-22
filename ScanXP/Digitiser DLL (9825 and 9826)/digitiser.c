/* digitiser.c
*
* Routines for visual basic to control simple input/output to ports,    
* plus more specialised routines to provide block-data acquisition and  
* averaging from EG&G 9826/9846/9825 digital signal processing board.                  
*                                                                       
* (c) Andy Cross, 12th March 1997
* for Phonon Imaging group, Physics Dept, University of Nottingham.     
*
* Revision v5.2: Upgraded to 32 bit / Win95 specification.
* Routines now form part of SCAN97.DLL (previously known as vb-io.dll)
*
* Other v5.0 features:
* ** averaging code modified for new 9826 board.
* ** auto-detection of whether data is clipped
*    (saturated) on the selected preamplifier gain setting.
* ** variable number of points to ignore at beginning of trace. No
*    longer need to define a data array in Visual Basic with a 
*    large number of negative (wasted) indexes.
*
* Previous revisions:
*
* v4.1, 7th November 1996: includes "fail-safe" code to detect crashes,
* and enables the user STOP button to abort trace-averaging.
* Incorporates revised all-in-C averaging code.
* Uses GetTickCount API call to get a delay -- and it works, too!
*
* v3.01, 13th June 1996. First all in C averager with some success.
* Used a for-next loop to provide delay, not good! Found to be
* quite unreliable.
*
* v2.0 11th May 1996.
*
* Intentions: to fix a bug that gives us only the high byte
* of a 16-bit output.
* Fix: turned out to be a hardware problem (clashing port addresses)
* Some minor modifications made anyway (to hopefully correlate Visual
* Basic and C variable types)
*
* v1.7: 20th December 1995 
* Basic in/outport working ok. Inblock function seems ok in limited
* testing. Attempt at an all-in-C averager, but doesn't work.
*/

#include <stdlib.h>
#include <malloc.h>
#include "scan97.h"

#define STOP_AVERAGE 0x34
#define GET_AVERAGE 0x3C
#define SETUP_READ 0x37
#define PORTS_CHANGED 0x00

/* Wait for certain bit of port to go low */
void go_low(unsigned short port, int bit)
{
	DWORD count=GetTickCount();
	while (_inp(port) & bit)
	{
		if ((GetTickCount()-count)>4000)
		{
			STOP_DLL=1;
			timeout=1;
			break;
		}
	}
}

/* Wait for certain bit of port to go high */
void go_high(unsigned short port, int bit)
{
	DWORD count=GetTickCount();
	while (!(_inp(port) & bit))
	{
		if ((GetTickCount()-count)>4000)
		{
			STOP_DLL=1;
			timeout=1;
			break;
		}
	}
}


/* Issue command to digitiser */
void cmd(unsigned short commd, unsigned short baseport)
{
int bit=32;

unsigned short mbaddr;
unsigned short cmdport;

mbaddr=baseport+3;
cmdport=baseport+14;

timeout=0;
go_low(mbaddr,bit);
if (timeout == 1)
	dllstatus=1;

Sleep(10);
_outp(cmdport,commd);
_outp(mbaddr,(_inp(mbaddr) | bit));

Sleep(10);

}

void cconv inword (unsigned short ioport, unsigned short *datawd)
 {     
  *datawd = _inpw(ioport);
 }

 void cconv inbyte (unsigned short ioport, unsigned char *databt)
 {
 *databt = (unsigned char) _inp(ioport);
 }

 void cconv outbyte (unsigned short ioport,unsigned short baseport, unsigned char databt, short cardmodel)
 {
 //Added 14 March 2006 by Paul Walker
 //cardmodel: 0 for 9826, 1 for 9825
 int bit=32;
 unsigned short mbaddr;
 mbaddr=baseport+3;
 go_low(mbaddr,bit);
 if (timeout == 1)
	dllstatus=1;
 Sleep(10);
 //End of added 14 March 2006

 _outp(ioport,(int)databt);

 //Added 14 March 2006 by Paul Walker
 if (cardmodel == 1)
 {
	cmd(PORTS_CHANGED,baseport);
 }
 //End of added 14 March 2006

 }

short cconv testdigitiser(DWORD timeout,unsigned short baseport)
	{
DWORD count;
unsigned short portB;

portB=baseport+11;

cmd(GET_AVERAGE,baseport);

count=GetTickCount();

while ((_inp(portB) & 1) !=0)
	if ((GetTickCount()-count)>timeout) return(0);

return(1);
	}

void cconv average(unsigned short baseport, long record_length, long records_to_ignore, double *array, long software_sweeps, short *satflag, double preampgain,double preampoffset,unsigned char *status, short cardmodel)
{
	//cardmodel: 0 for 9826, 1 for 9825
register long j,i;
unsigned short dat;
unsigned long *bigarray;
long remainder=record_length-records_to_ignore;
double offset;
int bit0=1;
int bit2=4;
unsigned char st1;
unsigned char errorcode;

unsigned short portB;

portB=baseport+11;

*status=0;

bigarray = (unsigned long *) malloc(record_length * sizeof(unsigned long));
for (i = 0; i < record_length; i++)
{
	bigarray[i]=0;
}

*satflag=0; /* returns 1 to indicate data saturation (ie need lower gain range) */
errorcode=0;

/* begin software averaging sweep */
for (j=0; ((j< software_sweeps) & (STOP_DLL==0)); j++)
{

	inbyte(portB,&st1); /*Debugging - check port B, bit zero should be high at this point*/

	if((_inp(portB) & bit0) == 0) /* if port B bit 0 is low then data is ready even though we */
	{							/* haven't told it to start acquiring yet. */
		errorcode=errorcode+1;
	}

	cmd(GET_AVERAGE,baseport);	/*Send data collection start command */
	if (dllstatus == 1)
	{
		errorcode=errorcode+2;
	}
		

	timeout=0;
	go_high(portB,bit2); /* port B bit 2: high indicates the first valid trigger has been read and STOP has not yet been given */
	if (timeout == 1)
	{
		errorcode=errorcode+4;
	}

	if (cardmodel == 1)
	{
		//We are using the 9825 digitiser so we need to send the SETUPREAD command
		cmd(SETUP_READ,baseport);	/*Send data collection start command */
		if (dllstatus == 1)
		{
			errorcode=errorcode+2;
		}
		Sleep(10);
	}

	timeout=0;
	go_low(portB,bit0); /* port B bit 0: low indicates data ready to read */
	if (timeout == 1)
	{
		errorcode=errorcode+8;
	}


	Sleep(10);

	/* now get 16-bit trace data, ADDING to the array. */

	   for (i=0; i < records_to_ignore; i++) 
	   {
			 dat=_inpw(baseport);
	   } 

	   for (i=0; i < remainder; i++) 
	   {
			 dat=_inpw(baseport);
			 *satflag|=((dat>65300) || (dat<235)); /* have we got data saturation? */
			 bigarray[i]=bigarray[i]+dat;
	   } 
  
   
	 } /* end j loop */


cmd(STOP_AVERAGE,baseport); 
STOP_DLL=0;

offset=-preampgain*preampoffset;

for (i=0; i< remainder; i++)
{
	
	array[i]=offset+(preampgain*(((double)bigarray[i]/software_sweeps)/65535.0));
}


free( bigarray );

} /* end function */
