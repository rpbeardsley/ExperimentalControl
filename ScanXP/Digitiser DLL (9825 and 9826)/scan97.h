/* scan97.h
  Header information for dll used in experimental control
  Incorporates control of port i/o (for digitiser) and IEEE.
*/

#define cconv _stdcall  /* C calling convention for 32 bit DLL */

/* libraries relevant to project */
#include <windows.h>
#include <io.h>
#include <conio.h>

/* general functions */
void cconv setupdll (HWND progress_HWND,unsigned short ioport);
void cconv stopdll ();

/* digitiser port i/o functions */
void go_low(unsigned short port, int bit);
void cmd(unsigned short commd, unsigned short baseport);
void cconv inword (unsigned short ioport, unsigned short *datawd);
void cconv inbyte (unsigned short ioport, unsigned char *databt);
void cconv outbyte (unsigned short ioport,unsigned short baseport, unsigned char databt, short cardmodel);
void cconv average(unsigned short baseport, long record_length, long records_to_ignore, double *array, long software_sweeps, short *satflag, double preampgain,double preampoffset, unsigned char *status, short cardmodel);
short cconv testdigitiser(DWORD timeout, unsigned short baseport);

/* ieee functions */
int cconv initieee();
void cconv finishieee();
int cconv sendieeectrl (char *buffer);
int cconv sendieeedata (char *buffer);
int dosend(char *buffer, int target);
int cconv getieeectrl (char *buffer);
int cconv getieeedata (char *buffer);
double cconv readieeevalue (int ieee_addr, char *inp_cmd, short cmdlen);
void clearbuffer(char *buffer);
void cconv createbitmapbuffer(double *array1,long elements,char *array2,short xsteps,short ysteps,short bitmapwidth);
void cconv minmax (double *array, long elements, struct xy *result);

/* global variables */
int ieeedata, ieeectrl; /* filehandles to ieee data and ctrl streams */
char buff[256];  /* elements buff[0] to buff[255] */
HWND pbHwnd; /* handle to progress bar */
char STOP_DLL;

/*unsigned short baseport;
unsigned short mbaddr;
unsigned short cmdport;
unsigned short portB; */
char *data;
int timeout;
int dllstatus;

struct xy { double x; double y; };