
<!--  #include file = "common.asp" -->
<!--  #include file = "common-client.asp" -->

<HTML>
<HEAD>
</HEAD>
<BODY>
 <h1> Parent Maint </h1> 
 <FORM language=javascript name='limit' onSubmit='renderSummaryTable();return false'>
 <B> Input expression to limit results </b>
 <input type=text value='' name='expression'/>
 <INPUT type=submit value='Submit'/> 
 </FORM>
 <div id=tgtResults> </div>
 <HR>
 <div id=tgtForm> </div>
 <HR>
 <div id=tgtErrors> </div>
 <HR>
</BODY>
</HTML>


<script language="VBScript">

' ---------------------------------------------------------------
'  Shows the summary table
' ---------------------------------------------------------------

function renderSummaryTable

  tgtErrors.innerHTML = "<I> NO ERRORS </I>"
  strLimit = Document.limit.expression.value

  strHTML = RenderXML("xml/rnParentSummary.asp?showdeleted='TRUE'&limitres=" & strLimit ,"xsl/rnParentMaintenence.xsl")
  tgtResults.innerHTML = strHTML
  Call publishParentForm("","","","","","")

end function

function publishParentForm(strId,strTitle,strInitial,strSurname,strNotes,strDeleted)
  
  ' Normalise args
  if (strDeleted = "-1") Then 
    strDeleted = "YES"
  end if

  if (strDeleted = "0") Then 
    strDeleted = "NO"
  end if
  strHTML = "<FORM name='parent' onSubmit='insUpdParent(); return false'>" &_
            "<INPUT type=hidden value='" & strId & "' name='pid'>" &_
            "<TABLE BORDER=1>" &_
            "<TR><TH>Title</TH><TH>Initial</TH><TH>Surname</TH><TH>Notes</TH><TH>Deleted</TH></TR>" &_
            "<TR>" &_
            "<TD><INPUT type=text value='" & strTitle & "' name='title'></TD>" &_
            "<TD><INPUT type=text value='" & strInitial & "' name='initial'></TD>" &_
            "<TD><INPUT type=text value='" & strSurname & "' name='surname'></TD>" &_
            "<TD><INPUT type=text value='" & strNotes & "' name='notes'></TD>" &_
            "<TD><INPUT type=text value='" & strDeleted & "' name='deleted'></TD>" &_
            "</TR></TABLE>" &_
            "<TABLE>" &_
            "<TR>" &_
            "<TD> <INPUT type=submit value='Submit'/> </TD>" &_
            "<TD> <INPUT type=button onclick='ClearForm()' value='Clear'/> </TD>" &_
            "</TR></TABLE>" &_
            "</FORM>"
  tgtForm.innerHTML = strHTML
end function

function insUpdParent
  strPId = Document.parent.pid.value
  strTitle = Document.parent.title.value
  strInitial = Document.parent.initial.value
  strSurname = Document.parent.surname.value
  strNotes = Document.parent.notes.value
  strDeleted = Document.parent.deleted.value
  if (strPId = "") Then
    tgtErrors.innerHTML = "<B> You cant add new parents from here, add them from CPLAY and merge, to update select a parent</B>"
    exit function
    
  end if
  strURL = "ins-upd-parent.asp" &_
                      "?pid=" & strPid &_
                      "&title=" & strTitle &_
                      "&initial=" & strInitial &_
                      "&surname=" & strSurname &_
                      "&notes=" & strNotes &_
                      "&deleted=" & strDeleted

  Dim strResults
  strResults = loadHTTP(strURL)
  if (strResults <> "") Then
    tgtErrors.innerHTML = strResults
  Else
    Call renderSummaryTable
  End If
end function

function clearForm
  Call publishParentForm("","","","","","")
end function
renderSummaryTable
</script>
