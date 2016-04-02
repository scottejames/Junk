<%
' Process globals
Call PageHeader

Dim strCompanyId
Dim strCompanyName
Dim strCompanyAddress
Dim strCompanyPhone

Dim strPeriod
Dim iAmount
Dim strDoMValue
Dim strPayDefID

Dim boolShowSave
Dim boolShowEdit
Dim boolShowCatagories
Dim boolShowClose
Dim boolShowDelete
Dim boolShowNote

Dim strEditable

Dim windCompanyList

strCompanyName = ""
strCompanyAddress = ""
strCompanyPhone = ""

strEditable = ""

' ---------------------------------------------------------------
'  Process request, this page is modal, it handles the
'  addition of companies, editing companies and viewing companies
' ---------------------------------------------------------------
If Request("reqREQUEST") = "New" Then
  Call handleNew
end if
If Request("reqREQUEST") = "Edit" Then
  Call handleEdit
end if
If Request("reqREQUEST") = "Show" Then
  Call handleShow
end if
If Request("reqREQUEST") = "" Then
  Call handleShow
end if

' ---------------------------------------------------------------
' Handle requests, this will populate the form based on the 
' request type
' ---------------------------------------------------------------

function handleEdit

  Call populateCompanyGlobals

  boolShowSave="True"
  boolShowClose="True"
  boolShowDelete="True"

  boolShowCatagories = "False"
end function
' ---------------------------------------------------------------
function handleNew
  strCompanyName = ""
  strCompanyAddress = ""

  boolShowSave="True"
  boolShowClose="True"
  boolShowCatagories = "False"
end function
' ---------------------------------------------------------------
function handleShow
  Call populateCompanyGlobals
  strEditable = "DISABLED"

  boolShowEdit="True"
  boolSHowClose="True"
  boolShowDelete="True"
  boolShowNote="True"
  boolShowCatagories = "True"
end function
' ---------------------------------------------------------------
function populateCompanyGlobals
  Dim strSQL

  strCompanyId = Request("reqID")
  strSQL = "SELECT c.* " &_
             "FROM company c "&_
             "WHERE c.id = " & strCompanyId

  Dim objRS
  set objRS = SQLQuery(strSQL)
  
  if (objRS.state = adStateOpen) AND _
     Not (objRS.EOF) Then
    strCompanyName = objRS("name")
    strCompanyAddress = objRS("address")
    strCompanyPhone = objRS("phone")
  end if

  objRS.close
end function

%>
<!--  #include file = "../common.asp" -->
<!--  #include file = "../common-client.asp" -->

<HTML>
<LINK href="../style.css" rel=stylesheet type=text/css>
  <HEAD>
        <TITLE> Company Details </TITLE>
  </HEAD>
  <BODY>
    <div align=Center>    <h1> Company Details </h1></div>
    <Div id='tgtResults' </Div> 
    <table border =1>
    <TR valigh='TOP'>
        <TD>
          <h2> Company Details </h2>
            <TABLE>
              <TR>
                <TD> Company Name </TD>
                <TD> <INPUT type='TEXT' Name='ipCompanyName' value='<%=strCompanyName%>' <%=strEditable%> </INPUT> </TD>
              </TR>
              <TR>
                <TD> Address </TD>
                <TD> <TEXTAREA ROWS=4 Name='ipCompanyAddress' <%=strEditable%>><%=strCompanyAddress%></TEXTAREA> </TD>
              </TR>
              <TR>
                <TD> Phone </TD>
                <TD> <INPUT type='TEXT' Name='ipCompanyPhone' value='<%=strCompanyPhone%>' <%=strEditable%> </INPUT> </TD>
              </TR>
            </TABLE>
        </TD>
<% IF boolShowCatagories = "True" Then%>
        <TD>
          <TABLE>
            <TR><TD> <H2> Catagories </H2></TD></TR>
            <TR><TD> <Div id='tgtCatagories'> </Div> </TD></TR>
            <TR><TD> <INPUT type=Button onclick='changeCatagory' value='change catagory'></INPUT></TD></TR>
            </TABLE>
        </TD>
