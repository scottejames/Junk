
<!--  #include file = "common.asp" -->

<%

  localDebug = True
  Dim rsGetSummary
  Dim xml

  Dim strid
  Dim strExtRef
  Dim strNotes
  ' Calculated
  Dim strUpdateDate

  strid = Request("id")
  strNotes = Request("note")
  strExtRef = Request("extref")
  
  if (strNotes = "") Then
    strNotes = "-"
  end if

  if (strExtRef = "") Then
    strExtRef = "-"
  end if
  
  strUpdateDate = Date

  if (strid = "") Then ' New record
    Call SQLUpdate("accounts", _
                   "INSERT INTO rnTransactionGrouping " &_
                   "  (notes,updatedate,extref) " &_
                   " VALUES ('" & strNotes & "','" strUpdateDate & "','" & strExtRef & "')")
  Else ' Update
    Call SQLUpdate("accounts","UPDATE rnTransactionGrouping SET " &_
                              "notes='" & strNotes & "'" &_
                              ", updatedate ='" & strUpdateDate & "'" &_
                              ", extref='" & strExtRef & "'" &_
                              " WHERE id =" & strid)
  End if

  Set rsGetSummary = Nothing

%>
