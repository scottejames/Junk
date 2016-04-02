
<!--  #include file = "common.asp" -->

<%
  Dim strExtRef
  Dim strDate
  strDate = Date & " " & Time

  strExtRef = Request("extref")
  
  if (strExtRef = "") Then
    Response.Write("<B> No extref specified </B>")
    Response.End
  end if
  
  ' Merge transaction group

  Dim strSQL
  Dim lngRowsUpdated
  Dim rsResults

  strSQL="INSERT into rnTransactionGrouping (notes,extref) " &_
         "VALUES ('Cplay import'," & strExtRef & ")"

  lngRowsUpdated = SQLUpdate("accounts",strSQL)
  insertTG = lngRowsUpdated  

  if (lngRowsUpdated <> 1) Then
    Response.Write("<B> Unable to insert transaction group</B>")
    Response.End
  end if
  ' Merge invoice 
  strSQL = "EXECUTE sp_getInvoiceDetails" & strExtRef
  Set rsResults = SQLQuery("accounts",strSQL)

  while Not (rsResults.EOF)
    Dim strTGID,strNet,strNarrative,strParentCode
    strTGID = rsResults("rnTransactionGrouping.id")
    strNet  = rsResults("NET")
    strNarrative = rsResults("Narrative")
    strParentCode = rsResults("rnParentDetails.id")
    if (CDbl(strNet) < 0) Then
      strType = "REFUND"
    else
      strType = "INVOICE"
    end if

    strNet = Abs(CDbl(strNet)) * -1 
    strSQL = "INSERT into rnTransactionDetail (type,entrydate,amount,notes,rnParentDetails,rnTransactionGroup) " &_
             "VALUES ('" & strType & "','" & strDate & "','" & strNet & "','" & strNarrative & "','" &_
                      strParentCode & "','" & strTGID & "')"
    
    lngRowsUpdated = SQLUpdate("accounts",strSQL)
    insertTG = lngRowsUpdated  

    if (lngRowsUpdated <> 1) Then
      Response.Write("<B> Unable to insert transaction group</B>")
      Response.End
    end if

    rsResults.moveNext
  wend 

%>

