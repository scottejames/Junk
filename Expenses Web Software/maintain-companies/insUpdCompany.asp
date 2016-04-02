
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
  Dim strAddress
  Dim strRequest

  strRequest = Request("reqREQUEST") 
  strId      = Request("reqID")
  strName    = Request("reqNAME")
  strAddress = Request("reqADDRESS")
  strPhone   = Request("reqPHONE")
  
  DebugMessage("REQUEST: " & strRequest)
  DebugMessage("ID: " & strID)
  DebugMessage("Name: " & strName)
  DebugMessage("Address: " & strAddress)
  DebugMessage("Phone: " & strPhone)

  ' Possible trade status
  if (strRequest = "UPDATE") Then
    strSQL=  "UPDATE company SET phone = " + strPhone + ",name = " + strName + ",address = " + strAddress + " WHERE id = " & strID
  end if

  if (strRequest = "INSERT") Then
    strSQL=  "INSERT INTO company (name,address,phone) values (" & strName & "," & strAddress & "," & strPhone & ")"
  end if
  
  if (strRequest = "DELETE") Then
    strSQL=  "DELETE FROM company WHERE id = " & strID
  end if

  DebugMessage("SQL: " & strSQL)

  intRecords = SQLUpdate(strSQL)
  
  Response.Write("Updated " & intRecords & " records")

  Session("Debug") = "False"

  Call PageFooter
%>
