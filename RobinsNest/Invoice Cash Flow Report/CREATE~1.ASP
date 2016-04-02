<%  @  Language = vbscript  %>
<%
Option Explicit
Response.Buffer = True

Private Sub SQLExec(byVal sql)
	dim c 
  dim strConn
  strConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=e:\rnest\accounts.mdb"

	set c = server.createobject("adodb.connection")
  With c
    .ConnectionString = strConn
    .CursorLocation = adUseClient ' use client side cursors
    .Open
  End With
	c.Execute sql
	c.Close 
	set c = Nothing
	Response.Write "<h1><big>PROCEDURE ADDED!</big></h1>"
End Sub


dim tmp  :  tmp = Request.Form("SQL")
If  left( ucase( trim( tmp ) ), 16 ) = "CREATE PROCEDURE" OR _
    left( ucase( trim( tmp ) ), 14 ) = "DROP PROCEDURE" Then
	Call SQLExec( trim( tmp ) )
Else
	%>
	<FORM ACTION="./createsp.asp" METHOD=POST>
	<INPUT TYPE=SUBMIT VALUE="Add Procedure"><BR><BR>
	<TEXTAREA NAME="SQL" COLS=65 ROWS=45></TEXTAREA><BR><BR>
	<INPUT TYPE=SUBMIT VALUE="Add Procedure"></FORM>
	<%
End If
%>

