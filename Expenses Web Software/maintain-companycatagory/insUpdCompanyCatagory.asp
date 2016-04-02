
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
  Dim strCompany
  Dim strCatagory

  strRequest  = Request("reqREQUEST") 
  strId       = Request("reqID") ' Not used, deletes key from company
  strCompany  = Request("reqCOMPANY")
  strCatagory = Request("reqCATAGORY")
  
  DebugMessage("REQUEST: " & strRequest)
  DebugMessage("ID: "      & strID)
  DebugMessage("Company: " & strCompany) 
  DebugMessage("Catagory: " & strCatagory)

  ' Possible trade status
  if (strRequest = "UPDATE") Then
    ' No update possible for this table, drop all entries 
    ' and recreate
  end if

  if (strRequest = "INSERT") Then
    strSQL=  "INSERT INTO companycatagory (company,catagory) values (" & strCompany & "," & strCatagory & ")"
  end if
  
  if (strRequest = "DELETEALL") Then
    strSQL=  "DELETE FROM companycatagory WHERE company = " & strCompany
  end if

  DebugMessage("SQL: " & strSQL)

  intRecords = SQLUpdate(strSQL)
  
  Response.Write("Updated " & intRecords & " records")

  Session("Debug") = "False"
  Call PageFooter
%>
