

<!--  #include file = "../common.asp" -->
<!--  #include file = "../common-client.asp" -->

<HTML>
  <HEAD>
  </HEAD>
  <BODY>
    <h1> Maintain PaymentDefiniton </H1>
    <DIV id="xslTarget"></DIV> 

    <DIV id="tgtResults"></DIV> 
  </BODY>
</HTML>
<%
  Dim strCompany
  strCompany = Request("reqCOMPANY")
%>
<SCRIPT language=VBScript>

renderTable

function renderTable
  Dim strHTML
  strHTML = RenderXML ("getPaymentDefinitionXML.asp?reqCOMPANY=<%=strCompany%>" ,"getPaymentDefinitionXSL.xsl")
  xslTarget.innerHTML = strHTML
end function


</SCRIPT>
