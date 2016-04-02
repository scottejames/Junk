
<%
	Response.ContentType = "text/html"
  Call PageHeader
%>
<!--  #include file = "../common.asp" -->

<%
  Session("Debug") = "False"
  Dim rsGetSummary
  Dim xml
  
  Dim strId
  Dim strDate
  Dim strNotes
  Dim strCompany
  Dim strRequest
  
  strRequest = Request("reqREQUEST")

  strId      = Request("reqID")
  strDate    = Request("reqDATE")
  strNotes   = Request("reqNOTES")
  strCompany = Request("reqCOMPANY")
  
  DebugMessage("ID: " & strID)
  DebugMessage("Date: " & strDate)
  DebugMessage("Notes: " & strNotes)
  DebugMessage("Company: " & strCompany)
  DebugMessage("Request: " & strRequest)

  ' Possible trade status
  if (strRequest = "UPDATE") Then
    strSQL=  "UPDATE notes SET entrydate = " + strDate + ",notes = " + strNotes +" WHERE id = " & strID
  end if

  if (strRequest = "INSERT") Then
    strSQL=  "INSERT INTO notes (entrydate,notes,company) values (" & strDate & "," & strNotes & "," & strCompany & ")"
  end if
  
  if (strRequest = "DELETE") Then
    strSQL=  "DELETE FROM notes WHERE id = " & strID
  end if

  DebugMessage("SQL: " & strSQL)

  intRecords = SQLUpdate(strSQL)
  
  Response.Write("Updated " & intRecords & " records")

  Session("Debug") = "False"
  Call PageFooter
%>
