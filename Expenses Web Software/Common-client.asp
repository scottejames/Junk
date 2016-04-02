
<script language="VBScript">

'--------------------------------------------------------------------------------------
' loadHTTP
'  loads the XML data from a URL, NOTE GET method.
'--------------------------------------------------------------------------------------

Function loadHTTP(fileXML)
  loadHTTP=loadHTTPByMethod(fileXML,"GET")
end function

Function putHTTP(fileXML)
  putHTTP=loadHTTPByMethod(fileXML,"POST")
end function

Function loadHTTPByMethod(fileXML,strMethod)

  dim objHttp

  ' Load the XML from the prescribed URL
  set  objHttp = createobject("Microsoft.XMLHTTP")

  Call objHttp.open(strMethod, fileXML, false)
  Call objHttp.send

  loadHTTPByMethod=objHttp.responseText

  set  objHttp = Nothing
end function

Function addToURL (strURL,strVar,strValue,boolQuote)
   
  if (strURL = "") Then
    if boolQuote= "True" Then
      strURL = "?" + strVar + "='" + strValue + "'"
    else
      strURL = "?" + strVar + "=" + strValue 
    end if
  else
    if boolQuote= "True" Then
      strURL = strURL + "&" + strVar + "='" + strValue + "'"
    else
      strURL = strURL + "&" + strVar + "=" + strValue
    end if
  end if
  
  addToURL = strURL
end function
'--------------------------------------------------------------------------------------
' RenderXML
'  Takes an XML string and an XSL, renders the XML into a string
'--------------------------------------------------------------------------------------
Function RenderXML(fileXML,fileXSL)

  Dim strXMLData
  Dim strXSLData
  Dim strResults 

  strXMLData = loadHTTP(fileXML)
  
  Dim objXmlData
  set objXmlData = createobject("Microsoft.FreeThreadedXMLDOM")

  objXmlData.async = false
  objXmlData.loadXML(strXMLData)

  Call WriteLogMessage("XML", strXMLData)
  ' Check that the XML was parsed correctly
  if (objXmlData.parseError <> 0) then          
    strResults = "XML Error... <br>" &_
                 "Reason:"           & objXmlData.parseError.reason & "<br>" &_
                 "FIleName:"         & fileXML                   & "<br>" &_
                 "XML: <BR><PRE>"    & strXMLData                & "</PRE>"

    status     = "XML Error!" 

    RenderXML  = strResults
    Set objXmlData = Nothing
    Exit Function
  End If

  strXSLData = loadHTTP(fileXSL)

  Dim objXslData
  set objXslData = createobject("Microsoft.FreeThreadedXMLDOM")

  objXslData.async = false
  objXslData.setProperty "ServerHTTPRequest", False
  objXslData.loadXML(strXSLData)
  Call WriteLogMessage("XSL", strXSLData)
  if (objXslData.parseError <> 0) then          
    strResults = "XSL Error... <br>" &_
                 "Reason:"           & objXslData.parseError.reason & "<br>" &_
                 "FIleName:"         & fileXSL                      & "<br>" &_
                 "XSL: <BR><PRE>"    & strXSLData                   & "</PRE>"

    status     = "XSL Error!" 

    RenderXML  = strResults

    Set objXslData = Nothing
    Set objXmlData = Nothing

    Exit Function
  End If

  strResults = objXmlData.transformNode(objXslData)
  RenderXML  = strResults

  Call WriteLogMessage("TRANSFORM", strResults)
  set xmlData    = Nothing
  set xslData    = Nothing

End Function

Function writeLogMessage(strLogMsg,strLogEntry)

'  Set ScriptObject = CreateObject("Scripting.FileSystemObject")
'  Set MyFile = ScriptObject.OpenTextFile("c:\temp\myfile.txt", 8,true)
'  
'  MyFile.WriteLine Now & ":" & strLogMsg
'  MyFile.WriteLine strLogEntry
'  MyFile.WriteLine ""
'  MyFile.Close
  
end function

sub NewWindow(URL, width, height)
  dim varOptions, top, left

  varOptions = "location=no, status=yes, resizable=yes, scrollbars=yes"

  if (len(trim(width)) > 0) then
      varOptions = varOptions & ", width=" & width
      left = 500 - width/2
      if left < 0 then
        left = 0
      end if
       varOptions = varOptions & ", left=" & left
  end if
  if (len(trim(height)) > 0) then
       varOptions = varOptions & ", height=" & height
       top = 500 - height
       if top < 0 then
           top = 0
       end if
       varOptions = varOptions & ", top=" & top
  end if
   'alert varOptions
  call window.open(URL, "", varOptions)
end sub

'   retVal = makeMsgBox("Hi","how are you?",32,1,256,4096); 
'    
'    You can change the numbers to create alerts, confirms or any type of popup using the numbers / arguments below. 
'    
'    The alert and confirm boxes take 4 arguments
'    
'    Argument one : The Icon         0  = none
'                                    16 = X 
'                                    32 = ? 
'                                    48 = ! 
'                                    64 = i 
'    
'    Argument two : The buttons      0 = OK   # standard alert
'                                    1 = OK CANCEL
'                                    2 = ABORT RETRY IGNORE
'                                    3 = YES NO CANCEL
'                                    4 = YES NO
'                                    5 = RETRY CANCEL 
'    
'    Argument three :                0    = First
'    In your popup, which            256  = Second
'    button should be selected       512  = Thrid
'    by default?
'    
'    Argument four :                 0    = Browser stalls
'    The system command will         4096 = All apps stall
'  stall either the browser 
'  or the whole system until 
'  the user responds 
'  (either submits or cancels)
'  
'  
'   A value is returned 
'    depending on which button 
'    was pressed. So you could say 
'    
'    if(retVal == 3){do this} 
'    else {do this}
'    
'    Here are the return values      OK      = 1 
'                                    Cancel 	= 2 
'                                    Abort 	= 3 
'                                    Retry 	= 4 
'                                    Ignore 	= 5 
'                                    Yes     = 6 
'                                    No      = 7 
'    

 
Function makeMsgBox(tit,mess,icon,buts,defs,mode)
   butVal = icon + buts + defs + mode
   makeMsgBox = MsgBox(mess,butVal,tit)
End Function

Function makeInputBox(title,question,default_answer)
   makeInputBox = InputBox(title,question,default_answer)
End Function

</script>
