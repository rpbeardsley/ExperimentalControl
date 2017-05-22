/* general.c 
   
	 Routines for scan97.dll that don't seem to fit
	 anywhere else 
 */

#include "scan97.h"


////////////////////////////////////////////////////////////////////////////////////
//   FILE: RADHWLib.CPP
//   AUTH: Digvijay Singh Chauhan
//   DATE: 27/02/2003
//   DESC: C source file for RADHWLib DLL - compiled with Microsoft Visual C++ 6.0
// FEEDBACK:
//
//			Any comments and suggestions can be sent to digvijay_chauhan@hotmail.com
//
////////////////////////////////////////////////////////////////////////////////////
#include <stdio.h>
#include <windows.h>

//Console inp and out functions
#include <conio.h>  

//Our own header
#include "RADHWLib.h"



BOOL WINAPI DllMain(
    HINSTANCE hinstDLL,  // handle to DLL module
    DWORD fdwReason,     // reason for calling function
    LPVOID lpReserved )  // reserved
{
	// Perform actions based on the reason for calling.
    switch( fdwReason ) 
    { 
        case DLL_PROCESS_ATTACH:
		{
			 // Initialize once for each new process.
			 // Return FALSE to fail DLL load.

			//Here we'll check if the OS hosting 
			//the DLL is of WINDOWS NT family
			OSVERSIONINFO osvi;
			osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
			GetVersionEx(&osvi);

			IsWinNT = osvi.dwMajorVersion == 3 || osvi.dwMajorVersion == 4 || osvi.dwMajorVersion == 5;

			//If Yes
			//We'll just initialise the Device Driver for 
			//Direct port Access
			if(IsWinNT)
			{
				//Load the DirectIO Driver
				//And attach it to this process

				//try opening SCM ; if failed Bail out
				if(!InitSCM()) return FALSE;

				//Install the Driver
				char szDrvPath[MAX_PATH];
				
				GetSystemDirectory(szDrvPath,MAX_PATH);
				lstrcat(szDrvPath,"\\Drivers\\GiveIO.sys");
				
				DWORD dwRet = DriverInstall(szDrvPath,"giveio");	
				if(dwRet != 0 && dwRet != 0x00000431)	//Success or already installed
				{
					MessageBox(0,"Could not initialize GiveIO.sys Driver","RADHWLib Error",MB_ICONHAND);
					return FALSE;
				}

				if(AttachDrv())
				{
					//Get I/O perms on WinNt/XP/2000
					InterlockedIncrement(&nNumberOfApps);	//Increment App Count
					IsDriverLoaded = TRUE ;
					return TRUE ;  // Successful DLL_PROCESS_ATTACH
				}
				else
				{
					DriverRemove("giveio");
					return FALSE;
				}
			}
			
			//Else Just return TRUE

			//Disable Thread Calls
			DisableThreadLibraryCalls(hinstDLL);
			InterlockedIncrement(&nNumberOfApps);//Increment App Count
		}
        break;


        case DLL_PROCESS_DETACH:
		{
         // Perform any necessary cleanup.
		 
			//if it is WinNT unload the giveIO driver
			if(IsWinNT)
			{
				//UnLoad the DirectIO Driver
				if(nNumberOfApps == 0)
				{
					DriverRemove("giveio");
					IsDriverLoaded = FALSE ;
					ShutDownSCM(hSCMan);	//No Error Check :-P
				}
			}
			
			InterlockedDecrement(&nNumberOfApps);//Decrement App count
		}
        break;
    }
		
	return TRUE;  // Successful DLL_PROCESS_ATTACH
}



///////////////////////////////////////////////////////////////
//   FUNC: OutPort
//   DESC: uses RTL _outp() function
//         to output a PortData to PortAddress
///////////////////////////////////////////////////////////////

short cconv OutPort( int PortAddress, int PortData )
{
  short Dummy; 

  Dummy = (short)(_outp( PortAddress, PortData ));
  return(Dummy);

}


///////////////////////////////////////////////////////////////
//   FUNC: InPort
//   DESC: uses RTL _inp() function
//         to read PortAddress
///////////////////////////////////////////////////////////////

