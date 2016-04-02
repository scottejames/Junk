
<% 
Option Explicit 
Call PageHeader
%>
<SCRIPT src="../selectBox.js"></SCRIPT>
<!--  #include file = "../common.asp" -->
<!--  #include file = "../common-client.asp" -->
<%
  Dim strCompanyId
  Dim strCompanyName

  strCompanyId     = Request("reqCOMPID")
  strCompanyName   = Request("reqCOMPNAME")
%>

<HTML>      
 <BODY>
 	<H1> Maintain catagories <%=strCompanyName%> </H1>
  <TABLE>
  <TR>
    <TH> Catagories Available </TH>
    <TH> </TH>
    <TH> Catagories Selected </TH>
  </TR>
  <TR>    
    <TD>
      <div id='tgtAvail'></div> 
    </TD>
    <TD align=middle vAlign=middle>
      <INPUT onclick='removeEntry()' type=button value="<">
      <INPUT onclick='assignEntry()' type=button value=">"><BR>
    </TD>
    <TD>
      <div id='tgtChosen'></div> 
    </TD>
    <TD>
      <input type='button' onclick='saveChanges()' value='save'> </input>
    </TD>
  </TR>
  </TABLE>
  <div id='tgtResults'></div> 
 </BODY>
</HTML>
<SCRIPT language="VBScript">

call showCatagoryList
function showCatagoryList
  Dim strHTML
  strHTML = RenderXML ("./getCatagoryListXML.asp?reqCOMPANY=<%=strCompanyId%>" , _
                                 "../maintain-catagories/getCatagoryListAsSelectXSL.xsl")
  strHTML = "<SELECT name=avail size='5' style='WIDTH: 220px'>" & strHTML & "</SELECT>"

  tgtAvail.innerHTML = strHTML
  strHTML = RenderXML ("./getCompanyCatagoryListXML.asp?reqCOMPANY=<%=strCompanyId%>", _
                                 "../maintain-catagories/getCatagoryListAsSelectXSL.xsl")
  strHTML = "<SELECT name=chosen size='5' style='WIDTH: 220px'>" & strHTML & "</SELECT>"

  tgtChosen.innerHTML = strHTML
end function

function saveChanges

  Dim strURL
  
  strURL = ""

  strURL = addToURL(strURL,"reqREQUEST","DELETEALL","False")
  strURL = addToURL(strURL,"reqCOMPANY","<%=strCompanyId%>","False")
  tgtResults.innerHTML = putHTTP("insUpdCompanyCatagory.asp" & strURL) 

  strURL = ""
  Dim elem
	for Each elem In Document.all.chosen.options
    strURL = addToURL(strURL,"reqREQUEST","INSERT","False")
    strURL = addToURL(strURL,"reqCOMPANY","<%=strCompanyId%>","False")
    strURL = addToURL(strURL,"reqCATAGORY",elem.value,"False")
    tgtResults.innerHTML = putHTTP("insUpdCompanyCatagory.asp" & strURL) 
    strURL = ""
  next 
	Window.Opener.loadDivHTML
	Window.close
   
end function

function assignEntry
  Dim availIndex,availLength

  availIndex  = Document.all.avail.selectedIndex
  availLength = Document.all.avail.options.length

  if availIndex = -1 then
    alert("You must select something in the list")
    exit function
  end if

  Dim opt
  set opt = Document.createElement("option")
  
  opt.text  = Document.all.avail(availIndex).text
  opt.value  = Document.all.avail(availIndex).value

  Document.all.avail.options.remove availIndex
  
  chosen.options.add opt

end function 

function removeEntry
  Dim chosenIndex,chosenLength

  chosenIndex  = Document.all.chosen.selectedIndex
  chosenLength = Document.all.chosen.options.length

  if chosenIndex = -1 then
    alert("You must select something in the list")
    exit function
  end if

  Dim opt
  set opt = Document.createElement("option")
  
  opt.text  = Document.all.chosen(chosenIndex).text
  opt.value  = Document.all.chosen(chosenIndex).value

  Document.all.chosen.options.remove chosenIndex
  
  avail.options.add opt

end function
</SCRIPT>

<%
  Call PageFooter
%>

