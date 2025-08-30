<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:ns="https://www.w3schools.com/xml/"
  exclude-result-prefixes="xsl soap ns">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <ns:FahrenheitToCelsiusResponse>
          <ns:FahrenheitToCelsiusResult>
            <xsl:call-template name="convertTemp"/>
          </ns:FahrenheitToCelsiusResult>
    </ns:FahrenheitToCelsiusResponse>
  </xsl:template>

  <xsl:template name="convertTemp">
    <xsl:variable name="f" select="//ns:Fahrenheit"/>
    <xsl:variable name="c" select="($f - 32) * 5 div 9"/>
    <xsl:value-of select="format-number($c, '0.0')"/>
  </xsl:template>

</xsl:stylesheet>
