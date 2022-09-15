# PrepCrypto
PrepCrypto is an iOS Based application that works on Swift & UIKit to provide an environment where users can practice Trading in Crypto Currencies through a demo balance.

## What this app Uses:
1. Public Api: For Getting crypto Data 
2. Core Data: For storing Portfolio Data in a relational manner  
3. Swift Charts: For Presenting Crypto price Fluctuation in Line Chart 
4. MVC Architecture: For reuseable and maintainable code 

## Basic flow 
- User will get a fixed balance of Rs. 10,000 which is stored in balance Entity of core data. 
- Through this balance user can buy crypto on its current price and this buyed crytpo will be stored in potfolio entity in core data 
- And Though the comparition of current price (will be getting updated thorugh api call) and buyed price profit persentage will be calculated. 
- Every Transition will be tracked by adding it in the history entity which is in "one to many" relation with potfolio entity 

## Screen Shots 

### Potfolio View
<img src = "https://user-images.githubusercontent.com/69685349/190231991-f60ddaed-8c6f-4d64-9306-464dad158c4d.png" width="210" hight ="360"> <img src = "https://user-images.githubusercontent.com/69685349/190232017-b82ba2b3-8bc3-474e-b51f-6252d5ef0f8d.png" width="210" hight ="360"> <img src = "https://user-images.githubusercontent.com/69685349/190233725-e0c29c4b-28a3-4b8b-84c9-b409c9ec0d95.png" width="200" hight ="350"> 


### Crypto List & Buy stock 
<img src = "https://user-images.githubusercontent.com/69685349/190219603-edc324de-a13b-4461-800d-5555f351c223.png" width="210" hight ="360"> <img src = "https://user-images.githubusercontent.com/69685349/190219834-e3f20cd5-6e1d-42fb-bb4a-7c30fad6ddbb.png" width="200" hight ="350"> <img src = "https://user-images.githubusercontent.com/69685349/190219891-c2e07c9d-a473-4000-93e6-4c40e11acf76.png" width="200" hight ="350"> 

### History 
<img src = "https://user-images.githubusercontent.com/69685349/190220179-70efef41-aa69-4ce7-b8cb-079ac453562e.png" width="200" hight ="350"> 

### Core Data Entity Realtion 
![Screenshot 2022-09-15 at 11 49 31 AM](https://user-images.githubusercontent.com/69685349/190329179-6ae3ec2c-c1eb-4b0f-9de5-8b5b65d6180d.png)


