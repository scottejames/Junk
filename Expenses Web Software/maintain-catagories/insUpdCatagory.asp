<%
	Response.ContentType = "text/html"
  Call PageHeader
%>
<!--  #include file = "../common.asp" -->

<%
  Session("Debug") = "False"
  Dim strSQL
  Dim rsGetSummary
  Dim xml
  
  Dim strId
  Dim strName
  Dim strDescription
  Dim strRequest

  strRequest = Request("reqREQUEST") 
  strId = Request("reqID")
  strName = Request("reqNAME")
  strDescription = Request("reqDESCRIPTION")
  
  DebugMessage("REQUEST: " & strRequest)
  DebugMessage("ID: " & strID)
  DebugMessage("Name: " & strName)
  DebugMessage("Description: " & strDescription)

  ' Possible trade status
  if (strRequest = "UPDATE") Then
    strSQL=  "UPDATE catagory SET name = " + strName + ",description = " + strDescription + " WHERE id = " & strID
  end if

  if (strRequest = "INSERT") Then
    strSQL=  "INSERT INTO catagory (name,description) values (" & strName & "," & strDescription & ")"
  end if
  
  if (strRequest = "DELETE") Then
    strSQL=  "DELETE FROM catagory WHERE id = " & strID
  end if

  DebugMessage("SQL: " & strSQL)

  intRecords = SQLUpdate(strSQL)
  
  Response.Write("Updated " & intRecords & " records")

  Session("Debug") = "False"
  Call PageFooter
%>
