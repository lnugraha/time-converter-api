//
//  PopUpMessageView.swift
//  time_converter_api
//
//  Created by Leo Nugraha on 2021/8/19.
//

import Foundation
import UIKit

class AlertMessage: UIViewController {

    // Elements: OK button, Image, and Texts
    private lazy var proceedButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: BUTTON_WIDTH, height: BUTTON_HEIGHT))
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitle("確定", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = priColor
        button.addTarget(self, action: #selector(proceedButtonTapped), for: .touchUpInside)
        return button
    }()

    fileprivate func setLogoIcon(success: Bool) -> UIView {
        let logoView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        logoView.backgroundColor = gyColor

        let logoIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: LOGOSIZE, height: LOGOSIZE))
        logoIcon.backgroundColor = gyColor

        let logoLabel = UILabel(frame: CGRect(x: 0, y: 100, width: Int(FULL_WIDTH/2), height: TEXTFIELD_HEIGHT))
        logoLabel.font = UIFont.systemFont(ofSize: 24)
        logoLabel.backgroundColor = gyColor
        
        if success == true {
            logoIcon.image = UIImage(systemName: "rectangle.badge.checkmark")
            logoIcon.tintColor = priColor
            logoLabel.text = "處理成功！"
            logoLabel.textColor = priColor

        } else {
            logoIcon.image = UIImage(systemName: "exclamationmark.triangle")
            logoIcon.tintColor = orgColor
            logoLabel.text = "處理失敗！"
            logoLabel.textColor = orgColor

        }

        logoView.addSubview(logoIcon)
        logoView.addSubview(logoLabel)
        return logoView
    }

    @objc fileprivate func proceedButtonTapped() {
        let mainPageView = MainPageView()
        mainPageView.modalPresentationStyle = .fullScreen
        present(mainPageView, animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = gyColor
        
        self.view.addSubview(proceedButton)
        proceedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            proceedButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 120),
            proceedButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            proceedButton.heightAnchor.constraint(equalToConstant: CGFloat(BUTTON_HEIGHT)),
            proceedButton.widthAnchor.constraint(equalToConstant: CGFloat(BUTTON_WIDTH))
        ])
    }

    // Shift the logo (success or fail) upward
    func shiftLogo(figure: UIView) {
        self.view.addSubview(figure)
        figure.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            figure.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            figure.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20),
            figure.widthAnchor.constraint(equalToConstant: CGFloat(LOGOSIZE)),
            figure.heightAnchor.constraint(equalToConstant: CGFloat(LOGOSIZE))
        ])
    }
}

class SuccessAlertMessage: AlertMessage {

    override func viewDidLoad() {
        super.viewDidLoad()
        let figure = setLogoIcon(success: true)
        shiftLogo(figure: figure)
    }

}

class WarningAlertMessage: AlertMessage {

    override func viewDidLoad() {
        super.viewDidLoad()
        let figure = setLogoIcon(success: false)
        shiftLogo(figure: figure)
    }

}

class CommonButtonAccess: UIViewController {

    public class func getCancelButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: BUTTON_WIDTH, height: BUTTON_HEIGHT))
        button.backgroundColor = blColor
        button.layer.cornerRadius = 8
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }

}
