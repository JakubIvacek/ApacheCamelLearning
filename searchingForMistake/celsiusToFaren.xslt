<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:ns="https://www.w3schools.com/xml/"
  exclude-result-prefixes="soap w">

  <xsl:output method="xml" indent="yes"/>

  <!-- Match the root -->
  <!-- <xsl:template match="/soap:Envelope/soap:Body/ns:CelsiusToFahrenheit> -->
  <xsl:template match="/ns:CelsiusToFahrenheit">
  <ns:CelsiusToFahrenheitResponse>
      <xsl:variable name="celsius" select="ns:Celsius"/>
      <ns:CelsiusToFahrenheitResult>
        <xsl:value-of select="$celsius * 1.8 + 32"/>
      </ns:CelsiusToFahrenheitResult>
    </ns:CelsiusToFahrenheitResponse>
  <!--  <result>
      <xsl:variable name="celsius" select="ns:Celsius"/>
      <cToFahrenheit>
        <CelsiusFromInput>
          <xsl:value-of select="$celsius"/>
        </CelsiusFromInput>
        <FAREN>
          <xsl:value-of select="$celsius * 1.8 + 32"/>
        </FAREN>
      </cToFahrenheit>
    </result>-->
  </xsl:template>

</xsl:stylesheet>
