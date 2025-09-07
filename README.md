# 🌡️ Apache Camel SOAP TempConverter

This repository demonstrates how to build a **SOAP-based temperature converter** using **Apache Camel (with CXF)** and **XSLT transformations**.  

---

## 📂 Repository Structure
```
.
├── images/                # Just some images
├── tempconverter/         # TempConverter Server + Client XSLT transformations
│   ├── application.properties        # Camel JBang dependencies
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
│
├── tempconverterPOJO/    TempConverter Server + Client Java transformations
│   ├── tempConvertPOJO.camel.yaml # Route using java for transformations
|   ├── application.properties     # Camel JBang dependencies
|   ├── pom.xml                    # Mvn .jar installation wsld2java
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

👉 See [v1 README](./tempconverter/README.md) for full details.

---

### 🔹 tempconverterPOJO/
- Shows route tempcoverter using java for transformation
  - pom.xml - creates wsld2java .jar which is used to un/marshal xml into java and for transformations 

👉 See [v2 README](./searchingForMistake/README.md) for details.

---

## 🎯 Learning Goals
- Understand **Camel CXF** integration for SOAP services.
- Practice **XSLT transformations** with SOAP payloads.
- Explore different routing strategies (**RAW vs PAYLOAD**).
- Practice **Java transformations** with SOAP payloads.
- Maven creation wsld2java .jar

---

## 📖 References
- [Apache Camel](https://camel.apache.org/)
- [Camel JBang](https://camel.apache.org/manual/camel-jbang.html)
- [Apache CXF SOAP](https://cxf.apache.org/)
- [W3Schools TempConvert SOAP Service](https://www.w3schools.com/xml/tempconvert.asmx)

