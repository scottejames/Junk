<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <h2> Position overview </h2>
      <body style="font-family:Arial, helvetica,
        sans-serif; font-size:12pt; background-color:white">
        <TABLE>
          <xsl:for-each select="xml/RecordSet/row">
            <xsl:if test="position() = 1">
              <TR> 
                <TD><b> Parent Name: </b></TD>
                <TD> 
                  <xsl:value-of select="@initial"/>,<xsl:value-of select="@surname"/> 
                </TD>
              </TR>
              <TR> 
                <TD> <b>Current Balance:</b> </TD>
               <TD> <xsl:value-of select="@balance"/></TD>
              </TR>
            </xsl:if>
          </xsl:for-each>
        </TABLE>
        <TABLE border="1">
          <TR BGCOLOR="Teal">
            <TH> <font COLOR="White">Date </font></TH>
            <TH> <font COLOR="White">Type </font></TH>
            <TH> <font COLOR="White">Amount </font></TH>
            <TH> <font COLOR="White">Notes </font></TH>
          </TR>
          <xsl:for-each select="xml/RecordSet/row">
            <xsl:variable name="bgcolor"> 
              <xsl:choose>
                <xsl:when test="@type='INVOICE'">blue</xsl:when>
                <xsl:otherwise>navy</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <tr >
              <xsl:attribute name="bgcolor"><xsl:value-of select="$bgcolor"/></xsl:attribute>
              <td>
                <xsl:attribute name="onclick"> 
                  publishTransactionForm(
                  "<xsl:value-of select="@rnTransactionDetail.id"/>",
                  "<xsl:value-of select="@rnParentDetails.id"/>",
                  "<xsl:value-of select="@entrydate"/>",
                  "<xsl:value-of select="@type"/>",
                  "<xsl:value-of select="@amount"/>",
                  "<xsl:value-of select="@notes"/>")
                </xsl:attribute>
                <font COLOR="WHITE">
                  <xsl:value-of select="@entrydate"/> 
                </font>
              </td>
              <td>
                <xsl:attribute name="onclick"> 
                  publishTransactionForm(
                  "<xsl:value-of select="@rnTransactionDetail.id"/>",
                  "<xsl:value-of select="@rnParentDetails.id"/>",
                  "<xsl:value-of select="@entrydate"/>",
                  "<xsl:value-of select="@type"/>",
                  "<xsl:value-of select="@amount"/>",
                  "<xsl:value-of select="@notes"/>")
                </xsl:attribute>
                <font COLOR="WHITE">
                  <xsl:value-of select="@type"/> 
                </font>
              </td>
              <td>
                <xsl:attribute name="onclick"> 
                  publishTransactionForm(
                  "<xsl:value-of select="@rnTransactionDetail.id"/>",
                  "<xsl:value-of select="@rnParentDetails.id"/>",
                  "<xsl:value-of select="@entrydate"/>",
                  "<xsl:value-of select="@type"/>",
                  "<xsl:value-of select="@amount"/>",
                  "<xsl:value-of select="@notes"/>")
                </xsl:attribute>
                <font COLOR="WHITE">
                  <xsl:value-of select="@amount"/> 
                </font>
              </td>
              <td>
                <xsl:attribute name="onclick"> 
                  publishTransactionForm(
                  "<xsl:value-of select="@rnTransactionDetail.id"/>",
                  "<xsl:value-of select="@rnParentDetails.id"/>",
                  "<xsl:value-of select="@entrydate"/>",
                  "<xsl:value-of select="@type"/>",
                  "<xsl:value-of select="@amount"/>",
                  "<xsl:value-of select="@notes"/>")
                </xsl:attribute>
                <font COLOR="WHITE">
                  <xsl:value-of select="@notes"/> 
                </font>
              </td>
            </tr>
          </xsl:for-each>
        </TABLE>
      </body>
    </html>
    <script language="VBScript">
    </script>
  </xsl:template>
</xsl:stylesheet>


