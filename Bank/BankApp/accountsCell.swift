//
//  accountsCell.swift
//  BankApp
//
//  Created by Ivan Hontarau on 25.05.25.
//


import UIKit

class accountsCell: UITableViewCell {

    static let identifier = "accountsCell"

    static func nib() -> UINib {
        return UINib(nibName: "accountsCell", bundle: nil)
    }

    @IBOutlet weak var customLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
