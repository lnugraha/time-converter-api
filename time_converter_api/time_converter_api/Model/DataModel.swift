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
