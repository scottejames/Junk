<!--  #include file = "common.asp" -->
<HTML>
<HEAD>
</HEAD>
<BODY>
 <h1> Invoice Merge Tool </h1>
 <P>
    *SJ* Write some blurb
 </P>
<HR>
  <CENTER><TABLE><TR> <TD><DIV id='tgtForm'/></TD></TR></TABLE>
<HR>
 
<CENTER>
<TABLE BORDER=3>
  <TR> <TD> Status: </TD> <TD> <Div id='tgtStatus'/> </TD> </TR>
  <TR> <TD> Results: </TD> <TD> <Div id='tgtResults'/> </TD> </TR>
  <TR> <TD> Errors: </TD> <TD> <Div id='tgtErrors'/> </TD> </TR>
</TABLE>
<%
  Call InsertInvoiceTable() ' Will insert invoice table if data is avaible
%>
</CENTER>

<script language="VBScript">
Dim maxinvoice,minInvoice,parentCode,current,posted

maxInvoice="<%=Request("maxinvoice")%>" ' Merge all invoices from max up
minInvoice="<%=Request("mininvoice")%>" ' Merge all invoices from max up
parentCode="<%=Request("parentcode")%>" ' Merge all invoices for a particular parent
current   ="<%=Request("current")%>"    ' Merge only invoices for the current period
posted    ="<%=Request("posted")%>" 

tgtStatus.innerText = "Waiting for instructions"

if (posted = "") Then
  tgtForm.innerHTML = _
                 " <CENTER>" &_
                 "     <FORM>" &_
                 "       <INPUT type=hidden value='posted' name='posted'/>" &_ 
                 "       <TABLE>" &_
                 "         <TR> <TD> MIN Invoice </TD><TD><INPUT type=text name='mininvoice'/></TD> " &_
                 "              <TD> MAX Invoice </TD><TD><INPUT type=text name='maxinvoice'/></TD> </TR>" &_
                 "         <TR> <TD> Parent Name (* is wild) </TD><TD><INPUT type=text name='parentcode'/>" &_
                 "              <TD> Current Invoices </TD><TD><select name='current'/>" &_
                 "                                               <option value=''> NO </option>" &_
                 "                                               <option value=-1> YES </option>" &_
                 "                                               </SELECT> </TD> </TR>" &_
                 "       </TABLE>" &_
                 "       <INPUT type=submit  value='Load invoices into the system'/>" &_
                 "     </FORM>" &_
                 " </CENTER>"
else
  tgtForm.innerHTML = _
                  "<CENTER>" &_
                  "    <FORM>" &_
                  "      <INPUT type=button onclick='processInvoices()' value='Process Invoice List'/>" &_
                  "    </FORM>" &_
                  "</CENTER>"
end if

'======================================================================================
function ProcessInvoices()
  
  tgtStatus.innerText = "Processing Request"

  Dim objRow
  Dim objCell
  Dim strCode
  Dim strNotes
  Dim strResults

  For Each objRow In Document.all.udte.rows
    For Each objCell In objRow.cells
      if (objCell.name="EXTCODE") Then
        strCode = objCell.innerText
      end if
      if (objCell.name="NOTES") Then
        strNotes = objCell.innerText
      end if
    next
    if strNotes = "Valid" Then
        strURL = "merge-invoice.asp?extref='" & strCode & "'"
        strResults = loadHTTP(strURL)

        if (strResults="") Then 
          tgtResults.innerText = tgtResults.innerText & vbCrlf & "Processing invoice: " & strCode
        else
          tgtResults.innerText = tgtResults.innerText & vbCrlf & "FAILED Processing invoice: " & strCode
          tgtErrors.innerHTML = tgtErrors.innerHTML & vbCrlf & "<HR>" & strResults & "(FOR " & strCode & ")"
        end if
    end if
  next
  tgtStatus.innerText = "Processing Complete"
end function
</script>


