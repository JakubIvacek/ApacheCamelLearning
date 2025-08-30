# 🌡️ TempConverter v2 – Camel SOAP (Debugging & Fixes)

This directory is a **second variant** of the TempConverter project.  
It highlights how SOAP requests are handled in **Camel CXF with XSLT**, and also documents a mistake that was fixed in the XSLT templates.

---

## 🐞 Original Issue
In the first draft of the XSLT files, the `<xsl:template match>` was written as:

```xml
<xsl:template match="/ns:CelsiusToFahrenheit">
```
and
```xml
<xsl:template match="/w:FahrenheitToCelsius">
```

❌ This was wrong because SOAP messages are wrapped in an **Envelope** and **Body**.  
As a result, the templates would never match incoming requests.

---

## ✅ Fixed Version
The corrected XSLTs explicitly match the SOAP path, for example:

```xml
<xsl:template match="/soap:Envelope/soap:Body/ns:CelsiusToFahrenheit">
```
and

```xml
<xsl:template match="/soap:Envelope/soap:Body/ns:FahrenheitToCelsius">
```

This ensures Camel CXF can properly route and transform incoming SOAP messages.

Other fixes made:
- **Namespaces** unified (`ns` prefix used consistently for `https://www.w3schools.com/xml/`).
- **Content-Type** header corrected to `text/xml; charset=utf-8` instead of `text/html`.
- **File names** normalized (`fahrenheit` spelling fixed).

---

## 📂 Project Structure
```
.
├── celsiusToFaren.xslt          # Celsius → Fahrenheit transformation (SOAP-aware)
├── fahrenheitToCelsius.xslt     # Fahrenheit → Celsius transformation (SOAP-aware)
├── tempConvertFixed.camel.yaml  # Camel routes using CXF + XSLT (PAYLOAD)
└── README.md                    # This file
```

---

## ▶️ Running the Service
Start Camel with:
```bash
camel run tempConvertFixed.camel.yaml
```

The service listens at:
```
http://0.0.0.0:9999/convert
```

---

## 🧪 Testing

### Example Request (Celsius → Fahrenheit)
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns:CelsiusToFahrenheit xmlns:ns="https://www.w3schools.com/xml/">
      <ns:Celsius>25</ns:Celsius>
    </ns:CelsiusToFahrenheit>
  </soap:Body>
</soap:Envelope>
```

### Example Response
```xml
<ns:CelsiusToFahrenheitResponse xmlns:ns="https://www.w3schools.com/xml/">
  <ns:CelsiusToFahrenheitResult>77.0</ns:CelsiusToFahrenheitResult>
</ns:CelsiusToFahrenheitResponse>
```

---

## 🛠️ How It Works
1. SOAP request is received by Camel CXF at `/convert`
2. Camel inspects the payload:
   - If it contains **FahrenheitToCelsius**, the `fahrenheitToCelsius.xslt` is applied
   - Otherwise, the `celsiusToFaren.xslt` is applied
3. XSLT performs the temperature conversion and formats the SOAP response
4. Logs display both pre- and post-transformation bodies

---

## 📖 Notes
- This directory documents the **debugging process** and the **fixed XSLTs**.  
- The commented-out lines in the XSLT files show the *original mistake* for reference.  
- Always ensure your `<xsl:template match>` path matches the actual SOAP structure delivered by CXF.

---

## 📖 References
- [Apache Camel](https://camel.apache.org/)
- [Camel CXF Component](https://camel.apache.org/components/cxf-component.html)
- [W3Schools TempConvert SOAP Service](https://www.w3schools.com/xml/tempconvert.asmx)
