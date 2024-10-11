*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem
Library           BuiltIn
Library           String
Library           yaml
Library    CSVLibrary


*** Variables ***
${url}        https://www.saucedemo.com/v1/index.html 
${browser}    chrome
${CSV_FILE}    product.csv


*** Keywords ***
Open Browser chrome
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}

Input username
    [Arguments]    ${username}
    Input Text    //*[@id="user-name"]    ${username}

Input Password
    [Arguments]       ${password}
    Input text     //*[@id="password"]    ${password}
    
click login
    Click Button    //*[@id="login-button"]

click Add To cart
    Click Button    //*[@id="inventory_container"]/div/div[4]/div[3]/button

Check order cart
    Click Element    //*[@id="shopping_cart_container"]
    
Verify Product In Cart
    Wait until element is visible    //*[@id="cart_contents_container"]/div/div[1]/div[3]/div[2]/div[1]

Verify Product Name In Cart
    ${CSV_FILE}    Set Variable    product.csv
    ${DATA_CSV}    Read Csv File To Associative    ${CSV_FILE}
    ${products_from_csv}=    Get From List    ${DATA_CSV}    1
    FOR    ${row}    IN    @{DATA_CSV}
        ${csv_product_name}=    Get From Dictionary    ${row}    Product
        ${product_from_web}=    Get Text    //*[@class="inventory_item_name"]
        Should Be Equal    ${product_from_web}    ${csv_product_name}
        Run Keyword If    '${product_from_web}' == '${csv_product_name}'    Exit For Loop
    END

Verify Product Price In Cart
    ${CSV_FILE}    Set Variable    product.csv
    ${DATA_CSV}    Read Csv File To Associative    ${CSV_FILE}
    ${price_from_csv}=    Get From List    ${DATA_CSV}    1
    FOR    ${price_from_csv}    IN    @{DATA_CSV}
        ${csv_price}=    Set Variable    ${price_from_csv['Price']}
        ${csv_price}=    Strip String    ${csv_price}

        ${price_from_web}=    Get Text    //*[@class="inventory_item_price"]
        Should Be Equal As Numbers    ${price_from_web}    ${csv_price}
        Exit For Loop If    ${price_from_web} == ${csv_price}
    END
    


Checkout
    Click Element   //*[@id="cart_contents_container"]/div/div[2]/a[2]

Input First Name
    [Arguments]    ${first_name}
    Input Text    //*[@id="first-name"]    ${first_name}

Input Last Name
    [Arguments]    ${last_name}
    Input Text    //*[@id="last-name"]    ${last_name}

Input Zip Code
    [Arguments]    ${zip_code}
    Input Text    //*[@id="postal-code"]    ${zip_code}

click Continue
    Click Button    //*[@id="checkout_info_container"]/div/form/div[2]/input

click Finish
    Click Element    //*[@id="checkout_summary_container"]/div/div[2]/div[8]/a[2]


Verify Order Success
    Wait until element is visible    //*[@id="checkout_complete_container"]/h2    10s