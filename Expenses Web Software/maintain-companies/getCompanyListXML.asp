
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
  
  Dim strOrderBy

  Dim strCatagoryFilter

  strOrderBy = Request("reqORDER")
  strCatagoryFilter = Request("reqFILTER")
 
  Dim strFilterSQL
  strFilterSQL = ""
  if (strCatagoryFilter <> "all") then
    strFilterSQL = ",companycatagory cc,catagory cat " &_
                   " WHERE cc.catagory = cat.id " &_
                   " AND   cc.company = c.id " &_
                   " AND   cat.id = " & strCatagoryFilter

  end if
  
  ' Possible trade status
  if (strOrderBy = "") Then
    strSQL=  "SELECT c.* " &_
             "FROM company c " & strFilterSQL
  else
    strSQL=  "SELECT c.* " &_
             "FROM company c " & strFilterSQL &_
             " order by c." & strOrderBy
  end if

  Set rsGetSummary = SQLQuery(strSQL)
  xml = GenerateXML(rsGetSummary)
  Response.Write(xml)

  rsGetSummary.close
  Set rsGetSummary = Nothing

  Session("Debug") = "False"
  Call PageFooter
%>
