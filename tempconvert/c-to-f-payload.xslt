<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:ns="https://www.w3schools.com/xml/"
  exclude-result-prefixes="xsl soap ns">

  <xsl:output method="xml" indent="yes"/>

  
  <xsl:template match="/">
    <result>
    <ns:CelsiusToFahrenheitResponse>
          <ns:CelsiusToFahrenheitResult>
            <xsl:call-template name="convertTemp"/>
          </ns:CelsiusToFahrenheitResult>
    </ns:CelsiusToFahrenheitResponse>
    </result>

  </xsl:template>

  
  <xsl:template name="convertTemp">
    <xsl:variable name="c" select="//ns:Celsius"/>
    <xsl:variable name="f" select="($c * 9 div 5) + 32"/>
    <xsl:value-of select="format-number($f, '0.0')"/>
  </xsl:template>

</xsl:stylesheet>
