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
<img src = "" width="200" hight ="350"> <img src = "https://user-images.githubusercontent.com/69685349/190219449-43ff1856-e8c6-4010-8501-62a5bef08df8.png" width="200" hight ="350"> <img src = "https://user-images.githubusercontent.com/69685349/181471391-81cd8c08-e0f2-4439-ba02-a168597ca307.png" width="200" hight ="350">
![Screenshot 2022-09-14 at 10 41 25 PM](https://user-images.githubusercontent.com/69685349/190219196-897033f1-2893-465c-879e-70fd085d4097.png) ![Screenshot 2022-09-14 at 10 42 55 PM]() ![Screenshot 2022-09-14 at 10 46 12 PM 1](https://user-images.githubusercontent.com/69685349/190219996-1ae3a40d-5fa8-4bd2-bcc3-23307d5676c4.png)

### Crypto List & Buy stock 
![Screenshot 2022-09-14 at 10 43 43 PM 1](https://user-images.githubusercontent.com/69685349/190219603-edc324de-a13b-4461-800d-5555f351c223.png)  ![Screenshot 2022-09-14 at 10 45 02 PM](https://user-images.githubusercontent.com/69685349/190219834-e3f20cd5-6e1d-42fb-bb4a-7c30fad6ddbb.png) ![Screenshot 2022-09-14 at 10 45 34 PM](https://user-images.githubusercontent.com/69685349/190219891-c2e07c9d-a473-4000-93e6-4c40e11acf76.png)

### History 
![Screenshot 2022-09-14 at 10 47 00 PM](https://user-images.githubusercontent.com/69685349/190220179-70efef41-aa69-4ce7-b8cb-079ac453562e.png)
