//
//  time_converter_apiUITests.swift
//  time_converter_apiUITests
//
//  Created by Leo Nugraha on 2021/8/19.
//

import XCTest

class time_converter_apiUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Simulate logging in to the Main Page View
    func test_login_menu_pass() throws {
        let app = XCUIApplication()
        app.launch()
        // print("List of all UI elements: \(app.debugDescription)")
        // NOTE: To enable multiple text field entries, you neeed to disable the iPhone keyboard simulator
        // defaults write com.apple.iphonesimulator ConnectHardwareKeyboard 0
        
        XCTAssertTrue(app.buttons["登入"].exists)
        XCTAssertTrue(app.textFields["帳號"].exists)
        XCTAssertTrue(app.secureTextFields["密碼"].exists)

        app.secureTextFields["密碼"].tap()
        app.secureTextFields["密碼"].typeText("test1234qq")
        
        app.textFields["帳號"].tap()
        app.textFields["帳號"].typeText("test2@qq.com")
        
        app.buttons["登入"].tap()
        // Confirm that users have been to Main Page View
        XCTAssertTrue(app.buttons["登出"].exists)
        XCTAssertTrue(app.buttons["改變時區"].exists)
    }

    // Simulate logging in attempt by leaving all text entries empty
    func test_login_no_entry() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.secureTextFields["密碼"].tap()
        app.secureTextFields["密碼"].typeText("")
        
        app.textFields["帳號"].tap()
        app.textFields["帳號"].typeText("")
        
        app.buttons["登入"].tap()
        XCTAssertTrue(app.staticTexts["帳號或密碼不能空間"].exists)
    }

    // Simulate logging in attempt by filling in incorrect credentials
    func test_login_wrong_entry() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.secureTextFields["密碼"].tap()
        app.secureTextFields["密碼"].typeText("test3@qq.com")
        
        app.textFields["帳號"].tap()
        app.textFields["帳號"].typeText("1234567890")
        
        app.buttons["登入"].tap()
        XCTAssertTrue(app.staticTexts["帳號或密碼無效，請重新輸入！"].exists)
    }

    // Simulate one full round trip from logging in to logging out successfully
    func test_login_to_logout() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["帳號"].tap()
        app.textFields["帳號"].typeText("test2@qq.com")
        app.secureTextFields["密碼"].tap()
        app.secureTextFields["密碼"].typeText("test1234qq")
        app.buttons["登入"].tap()
        // Confirm that users have been to Main Page View
        XCTAssertTrue(app.buttons["登出"].exists)
        app.buttons["登出"].tap()
        // Enter the logout confirmation page
        XCTAssertTrue(app.buttons["取消"].exists)
        XCTAssertTrue(app.buttons["確定"].exists)
        app.buttons["確定"].tap()
        // Back to login page again
        XCTAssertTrue(app.buttons["登入"].exists)
        XCTAssertTrue(app.textFields["帳號"].exists)
        XCTAssertTrue(app.secureTextFields["密碼"].exists)
    }

    // Simulate logging in to changing time zone and return to Main Page View
    func test_login_to_timezone_to_main() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["帳號"].tap()
        app.textFields["帳號"].typeText("test2@qq.com")
        app.secureTextFields["密碼"].tap()
        app.secureTextFields["密碼"].typeText("test1234qq")
        app.buttons["登入"].tap()
        // Confirm that users have been to Main Page View
        XCTAssertTrue(app.buttons["改變時區"].exists)
        app.buttons["改變時區"].tap()

        let random_number = Int.random(in: 1...6)
        if random_number % 2 == 0 {
            app.buttons["Decrement"].tap()
        } else {
            app.buttons["Increment"].tap()
        }

        app.buttons["確定"].tap()
        XCTAssertTrue(app.staticTexts["處理成功！"].exists)
        XCTAssertTrue(app.buttons["確定"].exists)
        app.buttons["確定"].tap()
        // Back to Main Page View
        XCTAssertTrue(app.staticTexts["個人資料"].exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
