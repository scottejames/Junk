
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
  strDom     = Request("reqDOM")
  strAmount  = Request("reqAMOUNT")
  strPeriod  = Request("reqPERIOD")
  strPayment = Request("reqPAYMENT")
  
  DebugMessage("REQUEST: " & strRequest)
  DebugMessage("ID: "      & strID)
  DebugMessage("DayOfMonth: " & strDOM)
  DebugMessage("Amount: "     & strAmount)
  DebugMessage("Period: "     & strPeriod)
  DebugMessage("Payment: "    & strPayment)

  ' Possible trade status
  if (strRequest = "UPDATE") Then
    strSQL=  "UPDATE paymentdefinitions " &_
             " SET dayofmonth = " + strDom + ", amount = " + strAmount + ",period = " + strPeriod + ",payment = " + strPayment &_
             " WHERE id = " & strID
  end if

  if (strRequest = "INSERT") Then
    strSQL=  "INSERT INTO paymentdefinitions (dayofmonth,amount,period,payment) values (" & strDom & "," & strAmount & "," & strPeriod & "," & strPayment &")"
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
