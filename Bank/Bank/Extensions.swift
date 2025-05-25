//
//  Extensions.swift
//  Bank
//
//  Created by Victoria Ivanova on 25.05.25.
//

import UIKit

// MARK: — UIColor из HEX
extension UIColor {
    /// Инициализация через строку вида "#RRGGBB"
    convenience init(hex: String) {
        var s = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        if s.hasPrefix("#") { s.removeFirst() }
        let rgb = Int(s, radix: 16) ?? 0
        let r = CGFloat((rgb >> 16) & 0xFF) / 255
        let g = CGFloat((rgb >>  8) & 0xFF) / 255
        let b = CGFloat( rgb        & 0xFF) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

// MARK: — Отступ слева в UITextField
extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
