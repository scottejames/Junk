
<!--  #include file = "common.asp" -->

<%

  Dim rsGetSummary
  Dim xml

  Dim strPid
  Dim strDate
  Dim strUpdateDate
  Dim strType
  Dim strAmount
  Dim strNotes
  Dim strBalance

  strPid = Request("pid")
  strid = Request("id")
  strDate = Request("date")
  strType = Request("type")
  strAmount = Request("amount")
  strNotes = Request("note")
  strExtRef = Request("extref")
  
  if (strNotes = "") Then
    strNotes = "-"
  end if

  if (strExtRef = "") Then
    strExtRef = "-"
  end if
  
  ' Validate Arguments
  if (strAmount = "") Then
    Response.Write("<B> Amount must be specified </B>")
    Response.End
  End If

  If (NOT IsNumeric(strAmount)) Then
    Response.Write("<B> Amount must me a numeric field NOT " & strAmount & " </B>")
    Response.End
  end if

  if (strType = "" ) Then
    Response.Write("<B> TYPE must be not be empty</B>")
    Response.End
  End If

  if (NOT IsDate(strDate)) Then
    Response.Write("<B> Date must be in the form of a date NOT " & strDate & " </B>")
    Response.End
  end if
  ' Normalise values

  If (strType = "INVOICE")  Then
    strAmount = Abs(CDbl(strAmount)) * -1
  else
    strAmount = Abs(CDbl(strAmount)) 
  end if
  strUpdateDate = Date
  if (strid = "") Then ' New record
    if (strPid = "") Then
      Response.Write("<B> ParentID must be not be empty</B>")
      Response.End
    End If
    Call SQLQuery("accounts","INSERT INTO rnTransactionDetail (entrydate,type,amount,notes,rnParentDetails)" &_
       " VALUES ('" & strDate & "','" & strType & "'," & strAmount & ",'" & strNotes & "','" & strPid & "')")
  Else ' Update
    Call SQLQuery("accounts","UPDATE rnTransactionDetail SET " &_
                              "amount=" & strAmount &_
                              ", notes='" & strNotes & "'" &_
                              ", type='" & strType & "'" &_
                              " WHERE id =" & strid)
  End if

%>
