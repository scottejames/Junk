<% 
Option Explicit 
Call PageHeader
%>
<!--  #include file = "../common.asp" -->
<!--  #include file = "../common-client.asp" -->

<%
  ' Load default values
  Dim strCompanyName
  Dim strCompanyId 
  Dim strOperation
  Dim strID
  Dim strDayofmonth
  Dim strAmount
  Dim strNote

  strCompanyName = Request("reqCOMPNAME")
  strCompanyId   = Request("reqCOMPID")
  strID          = Request("reqID")
  strDayofmonth  = Request("reqDAYOFMONTH")
  strAmount      = Request("reqAMOUNT")
  strNote        = Request("reqNOTE")

  if strID = "" Then
    strOperation = "INSERT"
  end if
  if strID <> "" Then
    strOperation = "UPDATE"
  end if
%> 
<HTML>      
 <HEAD>
 </HEAD>
 <BODY>
 	<H1> Add Payment for <%=strCompanyName%> </H1>
	<TABLE 	>
    <TR><TD> Day of Month </TD><TD> <INPUT type="text" name="ipDOM" value="<%=strDayofmonth%>" onBlur='validateInput'> </TD></TR>
    <TR><TD> Amount </TD><TD> <INPUT type="text" name="ipAmount" value="<%=strAmount%>" onBlur='validateInput'> </TD></TR>
    <TR><TD> Notes </TD><TD> <INPUT type="text" name="ipNotes" value="<%=strNote%>" onBlur='validateInput'> </TD></TR>
	</TABLE>
  <INPUT type="button" value="add" onclick="postPD"> </INPUT>
	<Div id="tgtErrors"></Div>
	<Div id="tgtResults"></Div>

 </BODY>
</HTML>
<SCRIPT language="VBScript">
function postPD
  Dim strCompany
	Dim strDOM
	Dim strAmount
	Dim strNotes
	
  Dim boolValid
  boolValid = validateInput
  if boolValid = False Then
    Alert("Correct errors before submitting form")
    exit function
  end if
	strCompanyId = "<%=strCompanyId%>"
	strDOM    = Document.all.ipDOM.value
	strAmount = Document.all.ipAmount.value
  strNotes  = Document.all.ipNotes.value
  if strDom = "" or strAmount = "" Then
    Alert("Date and amount MUST be entered before submitting")
    exit function
  end if
  if strNotes = "" Then
    strNotes = "EMPTY"
  end if

	strURL = addToURL(strURL,"reqREQUEST","<%=strOperation%>","False")
	strURL = addToURL(strURL,"reqID","<%=strID%>","False")
	strURL = addToURL(strURL,"reqDOM",strDOM,"True")
	strURL = addToURL(strURL,"reqAMOUNT",strAmount,"True")
	strURL = addToURL(strURL,"reqNOTES",strNotes,"True")
	strURL = addToURL(strURL,"reqCOMPANY",strCompanyId,"False")

	Dim strResults
	strResults = putHTTP("insUpdPaymentDefinition.asp" & strURL)
  tgtResults.innerHTML = strResults
	Window.Opener.loadDivHTML
	Window.close
	
end function

function validateInput
	Dim Dom 
	Dim Amount
	Dim strNotes
	
  validateInput = True
  tgtErrors.innerHTML = ""
	Dom    = Document.all.ipDOM.value
	Amount = Document.all.ipAmount.value
  strNotes  = Document.all.ipNotes.value

  If Not IsNumeric(Amount) Then
    if Not Amount = "" Then
      tgtErrors.innerHTML = "</I> Amount has to be a number .. doofus </I>"
      validateInput = False
      Exit function
    end if
  end if
  if Not Dom = "" Then
    If Not IsNumeric(Dom) Then
      tgtErrors.innerHTML = "</I> Day of month has to be a number .. doofus </I>"
      validateInput = False
      Exit function
   end if
   if Dom > 31 OR Dom < 1 Then
      tgtErrors.innerHTML = "</I> Day of month has to be between 1 and 31 .. doofus </I>"
      validateInput = False
      Exit function
   end if
  end if
end function
</SCRIPT>
<%
  Call PageFooter
%>

