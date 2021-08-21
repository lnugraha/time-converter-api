//
//  Constants.swift
//  time_converter_api
//
//  Created by Leo Nugraha on 2021/8/19.
//

import Foundation
import UIKit

// MARK: Necessary web API links are listed below
let LOGIN_WEB_API           = "https://watch-master-staging.herokuapp.com/api/login"
let UPDATE_WEB_API          = "https://watch-master-staging.herokuapp.com/api/users/"
let X_PARSE_APPLICATION_ID  = "vqYuKPOkLQLYHhk4QTGsGKFwATT4mBIGREI2m8eD"

// MARK: Color choices
let priColor    = UIColor.init(red:  0/255.0, green: 167/255.0, blue: 148/255.0, alpha: 1.0)
let pri_5Color  = UIColor.init(red:  0/255.0, green: 167/255.0, blue: 148/255.0, alpha: 0.5)
let secColor    = UIColor.init(red: 93/255.0, green: 203/255.0, blue: 154/255.0, alpha: 1.0)
let trqColor    = UIColor.init(red: 92/255.0, green: 217/255.0, blue: 213/255.0, alpha: 1.0)

let bkColor     = UIColor.init(red:  32/255.0, green:  52/255.0, blue:  77/255.0, alpha: 1.0)
let blColor     = UIColor.init(red:  77/255.0, green: 106/255.0, blue: 141/255.0, alpha: 1.0)
let bl_5Color   = UIColor.init(red:  77/255.0, green: 106/255.0, blue: 141/255.0, alpha: 0.5)
let gyColor     = UIColor.init(red: 245/255.0, green: 246/255.0, blue: 250/255.0, alpha: 1.0)

let redColor    = UIColor.init(red: 255/255.0, green: 101/255.0, blue: 101/255.0, alpha: 1.0)
let orgColor    = UIColor.init(red: 255/255.0, green: 189/255.0, blue: 134/255.0, alpha: 1.0)

// MARK: Dimensions and Sizing
let FULL_WIDTH: CGFloat  = UIScreen.main.bounds.width
let FULL_HEIGHT: CGFloat = UIScreen.main.bounds.height

let OFFSET: Int          = 12
let MARGIN: Int          = 64
let PADDING: Int         = 16

let BOX_WIDTH: Int       = Int(FULL_WIDTH - 24)
let BOX_HEIGHT: Int      = 48

let TEXTFIELD_WIDTH:Int  = BOX_WIDTH  - OFFSET
let TEXTFIELD_HEIGHT:Int = BOX_HEIGHT - OFFSET

let BUTTON_WIDTH         = BOX_WIDTH/3
let BUTTON_HEIGHT        = 48
let LOGOSIZE             = 96

extension UserDefaults {

    enum UserDefaultKeys: String {
        case isLoggedIn
    }

    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultKeys.isLoggedIn.rawValue)
        synchronize()
    }

    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }

}
