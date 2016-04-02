<!--  #include file = "common.asp" -->
<!--  #include file = "common-client.asp" -->


<HTML>
<HEAD>
</HEAD>
<BODY>
 <h1> Parent Cash Flow Report </h1> 
 <div id=tgtResults> </div>
 <div id=tgtForm> </div>
 <HR>
 <div id=tgtErrors> </div>
 <hr>
</BODY>
</HTML>


<script language="VBScript">

' TODO:
'  When updating a transaction,  ensure that the sign is preserved
'  Permit deleting of transactions.

' ---------------------------------------------------------------
'  Shows the summary table
' ---------------------------------------------------------------

function renderSummaryTable()
  tgtErrors.innerHTML = "<I> NO ERRORS </I>"
  strHTML = RenderXML("xml/rnParentSummary.asp","xsl/rnParentSummary.asp")
  tgtResults.innerHTML = strHTML
  tgtForm.innerHTML = "<I> Select a parent to view transaction history </i>"
end function

' ---------------------------------------------------------------
' Shows the transaction list for a given parent
'  XSL permits adding of transactions
' ---------------------------------------------------------------

function renderParentDetails(strPID)
  
  tgtErrors.innerHTML = "<I> NO ERRORS </I>"
  strHTML = RenderXML("xml/rnParentDetails.asp?pid=" & strPID, _
                      "xsl/rnParentDetails.asp")
  tgtResults.innerHTML = strHTML
  call publishTransactionForm("",strPID,"","","","")
end function

function publishTransactionForm(strId,strPid,strDate,strType,strAmount,strNotes)
  strHTML = "<FORM name='trans' onSubmit='insUpdTransaction(); return false'>" &_
            "<INPUT type=hidden value='" & strId & "' name='id'>" &_
            "<INPUT type=hidden value='" & strPid & "' name='pid'>" &_
            "<TABLE BORDER=1>" &_
            "<TR><TH>Date</TH><TH>Type</TH><TH>Amount</TH><TH>Notes</TH></TR>" &_
            "<TR>" &_
            "<TD><INPUT type=text value='" & strDate & "' name='date'></TD>" &_
            "<TD><SELECT name='type'>" &_
                  "<OPTION  value='" & strType & "'> " & strType & " </OPTION>" &_
                  "<OPTION  value='CHEQUE'> CHEQUE </OPTION>"&_
                  "<OPTION  value='CASH' > CASH </OPTION>" &_
                  "<OPTION  value='SO' > SO </OPTION>" &_
                  "<OPTION  value='REFUND' > REFUND </OPTION>" &_
                  "<OPTION  value='INVOICE' > INVOICE </OPTION></SELECT></TD>" &_
            "<TD><INPUT type=number value='" & strAmount    & "' name='amount'   ></TD>" &_
            "<TD><INPUT type=text value='" & strNotes  & "' name='notes' ></TD>" &_
            "</TR></TABLE>" &_
            "<TABLE>" &_
            "<TR>" &_
            "<TD> <INPUT type=submit value='Submit'/> </TD>" &_
            "<TD> <INPUT type=button onclick='clearForm()' value='Clear'/> </TD>" &_
            "</TR></TABLE>" &_
            "</FORM>"
  tgtForm.innerHTML = strHTML
end function

function clearForm()
  strPId = Document.trans.pid.value
  call publishTransactionForm("",strPID,"","","","")
end function

' ---------------------------------------------------------------
'  Used in the transaction list screen,  scrapes the screen 
'   so is not of value under any other condition
' ---------------------------------------------------------------

function insUpdTransaction
  ' Scrape form to get details
  strPId = Document.trans.pid.value
  strId  = Document.trans.id.value
  strAmount = Document.trans.amount.value
  strNotes = Document.trans.notes.value
  strDate = Document.trans.date.value
  strType = Document.trans.type.value
  ' Validate and expand the details
  ' Check for a non date string!! *SJ*
  If (strDate = "") Then
    strDate = Date
  End if
  
  Dim strSQL 

  strSQL = "ins-upd-transaction.asp?id=" & strId &_
            "&date=" & strDate &_
            "&type=" & strType &_
            "&amount=" & strAmount &_
            "&note=" & strNotes &_
            "&pid=" & strPid

  Dim strResults
  strResults = loadHTTP(strSQL)
  if (strResults <> "") Then
    tgtErrors.innerHTML = strResults
  Else
    Call renderParentDetails(strPId)
  End If
end function

call window.setTimeout("renderSummaryTable()",500)
</script>
