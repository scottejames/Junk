
<!--  #include file = "../common.asp" -->
<!--  #include file = "../common-client.asp" -->

<HTML>
  <HEAD>
  </HEAD>
  <BODY>
    <h1> Maintain Catatories List </H1>
    <DIV id="xslTarget"></DIV> 

    <DIV id="tgtResults"></DIV> 
  </BODY>
</HTML>

<SCRIPT language=VBScript>

renderTable

function renderTable
  Dim strHTML
  strHTML = RenderXML ("getCatagoryListXML.asp" ,"getCatagoryListXSL.xsl")
  xslTarget.innerHTML = strHTML
end function

function processEdit(strId,strName,strDescription)
  Document.frmCatagory.frmName.value = strName
  Document.frmCatagory.frmDescription.value = strDescription
  Document.frmCatagory.frmId.value = strId
  tgtResults.innerHTML = ""
end function

function processDelete(strId)

  retVal = makeMsgBox("Confirm","Are you sure you want to delete this?",32,1,256,4096)
  if (retVal = 1) Then
    Dim strURL
    
    strURL = ""

    strURL = addToURL(strURL,"reqREQUEST","DELETE","False")
    strURL = addToURL(strURL,"reqID",strId,"False")
    tgtResults.innerHTML = putHTTP("insUpdCatagory.asp" & strURL) 
    
    renderTable
  end if
end function

function ClearForm
  Document.frmCatagory.frmName.value = ""
  Document.frmCatagory.frmDescription.value = ""
  Document.frmCatagory.frmId.value = ""
  tgtResults.innerHTML = ""
end function

function InsertUpdateCatagory

  Dim strId
  Dim strName
  Dim strDescription

  strName = Document.frmCatagory.frmName.value 
  strDescription = Document.frmCatagory.frmDescription.value 
  strId = Document.frmCatagory.frmId.value 
  
  Dim strURL
  
  strURL = ""

  if (strId="") Then
    strURL = addToURL(strURL,"reqREQUEST","INSERT","False")
  Else
    strURL = addToURL(strURL,"reqREQUEST","UPDATE","False")
    strURL = addToURL(strURL,"reqID",strId,"False")
  End if
  
  strURL = addToURL(strURL,"reqNAME",strName,"True")
  strURL = addToURL(strURL,"reqDESCRIPTION",strDescription,"True")
  tgtResults.innerHTML = putHTTP("insUpdCatagory.asp" & strURL) 
  
  renderTable
end function

</SCRIPT>
