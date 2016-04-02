<%
   Response.Expires = -1000
   Response.Expiresabsolute = Now() - 1
   Response.AddHeader "pragma","no-cache"
   Response.AddHeader "cache-control","private"
   Response.CacheControl = "no-cache"
%>
<!-- #include file = "adovbs.inc" -->
<%
response.buffer=True
Dim localDebug 
localDebug = False
' -------------------------------------------------------------------------------------
'  GLOBALS
' --------------------------------------------------------------------------------------

Private Const SUPPORT_MAIL = "<a href='mailto:scott@fysh.org'>Scott James</a>"

' Wrap init up to protect globals that dont need exposing
Call Initialise          ' Build up internal structures

'--------------------------------------------------------------------------------------
' Initialise:
' The procedure runs when the Session is started or the file is changed
' Primary ojbectives are to set variables/constants used throughout the
' Session.
'--------------------------------------------------------------------------------------

sub Initialise

  ' Global variables bound up in the Session collection to act as a namesapce

	' Set to true to view full MS errors and other debug information
	' printed.  (This will disable most On Error Resume Next statements.)
  Session("Debug") = False
  
	DebugMessage("Initialise started")
	
	'============ SQL SETTINGS ==============
  Session("accounts") = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=e:\rnest\accounts.mdb"
  Session("cplay") = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=e:\Nursery\LiveDatabase\Database.mdb"

	DebugMessage("Initialise Completed")

End Sub

'---------------------------------------------------------------------------
' PrintHeader
'  Prints a header for html pages
'---------------------------------------------------------------------------
Sub PrintHeader
  If Not Session("SupressHeader") = True Then
  End if
  Session("SupressHeader") = False
End Sub

'--------------------------------------------------------------------------------------
' DebugMessage:
'	Pring a debug message if the app debug var is set.
'--------------------------------------------------------------------------------------
Sub DebugMessage(message)
	If Session("Debug") Or localDebug Then
		Response.Write("<i> " & message  & "</i><br>")
	End If
End Sub

'--------------------------------------------------------------------------------------
' CreateCon:
' Returns a ADO Connection object
'--------------------------------------------------------------------------------------

Function CreateCon(strConnectionName)

  if (Session("con-" & strConnectionName) = "") Then
    Dim strConn,adoCon

    strConn = Session(strConnectionName)

    DebugMessage("Creating connect with strConn = " & strConn)

    ' Keep Errors from occuring
    If Session("Debug") Then
      On Error Resume Next
    End If

    ' Create and open the database connection and save it as a
    ' session variable
    Set adoCon = Server.CreateObject("ADODB.Connection")

    With adoCon
      .ConnectionString = strConn
      .CursorLocation = adUseClient ' use client side cursors
      .Open
    End With

    Set Session("con-" & strConnectionName) = adoCon

    Set adoCon = Nothing
    If Err.Number <> 0 Then
      Call TrapError(Err.Number, Err.Description, Err.Source)
    End If
  Else
    DebugMessage("Connection already exists, re-using for strConnectionName: " & strConnectionName)
    DebugMessage("Connection: " & Session("con-" & strConnectionName))
  End if
End Function


'--------------------------------------------------------------------------------------
' SQLQuery:
' Takes an input string which is the SQL query statment and
' returns the results of the query as a recordset if any
' results are returned.
'--------------------------------------------------------------------------------------

Function SQLQuery(strConnectionName,queryStr)
  ' Create the connection, will only create a connection if one does not already exist
  Call CreateCon(strConnectionName)

  ' Keep Errors from occuring
  If Session("Debug") Then
    On Error Resume Next
  End If
  Dim adoRec
  DebugMessage("<p><b>SQL Query: </b>" & queryStr & "<p>")

	Set adoRec = Server.CreateObject("ADODB.Recordset")
  With adoRec
	  .ActiveConnection = Session("con-" & strConnectionName)
    .CursorLocation = adUseClient ' Use client side cursors
	  .Open(queryStr)
  End With

  ' Handle errors
	If Err.Number <> 0 Then
		Call TrapError(Err.Number, Err.Description, Err.Source)
	End If

	Set SQLQuery = adoRec
  Set adoRec = Nothing

End Function


Function SQLUpdate(strConnectionName,updateStr)
  ' Create the connection, will only create a connection if one does not already exist
  Call CreateCon(strConnectionName)

  ' Keep Errors from occuring
 
  DebugMessage("<p><b>SQL Update: </b>" & updateStr & "<p>")
  ' Create a command object
  set objSQLCmd = Server.CreateObject("ADODB.Command")

  ' Bind the connection
  objSQLCmd.ActiveConnection = Session("con-" & strConnectionName)

  ' Set the command type to be a SQL command
  objSQLCmd.CommandType = adCmdText

  ' Bind the command text
  objSQLCmd.CommandText = updateStr

  Dim lngAffectedRecords 
  lngAffectedRecords = 0

  objSQLCmd.Execute lngAffectedRecords,, adCmdText
 
  SQLUpdate = lngAffectedRecords
  set objSQLCmd = Nothing
    
end function
'--------------------------------------------------------------------------------------
' RenderSQL
'
'--------------------------------------------------------------------------------------

'--------------------------------------------------------------------------------------
' DisplayError:
' Procedure for creating error pages.
'--------------------------------------------------------------------------------------
Sub DisplayError(eType, component)

	' Create the web page
	Response.Write("<P><CENTER><TABLE WIDTH=""200""><TR><TD bgcolor=""red"" ALIGN=""CENTER"">")
	Response.Write("<B>ERROR</B></TR></TD><TR><TD bgcolor=""#EEEEEE"" ALIGN=""CENTER"">")
	
	'	Error Types:
	'	1: Missing required field
	'	2: SQL error
	'	3: Generic Error, just display full component string

	Select Case eType
	Case 1
		Response.Write("<B>" & component & "</B> ")
		Response.Write(" is a required field.<P>")
		Response.Write("<I>Please press the BACK button</I>")
	Case 2
		Response.Write("A SQL query has failed. ")
	Case 3
		Response.Write(component)
			
	End Select


	' Finish off the table and page
	Response.Write("</TR></TD></TABLE></CENTER><P></BODY></HTML>")

	' Stop processing the .asp file
	Response.End()
