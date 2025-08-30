# 🌡️ TempConverter – Apache Camel SOAP Example

This project is a simple **temperature conversion service** built using **Apache Camel** with SOAP (via Apache CXF) and XSLT transformations.  

It demonstrates two different approaches for routing SOAP requests in Camel:
1. **RAW mode** with inline routing (`tempConvert.camel.yaml`)  
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
- Includes **client simulation route** using Camel’s `timer` to auto-send requests
- Runs standalone with **Camel JBang**

---

## 📂 Project Structure
```
.
├── application.properties       # Camel JBang + CXF dependencies
├── tempConvert.camel.yaml       # SOAP route using RAW mode + choice()
├── tempconvertD.camel.yaml      # SOAP route using PAYLOAD + dynamic routing
├── c-to-f.xslt                  # C → F (SOAP envelope response)
├── f-to-c.xslt                  # F → C (SOAP envelope response)
├── c-to-f-payload.xslt          # C → F (payload-only response)
├── f-to-c-payload.xslt          # F → C (payload-only response)
└── README.md                    # This file
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

### PAYLOAD mode (dynamic routing)
```bash
camel run tempconvertD.camel.yaml
```

Camel will auto-load dependencies defined in `application.properties`.

---

## 🧪 Testing the Service

You can send the following SOAP request using a SOAP client (e.g., SoapUI, Postman) or by placing it directly in the route’s setBody step (as shown in some of the Camel YAML examples).

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

### Expected Response 
For (PAYLOAD) **payload routes** (`*-payload.xslt`): 
```xml
<ns:CelsiusToFahrenheitResponse xmlns:ns="https://www.w3schools.com/xml/">
   <ns:CelsiusToFahrenheitResult>212.0</ns:CelsiusToFahrenheitResult>
</ns:CelsiusToFahrenheitResponse>
```

For (RAW) **SOAP envelope routes** (`*.xslt`):
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns:CelsiusToFahrenheitResponse xmlns:ns="https://www.w3schools.com/xml/">
      <ns:CelsiusToFahrenheitResult>212.0</ns:CelsiusToFahrenheitResult>
    </ns:CelsiusToFahrenheitResponse>
  </soap:Body>
</soap:Envelope>
```

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

### Expected Response 
For (PAYLOAD) **payload routes** (`*-payload.xslt`): 
```xml
<ns:FahrenheitToCelsiusResponse xmlns:ns="https://www.w3schools.com/xml/">
   <ns:FahrenheitToCelsiusResult>100.0</ns:FahrenheitToCelsiusResult>
</ns:FahrenheitToCelsiusResponse>
```

For (RAW) **SOAP envelope routes** (`*.xslt`):
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns:FahrenheitToCelsiusResponse xmlns:ns="https://www.w3schools.com/xml/">
      <ns:FahrenheitToCelsiusResult>100.0</ns:FahrenheitToCelsiusResult>
    </ns:FahrenheitToCelsiusResponse>
  </soap:Body>
</soap:Envelope>
```
---

## 🛠️ How It Works
1. SOAP request received on Camel CXF endpoint (`http://0.0.0.0:9999/tempconverter`)  
2. Camel routes the request:
   - **RAW mode** → `choice` inspects SOAP body for Celsius/Fahrenheit operation  
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
