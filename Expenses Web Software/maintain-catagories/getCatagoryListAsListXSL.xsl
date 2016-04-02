
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
  <TABLE border="0">
    <xsl:for-each select="xml/RecordSet/row">
     <TR>
       <TD>
        <xsl:value-of select="@name"/>
        </TD>
        </TR>
    </xsl:for-each>
    </TABLE>
  </xsl:template>

</xsl:stylesheet>

