//
//  acountDataCell.swift
//  BankApp
//
//  Created by Ivan Hontarau on 25.05.25.
//


import UIKit

class acountDataCell: UITableViewCell {

    static let identifier = "acountDataCell"

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    static func nib() -> UINib {
        return UINib(nibName: "acountDataCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
