
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:w="https://www.w3schools.com/xml/"
  exclude-result-prefixes="soap w">

  <xsl:output method="xml" indent="yes"/>

  <!-- Match the FahrenheitToCelsius request inside the SOAP body -->
  <!--<xsl:template match="/soap:Envelope/soap:Body/w:FahrenheitToCelsius"> -->
  
  <xsl:template match="/w:FahrenheitToCelsius">
    <w:FahrenheitToCelsiusResponse>
      <xsl:variable name="fahrenheit" select="w:Fahrenheit"/>
        <w:FahrenheitToCelsiusResult>
          <xsl:value-of select="($fahrenheit - 32) div 1.8"/>
        </w:FahrenheitToCelsiusResult>
    </w:FahrenheitToCelsiusResponse>

    <!--<result>
      <xsl:variable name="fahrenheit" select="w:Fahrenheit"/>
      <fToCelsius>
        <FarenFromInput>
            <xsl:value-of select="$fahrenheit"/>
        </FarenFromInput>
        <CELSIUS>
            <xsl:value-of select="($fahrenheit - 32) div 1.8"/>
        </CELSIUS>
      </fToCelsius>
    </result> -->
  </xsl:template>

</xsl:stylesheet>