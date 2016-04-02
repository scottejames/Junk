

<%
	Response.ContentType = "text/xml"
  Call PageHeader
%>
<!--  #include file = "../common.asp" -->

<%
  Session("Debug") = "False"
  Dim strSQLGetSummary
  Dim rsGetSummary
  Dim strSource
  Dim strStatus
  Dim xml
  
  Dim strCompany

  strCompany = Request("reqCOMPANY")

  if (strCompany = "") Then
    Call DisplayError(3,"This page requires a company to be passed in")
  End If

  strSQL=  "SELECT * from paymentdefinitions where company = " & strCompany & " order by dayofmonth"
  DebugMessage("SQL query:" & strSQL)
  Set rsGetSummary = SQLQuery(strSQL)
  xml = GenerateXML(rsGetSummary)
  Response.Write(xml)

  'rsGetSummary.close
  Set rsGetSummary = Nothing

  Session("Debug") = "False"
  Call PageFooter
%>
