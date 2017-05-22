#ifndef __RADHWLib_H
#define __RADHWLib_H


// globals
SC_HANDLE hSCMan = NULL;
BOOL IsWinNT = FALSE;
BOOL IsDriverLoaded = FALSE;

#pragma data_seg(".SHARED")
long nNumberOfApps = 0;			//Toatal number of applications using our DLL
#pragma data_seg()
#pragma comment(linker, "/section:.SHARED,rws")

// enums
enum { DDA_LOAD = 0,DDA_UNLOAD};
/*

DoDriverAction(DDA_LOAD)	Loads the Driver 
DoDriverAction(DDA_UNLOAD)	UnLoads the Driver 

*/
//		Return Value						//		Meaning
enum {  DRIVER_ALREADY_INSTALLED=100,		//100 Driver is already Installed
		DRIVER_INSTALL_SUCCESS,				//101
		DRIVER_INSTALL_FAILURE,				//102
		DRIVER_ALREADY_UNINSTALLED,			//103
		DRIVER_UNINSTALL_SUCCESS,			//104
		DRIVER_UNINSTALL_FAILURE,			//105
		DRIVER_NOT_INSTALLED,				//106
		DRIVER_ALREADY_STARTED,				//107
		DRIVER_IN_USE
	};

//Private Protos
BOOL  AttachDrv();
DWORD DriverInstall(LPSTR, LPSTR);
DWORD DriverRemove(LPSTR);

BOOL  InitSCM();
BOOL  ShutDownSCM(SC_HANDLE hSCMan);


BOOL InitSCM()
{
	if ((hSCMan = OpenSCManager(NULL, NULL,SC_MANAGER_ALL_ACCESS)) == NULL) 
	{
		MessageBox(0, "Can't connect to Service Control Manager","RADHWLib DLL", MB_ICONHAND);
		return FALSE;
	}
		return TRUE;
}

BOOL ShutDownSCM(SC_HANDLE hSCMan)
{
	return CloseServiceHandle(hSCMan);
}


DWORD DriverInstall(LPSTR lpPath, LPSTR lpDriver)
{
   BOOL dwStatus = 0;
   SC_HANDLE hService = NULL;

   // add to service control manager's database
   if ((hService = CreateService(hSCMan,
								 lpDriver,
								 lpDriver, 
								 SERVICE_ALL_ACCESS, 
								 SERVICE_KERNEL_DRIVER,
								 SERVICE_DEMAND_START, 
								 SERVICE_ERROR_NORMAL, 
								 lpPath, NULL, NULL, NULL, NULL, NULL)) == NULL) 
			dwStatus = GetLastError();
   else 
			CloseServiceHandle(hService);

   return dwStatus;
}


DWORD DriverRemove(LPSTR lpDriver)
{
   BOOL dwStatus = 0;
   SC_HANDLE hService = NULL;

   // get a handle to the service
   if ((hService = OpenService(hSCMan, lpDriver, SERVICE_ALL_ACCESS)) != NULL) 
   {
      // remove the driver
      if (!DeleteService(hService)) dwStatus = GetLastError();
   }
   else dwStatus = GetLastError();

   if (hService != NULL) CloseServiceHandle(hService);

   return dwStatus;
}

#endif
