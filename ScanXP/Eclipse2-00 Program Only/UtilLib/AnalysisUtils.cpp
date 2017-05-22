//
// AnalysisUtils.cpp
//
//////////////////////////////////////////////////////////////////////////////////////////////
// 
//	This file is used to DEFINE all the analysis utility classes which are shared with 
//  other projects. All those classes are declared and defined in a single file, but in 
//	PowerSuite software, a file contains typically lots of classes. while no file directory structures are
//	in place (well, Frank doesn't like to have too many level of folders under a VS projects).
//  So to make it easier to nagivagate through the files, we want to reduce the number of files 
//	shown in the project workspace by adding this single file to the workspace.
//
//
///	In the future, if more analysis classes used in other proejct(s) need to be share with PowerSuite project, 
//  add them here, instead of to the PowerSuite workspace.
//
//	We don't need to include the header files since each cpp file knows which one to include. However, those
//  header files are expected to be in the same directory of this file and NOT in the workspace.
//
//
///////////////////////////////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SchFitException.cpp"
#include "NumericExceptionEnable.cpp"
#include "MarqResults.cpp"
#include "Marqbase.cpp"
#include "sgfilter.cpp"
#include "spline.cpp"
#include "mathfit.cpp"
#include "metric.cpp"
#include "values.cpp"
#include "mass.cpp"
#include "volume.cpp"
#include "SpecTime.cpp"
#include "AnalysisExceptionBase.cpp"
#include "EChemUnits.cpp"
#include "Length.cpp"


