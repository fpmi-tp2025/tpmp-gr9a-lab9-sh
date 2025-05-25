//
//  Extensions.swift
//  Bank
//
//  Created by Victoria Ivanova on 25.05.25.
//


// Extensions.swift
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var s = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if s.hasPrefix("#") { s.removeFirst() }
        var rgb: UInt64 = 0
        Scanner(string: s).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16)/255
        let g = CGFloat((rgb & 0x00FF00) >> 8)/255
        let b = CGFloat( rgb & 0x0000FF     )/255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

extension UITextField {
    func setLeftPadding(_ pts: CGFloat) {
        let pad = UIView(frame: CGRect(x: 0, y: 0, width: pts, height: frame.height))
        leftView = pad; leftViewMode = .always
    }
}
