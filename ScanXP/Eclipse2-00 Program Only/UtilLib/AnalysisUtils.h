//
// AnalysisUtils.h
//
//////////////////////////////////////////////////////////////////////////////////////////////
// 
//	This file is used to DECLARE all the analysis utility classes which are shared with 
//  other projects. All those classes are declared and defined in a single file, but in 
//	PowerSuite software, a file contains typically lots of classes. while no file directory structures are
//	in place. So to make it easier to nagivagate through the files, we want to reduce the number of files 
//	shown in the project workspace by adding this single file to the workspace.
//
//	In the future, if more analysis classes used in other proejct(s) need to be share with PowerSuite project, 
//  add them here, instead of to the PowerSuite workspace.
//
//  Use this header file whenever analysis utility classes are needed, instead of include declaration for that
//  single class.
//
//
///////////////////////////////////////////////////////////////////////////////////////////////


#ifndef _ANALYSIS_INC_
#define _ANALYSIS_INC_
//

#include "vector.h"
#include "matrix.h"
#include "SchFitException.h"
#include "NumericExceptionEnable.h"
#include "MarqResults.h"
#include "Marqbase.h"
#include "sgfilter.h"
#include "spline.h"
#include "mathfit.h"
#include "metric.h"
#include "values.h"
#include "NRCUtil.h"
#include "mass.h"
#include "volume.h"
#include "SpecTime.h"
#include "AnalysisExceptionBase.h"
#include "EChemUnits.h"
#include "Length.h"


#endif


