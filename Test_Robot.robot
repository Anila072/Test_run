*** Settings ***
Documentation    圖書館頁面功能測試
Library  SeleniumLibrary

Suite Setup    Open Browser    https://rwd-library.taichung.gov.tw/webpac_rwd/search.cfm    chrome 
Suite Teardown    Close Browser 

*** Variables ***
${Book_01}    三國演義
${BookData_01}    三國演義[JB]   
${Link_01}    公佈欄
${Language}    Search

*** Test Cases ***
test_01-一般搜尋"三國演義"    
    [Documentation]   一般搜尋，預期能搜尋到對應書本
    [Tags]    一般搜尋測試
    視窗Max
    Input Text    xpath=//*[@id="ss_keyword"]    ${Book_01}
    Click Button     //*[@id="search"]/div[1]/div[1]/input   
    Wait Until Element Is Visible  xpath=//*[@id="body"]/footer

    Element Text Should Be      //*[@id="wrap"]/div[3]/div/div[2]/div[3]/div[2]/div[1]/a/mark    ${Book_01}

test_02-Click_"三國演義"，進入詳細書本頁面
    [Documentation]   點選清單書本，預期能進到書本詳細頁面，且資訊正確
    [Tags]    一般搜尋測試
    視窗Max
    Input Text    xpath=//*[@id="ss_keyword"]    ${Book_01}
    Click Element     //*[@id="search"]/div[1]/div[1]/input   
    Wait Until Element Is Visible  xpath=//*[@id="body"]/footer
   
    Click Element     xpath=//*[@id="wrap"]/div[3]/div/div[2]/div[3]/div[2]/div[2]/a[2]
    Wait Until Element Is Visible  xpath=/html/body/footer

    Element Text Should Be      //*[@id="wrap"]/div[3]/div/div[2]/div[3]/div[2]/div[1]    ${BookData_01}

test_03-連結驗證
    [Documentation]   公佈欄Link預期正確導航到頁面
    [Tags]    頁面連結驗證
    視窗Max
    Click Element     xpath=//*[@id="menu"]/div/nav/div/ul[1]/li[5]
    Wait Until Element Is Visible  xpath=/html/body/footer

    Element Text Should Be      //*[@id="form1"]/div/p    ${Link_01}

test_04-語言切換功能驗證
    [Documentation]   切換語言後，預期頁面能顯示選擇語言
    [Tags]    切換語言
    視窗Max
    切換語言(English)

    Element Text Should Be      //*[@id="menu"]/div/nav/div/ul[1]/li[1]    ${Language} 

test_05-語言切換功能驗證(重整頁面)
    [Documentation]   切換語言後，重整頁面，預期頁面語言仍為所切換後語言
    [Tags]    切換語言
    視窗Max
    切換語言(English)
    reload page

    Element Text Should Be      //*[@id="menu"]/div/nav/div/ul[1]/li[1]    ${Language} 

*** Keywords ***
視窗Max
    Maximize Browser Window

切換語言(English)
    Click Element     xpath=//*[@id="menu"]/div/div[2]/div/a[2]
    Wait Until Element Is Visible  xpath=//*[@id="body"]/footer


















