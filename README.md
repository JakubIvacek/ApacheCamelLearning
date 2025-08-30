# 🌡️ Apache Camel SOAP TempConverter – Root Project

This repository demonstrates how to build a **SOAP-based temperature converter** using **Apache Camel (with CXF)** and **XSLT transformations**.  
It contains two different directories, each showing a different approach and learning process.

---

## 📂 Repository Structure
```
.
├── v1-tempconverter/         # First implementation
│   ├── application.properties
│   ├── tempConvert.camel.yaml
│   ├── tempconvertD.camel.yaml
│   ├── c-to-f.xslt
│   ├── f-to-c.xslt
│   ├── c-to-f-payload.xslt
│   ├── f-to-c-payload.xslt
│   └── README.md              # Detailed docs for v1
│
├── v2-tempconverter-fixed/    # Second implementation with fixes
│   ├── celsiusToFaren.xslt
│   ├── fahrenheitToCelsius.xslt
│   ├── tempConvertFixed.camel.yaml
│   └── README.md              # Details mistakes + fixes
│
└── README.md                  # This file (root overview)
```

---

## 📖 Directory Overview

### 🔹 v1-tempconverter/
- Shows two different routing strategies:
  - **RAW mode** with inline choice logic
  - **PAYLOAD mode** with dynamic routing (`toD` + `direct` endpoints)
- Contains XSLT files in two variants:
  - With full SOAP envelopes (`*.xslt`)
  - With payload-only responses (`*-payload.xslt`)
- Includes a Camel **timer client** that auto-sends requests for testing.

👉 See [v1 README](./v1-tempconverter/README.md) for full details.

---

### 🔹 v2-tempconverter-fixed/
- Documents a **mistake** made in the first draft of the XSLT templates.
- Original error: XSLTs matched only `/ns:CelsiusToFahrenheit` instead of the full SOAP path (`/soap:Envelope/soap:Body/ns:CelsiusToFahrenheit`).
- This version fixes:
  - Correct XPath template match
  - Namespace consistency
  - Content-Type header (`text/xml` instead of `text/html`)
  - Filename typos (`fahrenheit` spelling)
- Contains a README explaining the debugging process.

👉 See [v2 README](./v2-tempconverter-fixed/README.md) for details.

---

## 🛠️ Running Any Version
- Install **Camel JBang**:
  ```bash
  curl -L https://camel.apache.org/install.sh | sh
  ```
- Run one of the route files, for example:
  ```bash
  camel run tempConvert.camel.yaml
  ```
- Test with SOAP clients (SoapUI, Postman, curl).

---

## 🎯 Learning Goals
- Understand **Camel CXF** integration for SOAP services.
- Practice **XSLT transformations** with SOAP payloads.
- Explore different routing strategies (**RAW vs PAYLOAD**).
- Debug common mistakes in SOAP/XSLT integration.

---

## 📖 References
- [Apache Camel](https://camel.apache.org/)
- [Camel JBang](https://camel.apache.org/manual/camel-jbang.html)
- [Apache CXF SOAP](https://cxf.apache.org/)
- [W3Schools TempConvert SOAP Service](https://www.w3schools.com/xml/tempconvert.asmx)
