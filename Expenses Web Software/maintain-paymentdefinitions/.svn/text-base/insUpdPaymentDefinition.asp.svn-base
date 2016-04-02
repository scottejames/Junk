
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
  Dim strDom
  Dim strAmount
  Dim strNotes

  strRequest = Request("reqREQUEST") 
  strId      = Request("reqID")
  strDom     = Request("reqDOM")
  strAmount  = Request("reqAMOUNT")
  strNotes   = Request("reqNOTES")
  strCompany = Request("reqCOMPANY")
  
  DebugMessage("REQUEST: " & strRequest)
  DebugMessage("ID: "      & strID)
  DebugMessage("DayOfMonth: " & strDOM)
  DebugMessage("Amount: "     & strAmount)
  DebugMessage("Notes: "      & strNotes)
  DebugMessage("Copmany: "    & strCompany)

  ' Possible trade status
  if (strRequest = "UPDATE") Then
    strSQL=  "UPDATE paymentdefinitions " &_
             " SET dayofmonth = " + strDom + ", amount = " + strAmount + ",notes = " + strNotes  &_
             " WHERE id = " & strID
  end if

  if (strRequest = "INSERT") Then
    strSQL=  "INSERT INTO paymentdefinitions (dayofmonth,amount,notes,company) values (" & strDom & "," & strAmount & "," & strNotes & "," & strCompany &")"
  end if
  
  if (strRequest = "DELETE") Then
    strSQL=  "DELETE FROM paymentdefinitions WHERE id = " & strID
  end if

  DebugMessage("SQL: " & strSQL)

  intRecords = SQLUpdate(strSQL)
  
Response.Write("Updated " & intRecords & " records")

  Session("Debug") = "False"
  Call PageFooter
%>
