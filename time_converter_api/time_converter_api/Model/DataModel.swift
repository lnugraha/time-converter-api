//
//  DataModel.swift
//  time_converter_api
//
//  Created by Leo Nugraha on 2021/8/19.
//

import Foundation

// MARK: The following struct below is used to parse JSON response from web API
struct DataParsed: Codable {
    var objectId: String
    var username: String
    var code: String
    var isVerifiedReportEmail: Bool
    var reportEmail: String
    var createdAt: String
    var updatedAt: String
    var timezone: Int
    var parameter: Int
    var number: Int
    var phone: String
    var sessionToken: String
    var ACL: Dictionary<String, ReadWritePermission>
}

struct ReadWritePermission: Codable {
    var read: Bool
    var write: Bool
}

/**
 This singleton design pattern aims to store all necessary information that will be  used across all view controllers
 - parameters username: the  credential that should be identical between what user enters in the login page and what web API returns
 - parameters objectId: the unique identification that will be used to update timezone later on
 - parameters sessionToken: the unique authentication token that corresponds to each login session initiated
 - parameters timezone: the integer that describes the current timezone retrieved from web API
 */
final class GlobalDataAccess {
    static let shared = GlobalDataAccess()
    var username: String!
    var reportEmail: String!
    var phone: String!
    var timezone: Int!
    var isVerifiedReportEmail: Bool!
    
    var objectId: String!
    var sessionToken: String!
    var code: String!
}

// MARK: The following class is used to get or set key and value elements inside UserDefaults to store information credentials
final class ConfigureUserDefault {

    final class SetUserDefaultValue {

        final public class func setSessionToken(sessionToken: String) {
            UserDefaults.standard.set(sessionToken, forKey: "sessionToken")
        }

        final public class func setObjectId(objectId: String) {
            UserDefaults.standard.set(objectId, forKey: "objectId")
        }

        final public class func setUsername(username: String) {
            UserDefaults.standard.set(username, forKey: "username")
        }

        final public class func setTimezone(timezone: Int) {
            UserDefaults.standard.set(timezone, forKey: "timezone")
        }

        final public class func setCode(code: String) {
            UserDefaults.standard.set(code, forKey: "code")
        }

        final public class func setPhone(phone: String) {
            UserDefaults.standard.set(phone, forKey: "phone")
        }

        final public class func setReportEmail(reportEmail: String) {
            UserDefaults.standard.set(reportEmail, forKey: "reportEmail")
        }

        final public class func setIsVerifiedReportEmail(isVerifiedReportEmail: Bool) {
            UserDefaults.standard.set(isVerifiedReportEmail, forKey: "isVerifiedReportEmail")
        }

    }

    class GetUserDefaultValue {

        final public class func getSessionToken() -> String {
            return UserDefaults.standard.string(forKey: "sessionToken")!
        }

        final public class func getObjectId() -> String {
            return UserDefaults.standard.string(forKey: "objectId")!
        }

        final public class func getUsername() -> String {
            return UserDefaults.standard.string(forKey: "username")!
        }

        final public class func getTimezone() -> Int {
            return UserDefaults.standard.integer(forKey: "timezone")
        }

        final public class func getCode() -> String {
            return UserDefaults.standard.string(forKey: "code")!
        }

        final public class func getPhone() -> String {
            return UserDefaults.standard.string(forKey: "phone")!
        }

        final public class func getReportEmail() -> String {
            return UserDefaults.standard.string(forKey: "reportEmail")!
        }

        final public class func getIsVerifiedReportEmail() -> Bool {
            return UserDefaults.standard.bool(forKey: "isVerifiedReportEmail")
        }

    }

}
