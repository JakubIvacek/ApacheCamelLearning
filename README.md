# 🌡️ Apache Camel SOAP TempConverter

This repository demonstrates how to build a **SOAP-based temperature converter** using **Apache Camel (with CXF)** and **XSLT transformations**.  

---

## 📂 Repository Structure
```
.
├── tempconverter/         # Server and Client TempConverter
│   ├── application.properties        # Camel JBang + CXF dependencies
│   ├── tempConvert.camel.yaml        # SOAP route using RAW mode + choice()
│   ├── tempconvertD.camel.yaml       # SOAP route using PAYLOAD + dynamic routing
│   ├── tempConvertFileReq.caml.yaml  # SOAP route using RAW + req body set from file
│   ├── c-to-f.xslt                   # C → F (SOAP envelope response)
│   ├── f-to-c.xslt                   # F → C (SOAP envelope response)
│   ├── c-to-f-payload.xslt           # C → F (payload-only response)
│   ├── f-to-c-payload.xslt           # F → C (payload-only response)
│   ├── c-to-f-req.xml               # Request body file fro C -> F conversion
│   ├── f-to-c-req.xml               # Request body file fro F -> C conversion
│   └── README.md
└── README.md                   
```

---

## 📖 Directory Overview

### 🔹 tempconverter/
- Shows two different routing strategies using xslt transformation:
  - **RAW mode** with inline choice logic ( choice when otherwise )
  - **RAW mode** with inline choice logic ( choice when otherwise ) + Body is set dynamically from file, fileName is set as run argument
  - **PAYLOAD mode** with dynamic routing (`toD (operationName)` + `direct` endpoints)
- Contains XSLT files in two variants:
  - With full SOAP envelopes (`*.xslt`) for RAW
  - With payload-only responses (`*-payload.xslt`) for PAYLOAD
- Contains XML files as request for calling Server as Client:
  - Sets Request body for F -> C (`f-to-c-req.xml`)
  - Sets Request body for C -> F (`c-to-f-req.xml`)
- Includes a Camel **timer client** that auto-sends requests for testing.
- You can change request in setBody step of timer route

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

