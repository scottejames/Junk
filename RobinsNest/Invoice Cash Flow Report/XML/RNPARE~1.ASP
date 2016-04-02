
<% 
  option explicit
%>

<!--  #include file = "../common.asp" -->

<%
  Dim strSQL
  Dim rsGetSummary
  Dim xml
  Dim strFilter
  strFilter=Request("limitres")
  if (strFilter="") Then
    strFilter="%"
  end if
  strFilter = Replace(strFilter,"*","%")
  if (Request("showdeleted") = "") Then
    strSQL = "EXECUTE sp_getActParentSumm '" & strFilter & "'"
  else
    strSQL = "EXECUTE sp_getParentSumm '" & strFilter & "'"
  end if
  ' Possible trade status

  Set rsGetSummary= SQLQuery("accounts",strSQL)
  xml = GenerateXML(rsGetSummary)
  Response.Write(xml)
  rsGetSummary.close
  Set rsGetSummary = Nothing

%>
