
<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <body style="font-family:Arial, helvetica,
        sans-serif; font-size:12pt; background-color:white">

        <table BORDER = "1">
          <tr bgcolor="black">
            <th>
              <xsl:attribute name="onclick"> sortBy('name') </xsl:attribute>
              <font color="white">Name</font>
            </th>
            <th>
              <font color="white">Address</font>
            </th>
            <th>
              <font color="white">Phone Number</font>
            </th>

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
                  <xsl:value-of select="@address"/>
                </font>
              </td>
              <td>
                <font color="black">
                  <xsl:value-of select="@phone"/>
                </font>
              </td>

              <TD>
                <input type='button' value='show' language="VBScript">
                  <xsl:attribute name="onclick"> 
                    processShow '<xsl:value-of select="@id"/>'
                  </xsl:attribute>
                </input>
              </TD>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