End Sub
'--------------------------------------------------------------------------------------
' TrapError:
' Gracefully trap errors and print message
'--------------------------------------------------------------------------------------
Sub TrapError (intNum, strDescription, strSource)

	Dim strInformation, strHexNum

	' Format the error number in Hex, 8 characters long
	strHexNum = Right(String(8, "0") & Hex(intNum), 8)

	Response.Write("<p><center><table width=""300"">")
	Response.Write("<tr><td bgcolor=""red"" align=""center"">")
	Response.Write("<B>Application Error</b></td></tr>")
	Response.Write("<tr><td bgcolor=""#EEEEEE"" align=""left"">")

	Response.Write("<b>Number: </b>" & intNum & " (0x" & strHexNum & ")<br>")
	Response.Write("<b>Source: </b>" & strSource & "<br>")
	Response.Write("<b>Description: </b>" & strDescription & "<hr>")

	' Print extra information
	Select Case Err.Number
		Case 3709	' no db connection
			strInformation = "The database connection could not be opened.  Please check your" & _
				" configuration and make sure the database is accessible."
		Case -2147217865 ' sql: bad table reference
			strInformation = "There is an error in the SQL query string probably referencing a" & _
				" table.  Read the description above and check the code."
		Case -2147217900 ' sql: bad syntax
			strInformation = "The SQL query string is using bad syntax.  Read the description above" & _
				" and check the code."
		Case -2147217904 ' sql: invalid column
			strInformation = "The SQL query references a invalid column or object.  Read the description above" & _
				" and check the code."
		Case Else
			strInformation = "No more information is available."
	End Select

	strInformation = strInformation & vbNewLine & _
		"<p>Contact your administrator"
	Response.Write(strInformation)

	Response.End
End Sub


'-----------------------------------------------------------------------------------------
' GenerateXML
'  Convert a resultset into welformed XML of the form:
'   
'-----------------------------------------------------------------------------------------

Public Function GenerateXML( objRS ) 
  Dim objDom
   Dim objRoot
   Dim objRootXML
   Dim objField
   Dim objFieldValue
   Dim objcolName
   Dim objattTabOrder
   Dim objPI
   Dim x
   Dim objRSField
   Dim objRow

   'Instantiate the Microsoft XMLDOM.
   Set objDom = server.CreateObject("Microsoft.XMLDOM")
   objDom.preserveWhiteSpace = True

   'Create your root element and append it to the XML document.
   Set objRootXML = objDom.createElement("xml")
   objDom.appendChild objRootXML

   ' Loop over and create all other nodes
     if (objRS.state = adStateOpen) Then
       Set objRoot = objDom.createElement("RecordSet")
       objRootXML.appendChild objRoot
       DebugMessage("Starting on a result set")

       Do While Not objRS.EOF
         DebugMessage("Starting on a row")
         Set objRow = objDom.CreateElement("row")
         
         For Each objRSField in objRS.Fields
           Dim strValue
           Dim strName
           if (IsNull(objRSField.value)) Then
            strValue = "{NULL}"
           else
            strValue = objRSField.value
           end if
           strName = objRSField.Name

           Set objcolName = objDom.createAttribute(strName)
           objcolName.Text = strValue
           
           objRow.SetAttributeNode(objcolName)

           DebugMessage("Completed row : " & objRSField.Name  & "/" & objRSField.value)
         Next 
      
         objRoot.appendChild objRow

         objRS.MoveNext
       Loop
     end if

   Set objPI = objDom.createProcessingInstruction("xml", "version='1.0'")
   objDom.insertBefore objPI, objDom.childNodes(0)

   GenerateXML= objDom.xml

   'Clean up...
   Set objDom = Nothing
   Set objRoot = Nothing
   Set objField = Nothing
   Set objFieldValue = Nothing
   Set objcolName = Nothing
   Set objattTabOrder = Nothing
   Set objPI = Nothing

End Function                            

function logMessage(strMessage)

  Dim strSQL 
  strSQL = "INSERT INTO rnLog (log,type) VALUES ('" & strMessage & "','AUDIT')"

  Call SQLQuery("accounts",strSQL)

end function

function logDebugMessage(strMessage)

  Dim strSQL 
  strSQL = "INSERT INTO rnLog (log,type) VALUES ('" & strMessage & "','DEBUG')"

  Call SQLQuery("accounts",strSQL)

end function

function getConf(strConfName)
  
  Dim strSQL 
  Dim rsResults

  strSQL = "SELECT value from rnConfig where name='" &strConfName & "'"

  Set rsResults = SQLQuery("accounts",strSQL)

  getConf = rsResults("value")
  rsResults.close
end function

function setConf(strConfName,strConfValue)
  
  Dim strSQL 
  Dim rsResults

  strSQL = "UPDATE rnLog SET value='" & strConfValue & _
           "WHERE name = '" & strConfName & "'"
end function

function openPage(strURL)

  set  xmlHttp = createobject("Microsoft.XMLHTTP")

  Call xmlHttp.open("GET", strURL, false)

  Call xmlHttp.send
  openPage =xmlHttp.responseText

end function

function selectDefault(strSel,strItem)
  if strSel = strItem Then
    Response.Write("selected" )
  end if
end function

%>
