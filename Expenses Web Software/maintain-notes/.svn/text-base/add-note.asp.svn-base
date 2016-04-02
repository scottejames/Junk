<% 
Option Explicit 
Call PageHeader
%>
<!--  #include file = "../common.asp" -->
<!--  #include file = "../common-client.asp" -->
<%
  Dim strCompanyName
  Dim strCompanyId
  Dim strNoteId
  Dim strNoteDate
  Dim strNoteContent
  Dim strOperation

  strCompanyName = Request("reqCOMPNAME")
  strCompanyId   = Request("reqCOMPID")
  strNoteId      = Request("reqID")
  strNoteDate    = Request("reqDATE")
  strNoteContent = Request("reqNOTE")

  if strNoteDate = "" Then
    strNoteDate = Now
  end if
  if strNoteId = "" Then
    strOperation = "INSERT"
  end if
  if strNoteId <> "" Then
    strOperation = "UPDATE"
  end if
%>

<HTML>      
 <HEAD>
 </HEAD>
 <BODY>
 	<H1> Add Note to company <%=strCompanyName%> </H1>
	<TABLE 	>
	<TR><TH> Date </TH> <TH> Note </TH> <TH></TH></TR>
	<TR>
	<TD valign='top'>
		<INPUT type="text" name='ipDate' value='<%=strNoteDate%>'></INPUT>
	</TD>
        <TD> <TEXTAREA COLS=40 ROWS=4 Name='ipNotes'><%=strNoteContent%></TEXTAREA>
	</TD>
	<TD>
		<INPUT type="button" name='add' value='add' onclick='postNote'></INPUT>
	</TD>
	</TR>
	</TABLE>
	<Div id="tgtResults"></Div>

 </BODY>
</HTML>
<SCRIPT language="VBScript">
function postNote
	Dim strDate
	Dim strNotes
	Dim strId
	Dim strURL
	Dim strCompanyId
	
	strCompanyId = "<%=strCompanyId%>"
	
	if strCompanyId = "" then
		strCompanyId = "0"
	end if

	strDate  = Document.all.ipDate.value
	strNotes = Document.all.ipNotes.value
  if strNotes = "" Then 
    alert("No notes entered not adding anything")
    exit function
  end if

  ' SHould add further validation to prevent silent failure
	strURL = addToURL(strURL,"reqREQUEST","<%=strOperation%>","False")
	strURL = addToURL(strURL,"reqID","<%=strNoteId%>","False")
	strURL = addToURL(strURL,"reqDATE",strDate,"True")
	strURL = addToURL(strURL,"reqNOTES",strNotes,"True")
	strURL = addToURL(strURL,"reqCOMPANY",strCompanyId,"True")

	Dim strResults
	strResults = putHTTP("insUpdNotes.asp" & strURL)
  tgtResults.innerHTML = strResults
	Window.Opener.loadDivHTML
	Window.close
	
end function
</SCRIPT>
<%
  Call PageFooter
%>

