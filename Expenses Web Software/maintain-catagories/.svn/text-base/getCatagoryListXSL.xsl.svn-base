
<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <body style="font-family:Arial, helvetica,
        sans-serif; font-size:12pt; background-color:white">

        <table BORDER = "1">
          <tr bgcolor="black">
            <th><font color="white">Name</font></th>
            <th><font color="white">Description</font></th>
            <th>_</th>
          </tr>
          <xsl:for-each select="xml/RecordSet/row">
            <tr bgcolor="white">
              <td>
                <font color="black">
                  <xsl:value-of select="@name"/>
                </font>
              </td>
              <td>
                <font color="black">
                  <xsl:value-of select="@description"/>
                </font>
              </td>
              <TD>
                <input type='button' value='edit' language="VBScript">
                <xsl:attribute name="onclick"> 
                  processEdit '<xsl:value-of select="@id"/>','<xsl:value-of select="@name"/>','<xsl:value-of select="@description"/>'
                </xsl:attribute>
                </input>
                <input type='button' value='delete'>
                <xsl:attribute name="onclick"> 
                  processDelete( '<xsl:value-of select="@id"/>')
                </xsl:attribute>
                </input>
              </TD>
            </tr>
          </xsl:for-each>
          <tr>
            <form name='frmCatagory' language="VBScript">
              <td><input type='hidden' name='frmId'> </input><input type='text' name='frmName' ></input> </td>
              <td><input type='text' name='frmDescription' ></input>   </td>
              <td> <input type='button' name='frmUpdate' onClick='InsertUpdateCatagory()' value='update'> </input> 
                   <input type='button' name='frmUpdate' onClick='ClearForm()' value='clear'> </input> </td>
            </form>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

