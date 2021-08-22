//
//  time_converter_apiTests.swift
//  time_converter_apiTests
//
//  Created by Leo Nugraha on 2021/8/19.
//

import XCTest
@testable import time_converter_api

class time_converter_apiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_login_api_pass() throws {

        APIHandler.postHttpsResponse(username: "test2@qq.com", password: "test1234qq", completionHandler: { testResults in
            GlobalDataAccess.shared.username                = testResults.username              // test2@qq.com
            GlobalDataAccess.shared.code                    = testResults.code                  // 4wtmah5h
            GlobalDataAccess.shared.reportEmail             = testResults.reportEmail           // test2@qq.com
            GlobalDataAccess.shared.phone                   = testResults.phone                 // 415-369-1111
            GlobalDataAccess.shared.isVerifiedReportEmail   = testResults.isVerifiedReportEmail // true
            GlobalDataAccess.shared.objectId                = testResults.objectId              // WkuKfCAdGq
            // Cover parameters fetched that are only available inside the closure
            XCTAssertEqual(testResults.parameter, 8)
            XCTAssertNotEqual(testResults.number, 5)
        })

        XCTAssertEqual(GlobalDataAccess.shared.username!,               "test2@qq.com")
        XCTAssertEqual(GlobalDataAccess.shared.code!,                   "4wtmah5h")
        XCTAssertEqual(GlobalDataAccess.shared.reportEmail!,            "test2@qq.com")
        XCTAssertEqual(GlobalDataAccess.shared.phone!,                  "415-369-1111")
        XCTAssertEqual(GlobalDataAccess.shared.isVerifiedReportEmail,   true)
        XCTAssertEqual(GlobalDataAccess.shared.objectId,                "WkuKfCAdGq")
    }

    func test_login_api_fail() throws {

        var testUsername = String(); var testSessionToken = String(); var testObjectId = String();
        APIHandler.postHttpsResponse(username: "test2@qq.com", password: "XXXXXXXX", completionHandler: { testResults in

            testUsername = testResults.username
            testSessionToken = testResults.sessionToken
            testObjectId = testResults.objectId

        })

        XCTAssertNotEqual(testUsername, "test2@qq.com")
        XCTAssertEqual(testSessionToken, "")
        XCTAssertNotEqual(testObjectId, "WkuKfCAdGq")

    }
    
    func test_update_api_pass() throws {

        var testToken = String(); var testObjectId = String()
        APIHandler.postHttpsResponse(username: "test2@qq.com", password: "test1234qq", completionHandler: { testResults in
            print("DEBUG Session Token: \(testResults.sessionToken)")
            testToken       = testResults.sessionToken
            testObjectId    = testResults.objectId
        })

        let testStatusCode = APIHandler.putHttpsResponse(sessionToken: testToken, objectId: testObjectId, timezone: 11)
        XCTAssertEqual(200, testStatusCode)

    }
    
    func test_update_api_fail() throws {
        let testStatusCode = APIHandler.putHttpsResponse(sessionToken: "0000000000", objectId: "0000000000", timezone: 11)
        print("Status Code afrer API update: \(testStatusCode)") // 400
        XCTAssertNotEqual(200, testStatusCode)
        XCTAssertEqual(400, testStatusCode)
    }

    func test_json_converter() throws {

        let testInputs = """
            {"username":"Username_Blank", "objectId":"ObjectId_Blank", "sessionToken":"SessionToken_Blank", "code":"Code_Blank"}
        """

        let testDict = APIHandler.convertToDictionary(text: testInputs)
        print("DEBUG: \(type(of: testDict))")

        let check_name = testDict!["username"]
        let check_objectId = testDict!["objectId"]
        let check_sessionToken = testDict!["sessionToken"]
        let check_code = testDict!["code"]

        XCTAssertEqual(check_name! as! String, "Username_Blank")
        XCTAssertEqual(check_objectId! as! String, "ObjectId_Blank")
        XCTAssertEqual(check_sessionToken! as! String, "SessionToken_Blank")
        XCTAssertEqual(check_code! as! String, "Code_Blank")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
