# 🌡️ TempConverter – Apache Camel SOAP 

This project is a simple **temperature conversion service** built using **Apache Camel** with SOAP (via Apache CXF) and XSLT transformations.  

It demonstrates two different approaches for routing SOAP requests in Camel:
1. **RAW mode** with inline routing (`tempConvert.camel.yaml`) 
1. **RAW mode** with inline routing + request set from File dynamically (`tempConvertFileReq.camel.yaml`)   
2. **PAYLOAD mode** with dynamic routing (`tempconvertD.camel.yaml`) using header.operationName

---

## 🚀 Features
- SOAP Web Service for converting:
  - **Celsius → Fahrenheit**
  - **Fahrenheit → Celsius**
- Two routing styles (RAW vs PAYLOAD)
- XSLT-based transformations:
  - `*.xslt` → responses wrapped in SOAP Envelope for RAW delivery
  - `*-payload.xslt` → payload-only responses for PAYLOAD delivery
- Contains XML files as request for calling Server as Client:
  - Sets Request body for F -> C (`f-to-c-req.xml`)
  - Sets Request body for C -> F (`c-to-f-req.xml`)
- Includes **client simulation route** using Camel’s `timer` to auto-send requests
- Runs standalone with **Camel JBang**

---

## 📂 Project Structure
```
.
├── application.properties        # Camel JBang + CXF dependencies
├── tempConvert.camel.yaml        # SOAP route using RAW mode + choice()
├── tempconvertD.camel.yaml       # SOAP route using PAYLOAD + dynamic routing
├── tempConvertFileReq.caml.yaml  # SOAP route using RAW + req body set from file
├── c-to-f.xslt                   # C → F (SOAP envelope response)
├── f-to-c.xslt                   # F → C (SOAP envelope response)
├── c-to-f-payload.xslt           # C → F (payload-only response)
├── f-to-c-payload.xslt           # F → C (payload-only response)
├── c-to-f-req.xml                # Request body file for C → F conversion
├── f-to-c-req.xml                # Request body file for F → C conversion
└── README.md                     # Project documentation
```

---

## ⚙️ Prerequisites
- **Java 17+**
- **Apache Camel JBang**  
  Install via:
  ```bash
  curl -L https://camel.apache.org/install.sh | sh
  ```
- (Optional) SOAP client for testing (e.g., **SoapUI**, **curl**, or **Postman** with SOAP support)

---

## ▶️ Running the Service
Run either route variant:

### RAW mode (choice-based routing)
```bash
camel run tempConvert.camel.yaml
```

### RAW mode (choice-based routing + req setBody from file dynamic as arg)
```bash
# F -> C conversion
camel run tempconvertD.camel.yaml --property=soap.file=f-to-c-req.xml
# C -> F conversion
camel run tempconvertD.camel.yaml --property=soap.file=c-to-f-req.xml
```


### PAYLOAD mode (dynamic routing)
```bash
camel run tempconvertD.camel.yaml
```

Camel will auto-load dependencies defined in `application.properties`.

---

## 🧪 Setting up SOAP BODY Client in non FileReq Examples

You can send the SOAP request by placing it directly in the route’s setBody step (as shown in some of the Camel YAML examples).

Setting up example in yaml files find Client setBody and change : 

```xml
 - setBody:
   id: setBody-eb39
      description: set soapbody
      expression:
      constant:
      id: constant-f217
      expression: >-
         <?xml version="1.0" encoding="utf-8"?> 
         <soap:Envelope
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema"
            xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
            <soap:Body>
               <CelsiusToFahrenheit xmlns="https://www.w3schools.com/xml/">
                  <Celsius>30</Celsius>
               </CelsiusToFahrenheit>
            </soap:Body>
         </soap:Envelope>
```

Or in UI Karavan also change setBody step: 

![Alt text](/images/examplePic.png)


### 1. SOAP Request (Celsius → Fahrenheit)

- RAW

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="https://www.w3schools.com/xml/">
   <soap:Body>
      <ns:CelsiusToFahrenheit>
         <ns:Celsius>100</ns:Celsius>
      </ns:CelsiusToFahrenheit>
   </soap:Body>
</soap:Envelope>
```

- PAYLOAD

```xml
<ns:CelsiusToFahrenheit>
   <ns:Celsius>100</ns:Celsius>
</ns:CelsiusToFahrenheit>
```


### 2. SOAP Request (Fahrenheit → Celsius) 

- RAW

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="https://www.w3schools.com/xml/">
   <soap:Body>
      <ns:FahrenheitToCelsius>
         <ns:Fahrenheit>212</ns:Fahrenheit>
      </ns:FahrenheitToCelsius>
   </soap:Body>
</soap:Envelope>
```
- PAYLOAD

```xml
<ns:FahrenheitToCelsius>
     <ns:Fahrenheit>212</ns:Fahrenheit>
</ns:FahrenheitToCelsius>
```

---

## 🛠️ How It Works
1. SOAP request received on Camel CXF endpoint (`http://0.0.0.0:9999/tempconverter`)  
2. Camel routes the request:
   - **RAW mode** → `choice` inspects SOAP body for Celsius/Fahrenheit operation  
    - **RAW mode + setBody from file** → same as first option with `choice` + new Client Request is dynamically loaded from file which is taken as run argument 
   - **PAYLOAD mode** → uses `toD` and `direct` endpoints (`CelsiusToFahrenheit` or `FahrenheitToCelsius`)  
3. XSLT applies conversion formula:
   - **C→F**: `(°C × 9/5) + 32`  
   - **F→C**: `(°F − 32) × 5/9`  
4. Response returned as SOAP or payload depending on the XSLT  
5. Optional **timer route** auto-sends a test SOAP request and logs the cleaned result

---

## 📖 References
- [Apache Camel](https://camel.apache.org/)
- [Camel JBang](https://camel.apache.org/manual/camel-jbang.html)
- [Apache CXF SOAP](https://cxf.apache.org/)
