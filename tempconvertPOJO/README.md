# 🌡️ TempConverter – Apache Camel SOAP 

This project is a simple **temperature conversion service** built using **Apache Camel** with SOAP (via Apache CXF) and JAva transformations.  

It demonstrates approach for routing SOAP requests in Camel and using JAVA to transform body, also pom.xml is used to generate wsld2java .jar file which is used form marshalling/unmarshalling xml which is basically transformation.

---
## 📂 Repository Structure
```
| tempconverterPOJO/    TempConverter Server + Client Java transformations
├── tempConvertPOJO.camel.yaml # Route using java for transformations
├── application.properties     # Camel JBang dependencies
├── pom.xml                    # Mvn .jar installation wsld2java
└── README.md    

```
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

### First step install pom.xml
```bash
mvn clean install # installs .jar into maven local dep
```
### Run route
```bash
camel run tempConvertPOJO.camel.yaml
```
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


```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="https://www.w3schools.com/xml/">
   <soap:Body>
      <ns:CelsiusToFahrenheit>
         <ns:Celsius>100</ns:Celsius>
      </ns:CelsiusToFahrenheit>
   </soap:Body>
</soap:Envelope>
```



### 2. SOAP Request (Fahrenheit → Celsius) 

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="https://www.w3schools.com/xml/">
   <soap:Body>
      <ns:FahrenheitToCelsius>
         <ns:Fahrenheit>212</ns:Fahrenheit>
      </ns:FahrenheitToCelsius>
   </soap:Body>
</soap:Envelope>
```

---

## 🛠️ How It Works
0. Maven is used to install .jar wsld2java inside local maven depositary
1. SOAP request received on Camel CXF endpoint (`http://0.0.0.0:9999/hello`)  
2. Camel route:
   -  SOAP envelope arrives at Server
   -  Xml is marshalled into java object
   -  Java code (transformations) is applied
   -  Java marshalled into Xml and send back to Client
   -  Clien recievies and logs answer

 **Timer route** auto-sends a test SOAP request and logs the cleaned result

---

## 📖 References
- [Apache Camel](https://camel.apache.org/)
- [Camel JBang](https://camel.apache.org/manual/camel-jbang.html)
- [Apache CXF SOAP](https://cxf.apache.org/)
