<!--  #include file = "../common.asp" -->

<%

  Dim strSQLGetSummary
  Dim rsGetSummary
  Dim strSource
  Dim strStatus
  Dim xml

  ' Possible trade status
  strPID = Request("pid")

  strSQL= "SELECT rnParentDetails.*, rnTransactionDetail.*" &_
          " FROM rnParentDetails INNER JOIN rnTransactionDetail ON rnParentDetails.id = rnTransactionDetail.rnParentDetails" &_
          " WHERE (((rnParentDetails.id)=" & strPID & "))"

  Set rsGetSummary= SQLQuery("accounts",strSQL)
  xml = GenerateXML(rsGetSummary)
  Response.Write(xml)
  rsGetSummary.close
  Set rsGetSummary = Nothing

%>