<% end if %>
    </TR>
    </TABLE>
<% If boolShowNote = "True" Then %>
    <TABLE>
    <TR>
      <TD><H3> Payments </H3></TD>
      <TD valign=top><INPUT type=Button onclick='addPayment' value='add payment'></INPUT></TD>
    </TR>
    </TABLE>
    <div id='tgtPayments'></div>
    <TABLE>
    <TR>
      <TD><H3> Notes </H3></TD>
      <TD valign=top><INPUT type=Button onclick='addNote' value='add note'></INPUT></TD>
    </TR>
    </TABLE>
    <div id='tgtNotes'></div>
    <div id='tgtDebug'></div>
   
<% End if %>
    <HR>
    <Div align = "CENTER">
    <TABLE>
    <TR>
<% If boolShowSave = "True" Then %>
      <TD><INPUT type=Button onclick='saveCompany' value='save'></INPUT></TD>
<% End IF %>
<% If boolShowEdit = "True" Then %>
      <TD><INPUT type=Button onclick='editCompany' value='edit'></INPUT></TD>
<% End IF %>
<% If boolShowDelete = "True" Then %>
      <TD><INPUT type=Button onclick='deleteCompany' value='delete'></INPUT></TD>
<% End IF %>
<% If boolShowClose = "True" Then %>
      <TD><INPUT type=Button onclick='close' value='close'></INPUT></TD>
<% End IF %>

    </TR>
    </TABLE>
    </DIV>
  </BODY>
</HTML>

<SCRIPT languge="VBScript">


<% If Request("reqREQUEST") = "Show" Then %>

tgtNotes.innerHTML = ""
loadDivHTML

function loadDivHTML
<% If boolShowNote = "True" Then %>
	tgtPayments.innerHTML = RenderXML("../maintain-paymentdefinitions/getPaymentDefinitionXML.asp?reqCOMPANY=" & <%=strCompanyId%>,"../maintain-paymentdefinitions/getPaymentDefinitionXSL.xsl")
	tgtNotes.innerHTML = RenderXML("../maintain-notes/getNotesXML.asp?reqCOMPANY=" & <%=strCompanyId%>,"../maintain-notes/getNotesXSL.xsl")

<% End if %>

<% IF boolShowCatagories = "True" Then%>
  Dim strCatagory
  strCatagory = RenderXML("../maintain-companycatagory/getCompanyCatagoryListXML.asp?reqCOMPANY=" & <%=strCompanyId%>,"../maintain-catagories/getCatagoryListAsListXSL.xsl")
	tgtCatagories.innerHTML =  strCatagory

<% End if %>
  
end function

<% end if %>

function saveCompany

  Dim strCompanyName 
  Dim strCompanyAddress
  Dim strCompanyPhone
 
  strCompanyName    = Document.all.ipCompanyName.value
  strCompanyAddress = Document.all.ipCompanyAddress.value
  strCompanyPhone   = Document.all.ipCompanyPhone.value

  Dim strURL
  
  strURL = ""
  <% if strCompanyId = "" Then %>
    strURL = addToURL(strURL,"reqREQUEST","INSERT","False")
  <% else %>
    strURL = addToURL(strURL,"reqREQUEST","UPDATE","False")
    strURL = addToURL(strURL,"reqID","<%=strCompanyId%>","False")
  <% end if %>
  strURL = addToURL(strURL,"reqNAME",strCompanyName,"True")
  strURL = addToURL(strURL,"reqADDRESS",strCompanyAddress,"True")
  strURL = addToURL(strURL,"reqPHONE",strCompanyPhone,"True")

  putHTTP("insUpdCompany.asp" & strURL) 

  Window.Opener.renderTable	

  Window.document.location = "maintain-companies.asp?reqREQUEST=Show&reqID=<%=strCompanyId%>"
