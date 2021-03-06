<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <body style="font-family:Arial, helvetica,
        sans-serif; font-size:12pt; background-color:white">
        <table BORDER = "1">
          <tr bgcolor="teal">
            <th><font color="white">Name</font></th>
            <th><font color="white">Balance</font></th>
            <th><font color="white">Notes</font></th>
          </tr>
          <xsl:for-each select="xml/RecordSet/row">
            <tr bgcolor="navy">
              <td>
                <xsl:attribute name="onclick"> 
                  renderParentDetails( "<xsl:value-of select="@id"/>")
                </xsl:attribute>
                <font color="white">
                  <xsl:value-of select="@title"/>. <xsl:value-of select="@initial"/>. <xsl:value-of select="@surname"/>
                </font>
              </td>
              <td>
                <xsl:attribute name="onclick"> 
                  renderParentDetails( "<xsl:value-of select="@id"/>")
                </xsl:attribute>
                <font color="white">
                  <xsl:value-of select="@balance"/>
                </font>
              </td>
              <td>
                <xsl:attribute name="onclick"> 
                  renderParentDetails( "<xsl:value-of select="@id"/>")
                </xsl:attribute>
                <font color="white">
                  <xsl:value-of select="@notes"/>
                </font>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

