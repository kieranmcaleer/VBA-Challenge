VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisWorkbook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
'Create function

Sub tickerGroup()
    
'Set all the variables
    Dim tickerSymbol As String
    Dim totalVolume As Double
    Dim RowCounter As Integer
    Dim NumRows As Long
    Dim closePrice As Double
    Dim openPrice As Double
    Dim percentRows As Long
    
'Set their values. Row counter is set to 2 so that it starts on the second row
    
    RowCounter = 2
    ticker = ""
    closePrice = 0
    openPrice = 0
    
'Get the number of rows so that we can use that in our for loop
    
    NumRows = Range("A2", Range("A2").End(xlDown)).Rows.Count
'Set the first date
    openPriceOne = Cells(2, 3).Value
    Cells(2, 11).Value = openPriceOne

' Start the for loop so that we can go through each cell in the A column

For x = 2 To NumRows

'Check if their is a new ticker by comparing if the value between one and the next are not equal
    
    If Cells(x, 1).Value <> Cells(x + 1, 1).Value Then
    
'Set the value of the ticker equal to the current cell if they are not

        ticker = Cells(x, 1).Value
        
'Set the value of the ticker equal to what we have found in the A column

        Cells(RowCounter, 8).Value = ticker
        
'Add the current cell to the total volume

        totalVolume = totalVolume + Cells(x, 7).Value
        
'Set the "Total Stock Volume" Column equal to what we already have for it based on the else statement
        
        Cells(RowCounter, 9).Value = totalVolume
        
'Add one to the row counter so that we can move on to the next group of tickers

        RowCounter = RowCounter + 1
'Restart the total volume
        totalVolume = 0
        
        closePrice = Cells(x, 6).Value
        
        Cells(RowCounter - 1, 10).Value = closePrice

'In the else statement, because we have a cell that is similar to the next one we are just going
'to simply add the volume to the total volume that we already have
    Else
    totalVolume = totalVolume + Cells(x, 7).Value
    openPrice = Cells(x + 2, 3).Value
    Cells(RowCounter + 1, 11).Value = openPrice
    
        
    End If
         
Next x
 percentRows = Range("J2", Range("J2").End(xlDown)).Rows.Count
For x = 2 To percentRows
    Cells(x, 12).Value = Cells(x, 10).Value - Cells(x, 11).Value
    percentChange = ((Cells(x, 12).Value) / (Cells(x, 3).Value) * 100)
    Cells(x, 10).Value = Round(percentChange, 2)
    Cells(x, 11).Value = ""
    
    If Cells(x, 12).Value > 0 Then
        Cells(x, 12).Interior.Color = RGB(0, 255, 0)
    ElseIf Cells(x, 12).Value < 0 Then
        Cells(x, 12).Interior.Color = RGB(255, 0, 0)
   
    End If
Next x
   
   
End Sub