end function

function editCompany
  <% if strCompanyId <> "" Then %>
  Window.document.location = "maintain-companies.asp?reqREQUEST=Edit&reqID=<%=strCompanyId%>"
  <% End if %>
end function

function changeCatagory
	Call NewWindow("../maintain-companycatagory/maintain-companycatagory.asp?reqCOMPID=<%=strCompanyId%>&reqCOMPNAME=<%=strCompanyName%>",600,250)	
end function

function deleteCompany
  retVal = makeMsgBox("Confirm","Are you sure you want to delete this?",32,1,256,4096)
  if (retVal = 1) Then
        strURL = ""
        <% if strCompanyId <> "" Then %>
        strURL = addToURL(strURL,"reqREQUEST","DELETE","False")
        strURL = addToURL(strURL,"reqID","<%=strCompanyId%>","False")
        
        tgtResults.innerHTML = putHTTP("insUpdCompany.asp" & strURL) 
        Window.Opener.renderTable
        Window.Close
        <% else %>
        MsgBox("No company availible to delete")
        <% end if %>
   end if    
end function

function addNote
	Call NewWindow("../maintain-notes/add-note.asp?reqCOMPID=<%=strCompanyId%>&reqCOMPNAME=<%=strCompanyName%>",600,250)	
end function
function addPayment
	Call NewWindow("../maintain-paymentdefinitions/add-paymentdefinition.asp?reqCOMPID=<%=strCompanyId%>&reqCOMPNAME=<%=strCompanyName%>",600,250)	
end function

function processPaymentEdit(strId,strDayofmonth,strAmount,strNotes)
  Dim strURL

  strURL = addToURL(strURL,"reqCOMPID","<%=strCompanyId%>","False")
  strURL = addToURL(strURL,"reqCOMPNAME","<%=strCompanyName%>","False")
  strURL = addToURL(strURL,"reqID",strId,"False")
  strURL = addToURL(strURL,"reqDAYOFMONTH",strDayofmonth,"False")
  strURL = addToURL(strURL,"reqAMOUNT",strAmount,"False")
  strURL = addToURL(strURL,"reqNOTE",strNotes,"False")

	Call NewWindow("../maintain-paymentdefinitions/add-paymentdefinition.asp" & strURL ,600,250)	
end function

function processPaymentDelete(strId)
  Dim retVal
  retVal = makeMsgBox("Confirm","Are you sure you want to delete this?",32,1,256,4096)

  if (retVal = 1) Then
    Dim strURL
    strURL = addToURL (strURL,"reqREQUEST","DELETE","False")
    strURL = addToURL (strURL,"reqID",strId,"False")

    Dim strResult
    strResult = putHTTP("../maintain-paymentdefinitions/insUpdPaymentDefinition.asp" & strURL) 
    Call loadDivHTML 
  end if
end function

function processNoteEdit(strId,strDate,strNotes)

  Dim strURL

  strURL = addToURL(strURL,"reqCOMPID","<%=strCompanyId%>","False")
  strURL = addToURL(strURL,"reqCOMPNAME","<%=strCompanyName%>","False")
  strURL = addToURL(strURL,"reqID",strId,"False")
  strURL = addToURL(strURL,"reqDATE",strDate,"False")
  strURL = addToURL(strURL,"reqNOTE",strNotes,"False")

	Call NewWindow("../maintain-notes/add-note.asp" & strURL ,600,250)	
end function

function processNoteDelete(strId)
  Dim retVal
  retVal = makeMsgBox("Confirm","Are you sure you want to delete this?",32,1,256,4096)
  if (retVal = 1) Then
    Dim strURL
    strURL = addToURL (strURL,"reqREQUEST","DELETE","False")
    strURL = addToURL (strURL,"reqID",strId,"False")

    putHTTP("../maintain-notes/insUpdNotes.asp" & strURL) 
    Call loadDivHTML 
  end if
end function

</SCRIPT>

<%
  Call PageFooter
%>
