

<!--  #include file = "common.asp" -->

<%
  Dim rsGetSummary
  Dim xml

  Dim strPid
  Dim strTitle
  Dim strInitial
  Dim strSurname
  Dim strNotes
  Dim strCPCode
  
  strPid     = Request("pid")
  strTitle   = Request("title")
  strInitial = Request("initial")
  strSurname = Request("surname")
  strNotes   = Request("notes")
  strCPCode  = Request("code")
  strDeleted  = Request("deleted")

  'validate results
  if ((strDeleted <> "NO") And _
      (strDeleted <> "YES") And _
      (strDeleted <> "")) Then
    Response.Write("<B>Deleted must be one of YES or NO not " & strDeleted & " </B>")
    Response.End
  end if
 
  If (strTitle = "") Then
    Response.Write("<B>Title must be specified </B>")
    Response.End
  end if
  If (strInitial = "") Then
    Response.Write("<B>Initial must be specified </B>")
    Response.End
  end if
  If (strSurname = "") Then
    Response.Write("<B>Surname must be specified </B>")
    Response.End
  end if
  ' normalise results
 
  if ((strDeleted = "NO") Or _
      (strDeleted = "")) Then
    strDeleted = 0
  end if

  if (strDeleted = "YES") Then
    strDeleted = -1
  end if
  
  If (strNotes = "") Then
    strNotes = "-"
  end if

  if (strPid = "") Then ' New record
    Dim strDate
    strSQL= "INSERT INTO rnParentDetails (title,initial,surname,notes,balance,cplaycode)" &_
            " VALUES ('" & strTitle & "','" & strInitial & "','" & strSurname & "','" & strNotes & "',0,'" & strCPCode & "')"
    Call SQLQuery("accounts",strSQL)
  Else ' Update

    strSQL= "UPDATE rnParentDetails SET " &_
            " title      = '" & strTitle   & "'" &_
            ", initial   = '" & strInitial & "'" &_
            ", surname   = '" & strSurname & "'" &_
            ", notes     = '" & strNotes   & "'" &_
            ", deleted   = '" & strDeleted  & "'" &_
            " WHERE id   =  " & strPid
    Call SQLQuery("accounts",strSQL)
  End if

  Set rsGetSummary = Nothing
%>
