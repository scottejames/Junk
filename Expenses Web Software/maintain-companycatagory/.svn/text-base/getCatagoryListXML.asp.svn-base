
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
  Dim strCompany 
  strCompany=Request("reqCOMPANY")
  ' Possible trade status
  strSQL=  "SELECT cat.* " &_
           " FROM catagory cat " &_
           " WHERE cat.id NOT IN (SELECT cc.catagory " &_
           " from companycatagory cc " &_
           " WHERE cc.company = " & strCompany & ")"

  Set rsGetSummary = SQLQuery(strSQL)
  
  xml = GenerateXML(rsGetSummary)
  Response.Write(xml)

  rsGetSummary.close
  Set rsGetSummary = Nothing

  Call PageFooter
%>
