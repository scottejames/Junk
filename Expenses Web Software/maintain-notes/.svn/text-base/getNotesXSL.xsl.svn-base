
<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <body style="font-family:Arial, helvetica,
        sans-serif; font-size:12pt; background-color:white">

        <table BORDER = "1">
          <tr bgcolor="black">
            <th><font size="-1" color="white">Date</font></th>
            <th><font size="-1" color="white">Note</font></th>
            <th>-</th>
          </tr>
          <xsl:for-each select="xml/RecordSet/row">
            <tr bgcolor="white">
              <td>
                <font size="-1" color="black">
                  <xsl:value-of select="@entrydate"/>
                </font>
              </td>
              <td>
                <font size="-1" color="black">
                  <xsl:value-of select="@notes"/>
                </font>
              </td>
              <td>
                <input type='button' value='edit' language="VBScript">
                <xsl:attribute name="onclick"> 
                  processNoteEdit '<xsl:value-of select="@id"/>','<xsl:value-of select="@entrydate"/>','<xsl:value-of select="@notes"/>'
                </xsl:attribute>
                </input>
                <input type='button' value='delete'>
                <xsl:attribute name="onclick"> 
                  processNoteDelete( '<xsl:value-of select="@id"/>')
                </xsl:attribute>
                </input>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

