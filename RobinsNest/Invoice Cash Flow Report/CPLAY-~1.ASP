

<!--  #include file = "common.asp" -->
<!--  #include file = "common-client.asp" -->
<HTML>
<HEAD>
</HEAD>
<BODY>
 <h1> Parent Merge Tool </h1>
 <P>
 The following tool loads new parents into the invoice system.  It does NOT allow duplicates to be loaded, once a change has 
 been made one one system such a change will NOT be reflected in the other.  These kind of changes should be performed by 
 hand.  Be aware this is an all or nothing job, the list of parents below consists of all parents that exist in childs play
 but who have not been moved to the invoice system.  Pressing the button will merge them all across.  This process will take 
 a few seconds so please be patient.
 </P>
<CENTER>
<TABLE BORDER=3>
<TR> <TD> Status: </TD> <TD> <Div id='tgtStatus'/> </TD> </TR>
<TR> <TD> Results: </TD> <TD> <Div id='tgtResults'/> </TD> </TR>
<TR> <TD> Errors: </TD> <TD> <Div id='tgtErrors'/> </TD> </TR>
</TABLE>

<%
  Dim strSQLGetSummary
  Dim rsGetSummary
  Dim rsCheckDetails
  Dim strSource
  Dim strStatus
  Dim xml
  Dim iCount

  iCount = 1
  ' Possible trade status

  
  Response.Write("<P><INPUT type=button onClick='processUpdate()' value='Load New Parents Into System'><P>")
  Response.Write("<TABLE BORDER=3 id='udte'>") 
  Response.Write("<TR><TH Name='HEADING'> CODE </TH><TH Name='HEADING'> NAME </TH></TR>") 


  ' Get a list of all parents 
  strSQL = "SELECT ParentCode,Title,Initial,Surname FROM tblParent"
  Set rsGetSummary= SQLQuery("cplay",strSQL)

  Do While Not (rsGetSummary.EOF)
    ' For each parents look to see if it has already been merged
    checkSQL = "SELECT COUNT(*) As cnt FROM rnParentDetails where cplaycode ="
    set rsCheckDetails = SQLQuery("accounts",checkSQL & "'" & rsGetSummary("ParentCode") & "'")

    if (rsCheckDetails("cnt") = 0) Then ' need to merge
     Response.Write("<TR>" &_
                     "<TD name= 'CODE'>" & rsGetSummary("ParentCode") &"</TD>" &_
                     "<TD name= 'NAME'>" & rsGetSummary("Title") &"," & rsGetSummary("Initial") & "," & rsGetSummary("Surname") & "</TD>" &_ 
                     "</TR>")
    end if
    rsCheckDetails.close
    Set rsCheckDetails = Nothing 

    rsGetSummary.MoveNext
  Loop
  Response.Write("</TABLE>" & vbCrlf) 
%>
</CENTER>
</BODY>
</HTML>

<script language="VBScript">
tgtStatus.innerText = "Waiting for instructions"

function processUpdate()
  ' Find table and retrieve contents
  tgtStatus.innerText = "Processing Instructions"

  Dim objRow
  Dim objCell
  Dim strCode
  Dim strName
  Dim strResults
  For Each objRow In Document.all.udte.rows
    For Each objCell In objRow.cells
      if (objCell.name="CODE") Then
        strCode = objCell.innerText
        strName = ""
      end if
      if (objCell.name="NAME") Then
        strName = objCell.innerText
      end if

      if ((strCode <> "") AND (strName <> "")) Then
        ' Update parent
        Dim data
        data = Split(strName,",")
        

        strURL = "ins-upd-parent.asp?" &_
                            "title=" & data(0) &_
                            "&initial=" & data(1) &_
                            "&surname=" & data(2) &_
                            "&notes=" & "Updated from CP" &_
                            "&code=" & strCode
        strResults = loadHTTP(strURL)

        if (strResults="") Then 
          tgtResults.innerText = tgtResults.innerText & vbCrlf & "Processing parent: " & strName
        else
          tgtResults.innerText = tgtResults.innerText & vbCrlf & "FAILED Processing parent: " & strName
          tgtErrors.innerHTML = tgtErrors.innerHTML & vbCrlf & "<HR>" & strResults 
        end if

        ' Log errors like a mofo *SJ*
      end if
    Next
  Next
  tgtStatus.innerText = "Processing Complete"
end function
</script>
