
<script language="VBScript">

'--------------------------------------------------------------------------------------
' loadHTTP
'  loads the XML data from a URL
'--------------------------------------------------------------------------------------

Function loadHTTP(fileXML)
  dim xmlDoc
  dim xmlHttp

  On Error Resume Next

  dim strDate
  
  ' Load the XML from the prescribed URL
  set  xmlHttp = createobject("Microsoft.XMLHTTP")
  Call xmlHttp.open("GET", fileXML, false)

  Do while (Err.Number <> 0) 
    Err.Number = 0
    set xmlHttp = Nothing 
    set  xmlHttp = createobject("Microsoft.XMLHTTP")
    Call xmlHttp.open("GET", fileXML, false)
  Loop
  Call xmlHttp.send
  loadHTTP=xmlHttp.responseText
  set  xmlHttp = Nothing
  
end function

'--------------------------------------------------------------------------------------
' RenderXML
'  Takes an XML string and an XSL, renders the XML into a string
'--------------------------------------------------------------------------------------
Function RenderXML(fileXML,fileXSL)

  Dim strXMLData
  Dim strXSLData
  
  strXMLData = loadHTTP(fileXML)
  
  ' Parse the XML into a XMLDOM
  set xmlData = createobject("Microsoft.FreeThreadedXMLDOM")
  xmlData.async = false
  xmlData.loadXML(strXMLData)

  ' Check that the XML was parsed correctly
  if (xmlData.parseError <> 0) then          
    strResults = "XML Error... <br>" &_
                 "Reason:"  & xmlData.parseError.reason + "<br>" &_
                 "FIleName:"  & fileXML + "<br>" &_
                 "XML: <BR><PRE>" & strXMLData & "</PRE>"
    status = "XML Error!" 
    RenderXML  = strResults

    Set xmlData = Nothing
    Exit Function
  End If

  strXSLData = loadHTTP(fileXSL)
  set xslData = createobject("Microsoft.FreeThreadedXMLDOM")
  xslData.async = false

  xslData.setProperty "ServerHTTPRequest", False
  xslData.loadXML(strXSLData)
 
  if (xslData.parseError <> 0) then          
    strResults = "XSL Error...<br>" &_
                 "Reason:"  & xslData.parseError.reason + "<br>" &_
                 "FileName:"  & fileXML + "<br>" &_
                 "XSL: <BR><PRE>" & strXSLData & "</PRE>"

  status = "XSL Error!"  & xslData.parseError.reason
    RenderXML  = strResults
    Set xslData = Nothing
    Set xmlData = Nothing
    Set xmlHttp = Nothing
    Exit Function
  End If

  strResults = xmlData.transformNode(xslData)
  RenderXML  = strResults

  Set xmlHttp = Nothing
  set xmlData    = Nothing
  set xslData    = Nothing
End Function

</script>
