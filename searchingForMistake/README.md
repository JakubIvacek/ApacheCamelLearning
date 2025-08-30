# 🔹 searchingForMistake/

This directory contains an **exercise** about identifying and fixing a mistake in Apache Camel routes when switching message modes.

## 📌 Problem Description

- A mistake occurred after switching from **RAW** to **PAYLOAD** mode in Camel CXF routes.  
- In **PAYLOAD** mode, Camel tries to **recreate the SOAP response** based on the **WSDL file**.  
- The issue was that the **XSLT transformation schema did not match** the expected WSDL contract, so the SOAP response could not be properly created.  

---

## ❌ Mistake

- The original XSLT templates tried to match SOAP structures incorrectly.  
- Example (wrong template match, commented out in the files):
  ```xml
  <!-- <xsl:template match="/soap:Envelope/soap:Body/ns:CelsiusToFahrenheit"> -->
  ```
- Since PAYLOAD mode removes the outer SOAP envelope and works only with the body payload, this path no longer matched.

---

## ✅ Solution

- Update the XSLT templates to **match directly on the body operation element** (without SOAP envelope).  
- Example (fixed template in `celsiusToFAren.xslt`):
  ```xml
  <xsl:template match="/ns:CelsiusToFahrenheit">
  ```
- Similarly in `farenheitToCelsius.xslt`:
  ```xml
  <xsl:template match="/w:FahrenheitToCelsius">
  ```

- If the XSLT schema changes, make sure your **XSLT templates follow the correct XML schema** from the WSDL.  
- The **old schema versions** are left commented out in the files for reference.

---

## 📂 Files

- `application.properties` → defines Camel dependencies (CXF HTTP transport)  
- `myConverter.camel.yaml` → Camel route definition handling conversion requests  
- `celsiusToFAren.xslt` → XSLT for converting Celsius → Fahrenheit  
- `farenheitToCelsius.xslt` → XSLT for converting Fahrenheit → Celsius  

---

## 🚀 How to Run

1. Make sure you have **Camel JBang** installed.  
2. Run with the provided properties:  
   ```sh
   camel run myConverter.camel.yaml --property-file=application.properties
   ```
3. Send SOAP requests to the service, e.g. `CelsiusToFahrenheit` or `FahrenheitToCelsius`.  

---

👉 See also: [v2 README](./searchingForMistake/README.md) for more details.  
