//
//  MainPageView.swift
//  time_converter_api
//
//  Created by Leo Nugraha on 2021/8/19.
//

import Foundation
import UIKit

class MainPageView: UIViewController {

    private lazy var topBannerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(FULL_WIDTH), height: 100))
        view.backgroundColor = priColor

        let label = UILabel(frame: CGRect(x: 0, y: 50, width: Int(FULL_WIDTH), height: 80))
        label.text = "個人資料"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = priColor
        label.font = UIFont.systemFont(ofSize: 28)

        view.addSubview(label)
        return view
    }()
    
    private func setTitleOrLabel(textStr: String, yPosition: Int, title: Bool) -> UILabel {
        let TEXT_SIZE = 200; let TITLE_OFFSET = 64; let LABEL_OFFSET = Int(Int(FULL_WIDTH)-64-TEXT_SIZE)
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.text = textStr
        
        if title == true {
            label.frame = CGRect(x: TITLE_OFFSET, y: yPosition, width: TEXT_SIZE, height: 30)
            label.textAlignment = .left
            label.textColor = bkColor

        } else {
            label.frame = CGRect(x: LABEL_OFFSET, y: yPosition, width: TEXT_SIZE, height: 30)
            label.textAlignment = .right
            label.textColor = bl_5Color
        }

        return label
    }
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 200, width: Int(FULL_WIDTH), height: Int(4*FULL_WIDTH/5)))
        view.backgroundColor = gyColor

        let INITIAL_Y = 10; let Y_INCREMENT = 40

        let usernameTitle = setTitleOrLabel(textStr: "帳號", yPosition: INITIAL_Y, title: true)
        let usernameLabel = setTitleOrLabel(textStr: GlobalDataAccess.shared.username, yPosition: Int(usernameTitle.frame.minY), title: false)

        let reportEmailTitle = setTitleOrLabel(textStr: "email", yPosition: INITIAL_Y + Y_INCREMENT, title: true)
        let reportEmailLabel = setTitleOrLabel(textStr: GlobalDataAccess.shared.reportEmail, yPosition: Int(reportEmailTitle.frame.minY), title: false)

        let phoneTitle = setTitleOrLabel(textStr: "手機", yPosition: INITIAL_Y + 2*Y_INCREMENT, title: true)
        let phoneLabel = setTitleOrLabel(textStr: GlobalDataAccess.shared.phone, yPosition: Int(phoneTitle.frame.minY), title: false)

        var accountVerification = "NO"
        if GlobalDataAccess.shared.isVerifiedReportEmail == true {
            accountVerification = "YES"
        } else {
            accountVerification = "NO"
        }

        let verificationTitle = setTitleOrLabel(textStr: "確認", yPosition: INITIAL_Y + 3*Y_INCREMENT, title: true)
        let verificationLabel = setTitleOrLabel(textStr: accountVerification, yPosition: Int(verificationTitle.frame.minY), title: false)

        let timezoneTitle = setTitleOrLabel(textStr: "時區", yPosition: INITIAL_Y + 4*Y_INCREMENT, title: true)
        let timezoneLabel = setTitleOrLabel(textStr: String(GlobalDataAccess.shared.timezone), yPosition: Int(timezoneTitle.frame.minY), title: false)

        view.addSubview(usernameTitle)
        view.addSubview(usernameLabel)

        view.addSubview(reportEmailTitle)
        view.addSubview(reportEmailLabel)

        view.addSubview(phoneTitle)
        view.addSubview(phoneLabel)

        view.addSubview(verificationTitle)
        view.addSubview(verificationLabel)
        
        view.addSubview(timezoneTitle)
        view.addSubview(timezoneLabel)

        return view
    }()
    
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 64, y: Int(FULL_HEIGHT)-96, width: Int(BOX_WIDTH/3), height: 48))
        button.layer.cornerRadius = 8
        button.backgroundColor = priColor
        button.setTitle("登出", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func logoutButtonTapped() {
        // Switch to Logout Page View
        let logoutPageView = LogoutPageView()
        logoutPageView.modalPresentationStyle = .fullScreen
        present(logoutPageView, animated: false, completion: nil)
    }

    private lazy var changeTimeZoneButton: UIButton = {
        let button = UIButton(frame: CGRect(x: Int(FULL_WIDTH)-64, y: Int(FULL_HEIGHT)-96, width: Int(BOX_WIDTH/3), height: 48))
        button.layer.cornerRadius = 8
        button.backgroundColor = bl_5Color
        button.setTitle("改變時區", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(changeTimeZoneTapped), for: .touchUpInside)
        return button
    }()

    @objc private func changeTimeZoneTapped() {
        // Display a time zone change View Controller
        let timeZoneView = TimeZoneChangeView()
        timeZoneView.modalPresentationStyle = .fullScreen
        present(timeZoneView, animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = gyColor

        // Contents
        self.view.addSubview(topBannerView)
        self.view.addSubview(contentView)

        // Action buttons
        self.view.addSubview(logoutButton)
        self.view.addSubview(changeTimeZoneButton)

        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: FULL_HEIGHT-96),
            logoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
            logoutButton.widthAnchor.constraint(equalToConstant: CGFloat(Int(BOX_WIDTH/3))),
            logoutButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        changeTimeZoneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeTimeZoneButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: FULL_HEIGHT-96),
            changeTimeZoneButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64),
            changeTimeZoneButton.widthAnchor.constraint(equalToConstant: CGFloat(Int(BOX_WIDTH/3))),
            changeTimeZoneButton.heightAnchor.constraint(equalToConstant: 48)
        ])

    }
    
    
}
