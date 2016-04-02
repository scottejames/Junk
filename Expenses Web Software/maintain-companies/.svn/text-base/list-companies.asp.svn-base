

<!--  #include file = "../common.asp" -->
<!--  #include file = "../common-client.asp" -->

<HTML>
<LINK href="../style.css" rel=stylesheet type=text/css>
  <HEAD>
  </HEAD>
  <BODY>
    <h1> Companies List </H1>
    <TABLE>
    <TR>
      <TD>
        <INPUT type="Button" onclick="processNew" value="NEW COMPANY"> </INPUT>
      </TD>
      <TD>
        <INPUT type="Button" onclick="processEditCatagories" value="EDIT CATAGORIES"> </INPUT>
      </TD>
      <TD>
        Filter by catagory
      </TD>
      <TD>
        <DIV id='tgtSelect'></DiV>

      </TD>
    </TR>
    </TABLE>

    <DIV id="xslTarget"></DIV> 

  </BODY>
</HTML>

<SCRIPT language=VBScript>

renderTable

Dim strSelect
strSelect = RenderXML ("../maintain-catagories/getCatagoryListXML.asp" , "../maintain-catagories/getCatagoryListAsSelectXSL.xsl")
tgtSelect.innerHTML = "<SELECT onchange='onFilter' name='filter'><OPTION value='all'>All</OPTION>" & strSelect & "</SELECT>"

Dim strFilter
Dim strOrder


function renderTable	
  Dim strHTML

  Dim strURL
  if (strFilter = "") Then
    strFilter = "all"
  end if

  strURL = addToURL(strURL,"reqFILTER",strFilter,"False")
  if (strOrder <> "") Then
    strURL = addToURL(strURL,"reqORDER",strOrder,"False")
  end if
  strHTML = RenderXML ("getCompanyListXML.asp" & strURL ,"getCompanyListXSL.xsl")
  xslTarget.innerHTML = strHTML


end function

function processShow(strId)
  Call NewWindow("maintain-companies.asp?reqREQUEST=Show&reqID=" & strId,700,500)
end function


function processEditCatagories
  Call NewWindow("../maintain-catagories/maintain-catagories.asp",700,500)
end function

function processNew()
  Call NewWindow("maintain-companies.asp?reqREQUEST=New",700,500)
end function

function sortBy(strValue)
  Dim strHTML 
  strOrder = strValue
  Call renderTable
end function

function onFilter
  Dim strIndex  
  
  strIndex = Document.all.filter.selectedIndex
  strFilter = Document.all.filter(strIndex).value

  Call renderTable	
end function
</SCRIPT>
