# 🌡️ Apache Camel SOAP TempConverter – Root Project

This repository demonstrates how to build a **SOAP-based temperature converter** using **Apache Camel (with CXF)** and **XSLT transformations**.  
It contains two different directories.

---

## 📂 Repository Structure
```
.
├── tempconverter/         # Implementation of Server and Client
│   ├── application.properties
│   ├── tempConvert.camel.yaml
│   ├── tempconvertD.camel.yaml
│   ├── c-to-f.xslt
│   ├── f-to-c.xslt
│   ├── c-to-f-payload.xslt
│   ├── f-to-c-payload.xslt
│   └── README.md           
│
├── searchingForMistake/    # Exercise trying to find out what is wrong here (xslt problems)
│   ├── celsiusToFaren.xslt
│   ├── fahrenheitToCelsius.xslt
│   ├── tempConvertFixed.camel.yaml
|   ├── application.properties
│   └── README.md             
└── README.md              
```

---

## 📖 Directory Overview

### 🔹 tempconverter/
- Shows two different routing strategies:
  - **RAW mode** with inline choice logic ( choice when otherwise)
  - **PAYLOAD mode** with dynamic routing (`toD (operationName)` + `direct` endpoints)
- Contains XSLT files in two variants:
  - With full SOAP envelopes (`*.xslt`) for RAW
  - With payload-only responses (`*-payload.xslt`) for PAYLOAD
- Includes a Camel **timer client** that auto-sends requests for testing.

👉 See [v1 README](./tempconverter/README.md) for full details.

---

### 🔹 searchingForMistake/
- Exercise for finding a **mistake** made in the routes
- Mistake was wrong xslt after changing from RAW TO PAYLOAD
- Because PAYLOAD option is trying to recreate SOAP RESPONSE based on wsld file
  but based of xslt xml schema is wrong and response cant be created
- Solution - change wsld files to create correct xml schema (commented out is wrong old schema)

👉 See [v2 README](./searchingForMistake/README.md) for details.

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
- Find common mistakes in SOAP/XSLT integration.

---

## 📖 References
- [Apache Camel](https://camel.apache.org/)
- [Camel JBang](https://camel.apache.org/manual/camel-jbang.html)
- [Apache CXF SOAP](https://cxf.apache.org/)
- [W3Schools TempConvert SOAP Service](https://www.w3schools.com/xml/tempconvert.asmx)