short cconv InPort( int PortAddress ) 
{
  short PortData; 
 
  PortData = (short)(_inp( PortAddress ));
  return( PortData );

}

///////////////////////////////////////////////////////////////
//   FUNC: DoDriverAction
//   DESC: Performs GiveIo.sys related activities like Installing
//         Removing,Stopping and Starting the driver
//   RETVAL: 0 on failure ; rest are documented in Header file
///////////////////////////////////////////////////////////////

int cconv DoDriverAction( int nACTION ) 
{
	switch(nACTION)
	{
	
	case DDA_LOAD:
		//Load the Driver
		if(IsDriverLoaded)
			return DRIVER_ALREADY_INSTALLED;
		else
		{
			char szDrvPath[MAX_PATH];
			GetSystemDirectory(szDrvPath,MAX_PATH);
			lstrcat(szDrvPath,"\\Drivers\\GiveIO.sys");
			if( 0 == DriverInstall(szDrvPath,"giveio"))
			{
				IsDriverLoaded = TRUE;
				return DRIVER_INSTALL_SUCCESS;
			}
			else
				return DRIVER_INSTALL_FAILURE;
		}
		break;	//Unreachable code
		
	case DDA_UNLOAD:
		//Unload the Driver
		if(!IsDriverLoaded)
			return DRIVER_ALREADY_UNINSTALLED;
		else
		{
			if( nNumberOfApps != 0)
			{
				return DRIVER_IN_USE;
			}
			if( 0 == DriverRemove("giveio"))
			{
				IsDriverLoaded = FALSE;
				return DRIVER_UNINSTALL_SUCCESS;
			}
			else
				return DRIVER_UNINSTALL_FAILURE;
		}
	}

	return 0;
}

///////////////////////////////////////////////////////////////
//   FUNC: GetDriverStatus
//   DESC: Returns a Bool; 0 -> GiveIO Driver NOT loaded
//						   1 -> GiveIO Driver LOADED
///////////////////////////////////////////////////////////////

int cconv GetDriverStatus() 
{
	return IsDriverLoaded;
}

///////////////////////////////////////////////////////////////
//   FUNC: GetDLLStatus
//   DESC: Returns the total number of applications that the 
//		   DLL is being used by
///////////////////////////////////////////////////////////////

int cconv GetDLLStatus() 
{
	return nNumberOfApps;
}


BOOL AttachDrv()
{
	HANDLE h;

    h = CreateFile("\\\\.\\giveio", GENERIC_READ, 0, NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, NULL);
    if(h == INVALID_HANDLE_VALUE) 
	{
        MessageBox(0,"Couldn't access giveio device","Error",MB_ICONHAND);
        return FALSE;
    }
	CloseHandle(h);
	return TRUE;
}

void cconv setupdll (HWND progress_HWND,unsigned short ioport)
	{
	//pbHwnd=progress_HWND; /* progress bar handle */
	//baseport=ioport; /* digitiser base I/O port */
	//baseport=848;
	//mbaddr=baseport+3;
	//portB=baseport+11;
	//cmdport=baseport+14;
	timeout=0;
	STOP_DLL=0;
	}

void cconv stopdll ()
	{
	STOP_DLL=1;
	}

void cconv minmax (double *array, long elements, struct xy *result)
{
long i;
double min=array[0];
double max=min;

for (i=1;i<elements;i++)
{
if (array[i]>max) max=array[i];
if (array[i]<min) min=array[i];
}

result->x=max;
result->y=min;
}

void cconv createbitmapbuffer(double *array1,long elements,char *array2,short xsteps,short ysteps,short bitmapwidth)
{
long x,y;
double max, datarange;
double temp;
long offset1, offset2;
struct xy mm;

minmax(array1,elements,&mm);

max=mm.x - mm.y;
datarange=max/255;

for (y=0;y<ysteps;y++)
{
	for (x=0;x<xsteps;x++)
	{
	offset1=x+(y*ysteps);
	offset2=x+(y*bitmapwidth);
	
	temp=(array1[offset1]-mm.y)/datarange;
				
	if (array1[offset1]==0) temp=0; /* let blank data appear as zero */
	
	array2[offset2]=(char)temp;
    }
}
}

