//
//  APIHandlerController.swift
//  time_converter_api
//
//  Created by Leo Nugraha on 2021/8/19.
//

import Foundation


class APIHandler {

    // MARK: This function aims to enable login to the webAPI system. Always use POST method since POST method allows data body
    public class func postHttpsResponse(username: String, password: String, completionHandler: @escaping(DataParsed)->()) {
        var dataParsed: DataParsed? = nil
        let bodyDict: [String:Any] =  ["username":"\(username)","password":"\(password)"]
        let bodyData = try? JSONSerialization.data(withJSONObject: bodyDict, options: [])
        if let JSONString = String(data: bodyData!, encoding: String.Encoding.utf8) {
            print("DEBUG: \(#function) \(#line) \(JSONString)")
        }

        // Set HTTP Request Header and Body
        let url = URL(string: LOGIN_WEB_API)
        var request: URLRequest = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Accept")
        request.addValue(X_PARSE_APPLICATION_ID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.httpBody = bodyData

        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            let httpResponse = response as? HTTPURLResponse
            let statusCodeResponse = httpResponse?.statusCode

            if statusCodeResponse == 200 {

                if let data = data, let dataString = String(data: data, encoding: String.Encoding.utf8) {
                    print("DEBUG: \(#function) \(#line) - Status Code Response: \(String(describing: statusCodeResponse))")
                     print("DEBUG: Response data string:\n \(dataString)")

                    do {
                        let jsonDecoded = JSONDecoder()
                        let resultDecoded = try jsonDecoded.decode(DataParsed.self, from: data)
                        dataParsed = resultDecoded
                        completionHandler(dataParsed!)
                    } catch let error as NSError {
                        print(error)
                    } // end-do-catch
                    
                } else if statusCodeResponse != 200 {

                    // Handle the fail case scenario; only provide members that are checked
                    dataParsed?.objectId     = "NULL_ID"
                    dataParsed?.sessionToken = "NULL_ID"
                    dataParsed?.username     = "NULL_ID"
                    completionHandler(dataParsed!)

                } // end-if let data

            } // end-if statusCodeResponse
            semaphore.signal()

        } // end-of URL session
        task.resume()
        semaphore.wait()
    }

    // MARK: This function only updates the timezone value, and there is no need to fetch or parse the response
    public class func putHttpsResponse(sessionToken: String, objectId: String, timezone: Int) -> Int {
        var statusCode: Int = 0
        let bodyDict: [String:Any] =  ["timezone":timezone]
        let bodyData = try? JSONSerialization.data(withJSONObject: bodyDict, options: [])
        if let JSONString = String(data: bodyData!, encoding: String.Encoding.utf8) {
            print("DEBUG: \(#function) \(#line) \(JSONString)")
        }
        
        // Set HTTP Request Header and Body
        let url = URL(string: UPDATE_WEB_API + "\(objectId)")
        var request: URLRequest = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Accept")
        request.addValue(X_PARSE_APPLICATION_ID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("\(sessionToken)", forHTTPHeaderField: "X-Parse-Session-Token")
        request.httpBody = bodyData
        
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            let statusCodeResponse = httpResponse?.statusCode
            statusCode = statusCodeResponse!
            semaphore.signal()
        } // end-of URL session
        task.resume()
        semaphore.wait()
        return statusCode
    }

    /**
     Convert a string that represents JSON format to a dictionary with String-and-Any data type pair
     - Parameter text: A string text that represents JSON format that will be converted to a dictionary data type by the end of the function
     */
    private class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch let error as NSError {
                print(error.localizedDescription)
            } // end-do-catch
        } // end-if let data
        return nil
    }

}
