<!--  #include file = "../common.asp" -->

<%

  Dim strSQLGetSummary
  Dim rsGetSummary
  Dim strSource
  Dim strStatus
  Dim xml

  ' Possible trade status
  strPID = Request("pid")

  strSQL=  "EXECUTE sp_getTransactionSummary " & strPID 

  Set rsGetSummary= SQLQuery("accounts",strSQL)
  xml = GenerateXML(rsGetSummary)
  Response.Write(xml)
  rsGetSummary.close
  Set rsGetSummary = Nothing

%>
