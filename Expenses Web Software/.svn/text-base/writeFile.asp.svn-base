<%
	Response.ContentType = "text/html"
%>
<!--  #include file = "common.asp" -->

<%

  Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
  Set MyFile = ScriptObject.OpenTextFile("c:\temp\myfile.txt", 8,true)
  
  MyFile.WriteLine Now & ": " & Request("LOGMESSAGE")
  MyFile.Write Request("SUBSTANCE")
  MyFile.WriteLine ""
  MyFile.Close
  
%>
