## banglalink-interview assessments(Big Data)
### Problem Set 1: Task B & C

## Run
Run this command in the directory that has your docker-compose.yml
```
docker-compose up --build --detach
```
**API Details**
----
  Returns json data o

* **URL**

  (http://localhost/)

* **Method:**

  `POST`
  

* **Success Response:**

    **Example 1:** 
    * Data Param(Raw Data)  
     `2`  
   `Sun 10 May 2015 13:54:36 -0700`  
   `Sun 10 May 2015 13:54:36 -0000`  
   `Sat 02 May 2015 19:54:36 +0530`  
   `Fri 01 May 2015 13:54:36 -0000`
     
    * Response
    ```json
  {
        "id": "2c831ed945ad",
        "result": [
            25200,
            88200
        ]
  } 
  ```  

    **Example 2:** 
    * Data Param(Raw Data)  
     `2`  
   `Sun 10 May 2015 13:54:3-0700`  
   `Sun 10 May 2015 13:54:36 -0000`  
   `Sat 02 May 2015 19:54:36 +0530`  
   `Fri 01 May 2015 13:54:36 -0000`
     
    * Response
    ```json
   {
        "id": "740deb48a822",
        "result": [
            "Constraints: DateFormat",
            88200
        ]
    } 
  ```    
   
    **Example 3:** 
    * Data Param(Raw Data)  
     `2`  
   `Sun 10 May 2015 13:536-0700`  
   `Sun 10 May 2015 13:54:36 -0000`  
   `Sat 02 May 2015 19:54:36 +0530`
     
    * Response
    ```json
   {
        "id": "6aca19efc338",
        "result": [
            "Constraints: DateFormat",
            "Constraints: InputError"
        ]
    } 
  ```  
   
    **Example 3:** 
    * Data Param(Raw Data)  
     `asd`  
   `Sun 10 May 2015 13:536-0700`  
     
    * Response
    ```json
   {
        "id": "740deb48a822",
        "result": [
            "Constraints: InputError"
        ]
    } 
  ```  
   
    **Example 6:** 
    * Data Param(Raw Data)  
     `null data`
     
    * Response
    ```json
   {
        "id": "6aca19efc338",
        "result": [
            "Constraints: InputError"
        ]
    } 
  ```  