<%
	Response.ContentType = "text/html"
  Session("Debug") = "False"
  Call PageHeader
%>
<!--  #include file = "../common.asp" -->

<%

  Dim strSQLGetSummary
  Dim rsGetSummary
  Dim strSource
  Dim strStatus
  Dim xml

  ' Possible trade status
  strSQL=  "SELECT * from catagory"

  Set rsGetSummary = SQLQuery(strSQL)
  xml = GenerateXML(rsGetSummary)
  Response.Write(xml)

  rsGetSummary.close
  Set rsGetSummary = Nothing

  Call PageFooter
%>
