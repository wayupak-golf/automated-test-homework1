*** Settings ***
Resource        import.resource
Variables       data.yaml


*** Test Cases ***
Open Browser chrome
    Open Browser chrome    ${url}    ${browser}
    Input username    ${username.stadard.name}
    Input Password    ${username.stadard.password}
    click login 
Add Item To Cart 
    click Add To cart
    Check order cart
Verify Text In Cart
    Verify Product In Cart
Verify Product Name
    Verify Product Name In Cart
Verify Product Price
    Verify Product Price In Cart
Checkout & Input Information
    Checkout
    Input First Name    ${your_Information.first_name}
    Input Last Name    ${your_Information.last_name}
    Input Zip Code    ${your_Information.zip_postal_code}
    click Continue
    click Finish
Verify Order Success
    Verify Order Success




    








