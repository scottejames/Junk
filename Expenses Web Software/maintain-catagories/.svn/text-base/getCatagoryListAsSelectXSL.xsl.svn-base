
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <xsl:for-each select="xml/RecordSet/row">
      <option>
        <xsl:attribute name="value"> 
          <xsl:value-of select="@id"/>
        </xsl:attribute>
        <xsl:value-of select="@name"/>
      </option>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>