<%
'======================================================================================
function InsertInvoiceTable() 

  if (Request("posted") <> "") Then
    Response.Write("<HR>")
    Dim strSQL,rsInvoiceList

    strSQL = createInvoiceListSQL
    Set rsInvoiceList = SQLQuery("accounts",strSQL)

    Response.Write("<TABLE BORDER=3 id='udte'>") 
    Response.Write("<TR><TH Name='EXTCODE'> Invoice Number </TH><TH Name='CHILDCD'> Child Code </TH><TH Name = 'PARENTCD'> Parent Code </TH><TH Name = 'AMOUNT' > Amount </TH><TH Name='NOTES'> Notes </TH></TR>") 
  
    Do While NOT (rsInvoiceList.EOF)
      Response.Write("<TR>")
      Response.Write("<TD NAME='EXTCODE'>" & rsInvoiceList("InvoiceNumber") & "</TD>")
      Response.Write("<TD NAME='CHIDCD'>" & rsInvoiceList("ChildCode") & "</TD>")
      Response.Write("<TD NAME='PARENTCD'>" & rsInvoiceList("ParentCode") & "</TD>")
      Response.Write("<TD NAME='AMOUNT' >" & rsInvoiceList("InvoiceNetAmount") & "</TD>")

      ' Valiidate as best possible that import is possible.
      Dim strValidate
      strValidate = ""
      ' Check that the reference number is not already used
      Dim boolResult
      boolResult = validateReferenceNumber(rsInvoiceList("InvoiceNumber"))

      if (boolResult = False) Then
        strValidate = strValidate & " Invoice already loaded"
      end if

      ' Check that the parent code is valid and loaded
      boolResult = validateParentCode(rsInvoiceList("ParentCode"))

      if (boolResult = False) Then
        strValidate = strValidate & " Parent Code is Invalid"
      end if

      if (strValidate = "") Then
        strValidate = "Valid"
      end if 

      Response.Write("<TD Name='NOTES'>" & strValidate & "</TD>")

      Response.Write("</TR>")
      rsInvoiceList.MoveNext
    Loop
    Response.Write("</TABLE>") 
    rsInvoiceList.close
    set rsInvoiceList = Nothing
  end if
end function

'======================================================================================
function validateReferenceNumber(strReferenceNumber)
  Dim strSQL,rsValidate
  validateReferenceNumber = False

  strSQL     =  "SELECT COUNT(*) As Cnt " &_
                "FROM rnTransactionGrouping " &_
                "WHERE extref = '" & strReferenceNumber & "'"
  Set rsValidate = SQLQuery("accounts",strSQL)
  if NOT (rsValidate.EOF) Then
    if (rsValidate("Cnt") = 0) Then
      validateReferenceNumber = True
    end if
  end if 
  rsValidate.close
  Set rsValidate = Nothing
end function

'======================================================================================
function validateParentCode(strParentCode)

  Dim strSQL,rsValidate
  validateParentCode = False

  strSQL     =  "SELECT COUNT(*) As Cnt " &_
                "FROM rnParentDetails " &_
                "WHERE cplaycode = '" & strParentCode & "'"

  Set rsValidate = SQLQuery("accounts",strSQL)
  if NOT (rsValidate.EOF) Then
    if (rsValidate("Cnt") = 1) Then
      validateParentCode = True
    end if
  end if 
  rsValidate.close
  Set rsValidate = Nothing
end function
'------------------------------------------------------
' NAME: createInvoiceListSQL
' DESC:
'   Create SQL to get INVOICE list
'------------------------------------------------------

function createInvoiceListSQL

    Dim maxInvoice,minInvoice,parentCode,current

    maxInvoice=Request("maxinvoice") ' Merge all invoices from max up
    minInvoice=Request("mininvoice") ' Merge all invoices from max up
    parentCode=Request("parentcode") ' Merge all invoices for a particular parent
    current   =Request("current")    ' Merge only invoices for the current period

    strGetInvoiceSQL = _
      "SELECT tblInvoice.InvoiceNumber, " &_
      "tblInvoice.InvoiceNetAmount, " &_
      "tblChild.ParentCode, " &_
      "tblChild.Childcode " &_
      "FROM tblInvoice INNER JOIN tblChild ON tblInvoice.ChildCode = tblChild.Childcode "

    ' Caution watch order, this addition changes the from clause
    if (parentCode <> "") Then
      parentCode = Replace(parentCode,"*","%")

      if (strWhere = "") Then
        strWhere = ",tblParent WHERE tblInvoice.ChildCode=tblParent.ParentCode AND tblParent.Surname Like '" & parentCode & "'"
      end if
    end if

    if (current <> "") Then
      if (strWhere = "") Then
        strWhere = " WHERE tblInvoice.CurrentPeriod = " & current 
      else
        strWhere = strWhere & " AND tblInvoice.CurrentPeriod = " & current 
      end if 
    End if
    
    if (maxInvoice <> "") Then
      if (strWhere = "") Then
        strWhere = " WHERE tblInvoice.InvoiceNumber < '" & maxInvoice & "'"
      else
        strWhere = strWhere & " AND tblInvoice.InvoiceNumber < '" & maxInvoice & "'"
      end if 
    end if

   
    if (minInvoice <> "") Then
      if (strWhere = "") Then
        strWhere = " WHERE tblInvoice.InvoiceNumber >'" & minInvoice & "'"
      else
        strWhere = strWhere & " AND tblInvoice.InvoiceNumber >'" & minInvoice & "'"
      end if
    end if

    strGetInvoiceSQL = strGetInvoiceSQL &  strWhere

    createInvoiceListSQL = strGetInvoiceSQL
end function
 
%>
</BODY>
</HTML>
<!--  #include file = "common-client.asp" -->
