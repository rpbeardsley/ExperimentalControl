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

#include "scan97.h"

#define STOP_AVERAGE 0x34
#define GET_AVERAGE 0x3C

/* Wait for certain bit of port to go low */
void go_low(unsigned short port, int bit)
{
DWORD count=GetTickCount();
while ((_inp(port) & bit) !=0)
	if ((GetTickCount()-count)>4000) STOP_DLL=1;
}

/* Issue command to digitiser */
void cmd(unsigned short address)
{
int bit=32;

go_low(mbaddr,bit);
Sleep(10);
_outp(cmdport,address);
_outp(mbaddr,(_inp(baseport+3) | 32));

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

 void cconv outbyte (unsigned short ioport, unsigned char databt)
 {
 _outp(ioport,(int)databt);
 }


short cconv testdigitiser(DWORD timeout)
	{
DWORD count;
cmd(GET_AVERAGE);

count=GetTickCount();

while ((_inp(portB) & 1) !=0)
	if ((GetTickCount()-count)>timeout) return(0);

return(1);
	}

void cconv average(long record_length, long records_to_ignore, double *array, long software_sweeps, short *satflag, double preampgain,double preampoffset)
{
register long j,i;
unsigned short dat;
static long *bigarray = new long[record_length]; /* should preinitialise to zero */
long remainder=record_length-records_to_ignore;
double offset;
int bit=1;


*satflag=0; /* returns 1 to indicate data saturation (ie need lower gain range) */

for (j=0; j<16384;j++)
	bigarray[j]=0;

/* begin software averaging sweep */
for (j=0; ((j< software_sweeps) & (STOP_DLL==0)); j++)
{
cmd(GET_AVERAGE);

go_low(portB,bit); /* port B bit 1: low indicates data ready to read */

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
         bigarray[i]+=dat;
   } 
  
   
 } /* end j loop */


cmd(STOP_AVERAGE); 
STOP_DLL=0;

offset=-preampgain*preampoffset;

for (i=0; i< remainder; i++)
	{
	array[i]=offset+(preampgain*(((double)bigarray[i]/software_sweeps)/65535.0));
	}

} /* end function */
