VERSION 5.00
Object = "{0842D103-1E19-101B-9AAF-1A1626551E7C}#1.0#0"; "GRAPH32.OCX"
Begin VB.Form GraphForm 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   7575
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   10305
   ClipControls    =   0   'False
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7575
   ScaleWidth      =   10305
   Begin GraphLib.Graph Graph1 
      Height          =   7575
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10335
      _Version        =   65536
      _ExtentX        =   18230
      _ExtentY        =   13361
      _StockProps     =   96
      BorderStyle     =   1
      AutoInc         =   0
      Background      =   0
      Foreground      =   10
      GraphStyle      =   5
      GraphType       =   6
      GridStyle       =   3
      NumPoints       =   2
      PatternedLines  =   1
      RandomData      =   0
      ThickLines      =   0
      ColorData       =   4
      ColorData[0]    =   15
      ColorData[1]    =   10
      ColorData[2]    =   10
      ColorData[3]    =   10
      ExtraData       =   0
      ExtraData[]     =   0
      FontFamily      =   4
      FontSize        =   4
      FontSize[0]     =   200
      FontSize[1]     =   150
      FontSize[2]     =   100
      FontSize[3]     =   100
      FontStyle       =   4
      GraphData       =   1
      GraphData[]     =   2
      GraphData[0,0]  =   1
      GraphData[0,1]  =   0.6
      LabelText       =   0
      LegendText      =   0
      PatternData     =   0
      SymbolData      =   0
      XPosData        =   0
      XPosData[]      =   0
   End
End
Attribute VB_Name = "GraphForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private numpoints As Integer

Private Sub menu_close_Click()
GraphForm.Hide
End Sub

Public Sub GraphInit()

GraphForm.Show

numpoints = 0

GraphForm.Graph1.DrawStyle = 1 'Colour (0=monochrome)
GraphForm.Graph1.NumSets = 1 'Only 1 data set
GraphForm.Graph1.ThisSet = 1 'Data set 1
GraphForm.Graph1.numpoints = 2 'Initially 2 is the minimum
GraphForm.Graph1.ColorData = 15 'White
GraphForm.Graph1.Foreground = 10
GraphForm.Graph1.ThickLines = 0 'No

Graph1.BottomTitle = ""

End Sub

Public Function AddPointToGraph(X, Y)

    numpoints = numpoints + 1
    If numpoints > 2 Then GraphForm.Graph1.numpoints = numpoints
    GraphForm.Graph1.ThisPoint = numpoints

    GraphForm.Graph1.GraphData = Y
    GraphForm.Graph1.XPosData = X
    
    If GraphForm.Graph1.ThisPoint > 1 Then
        Graph1.Refresh
        
        GraphForm.Graph1.DrawMode = 3
    End If
    
    
End Function
