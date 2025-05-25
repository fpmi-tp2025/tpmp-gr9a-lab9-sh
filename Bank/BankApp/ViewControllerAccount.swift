//
//  ViewControllerAccount.swift
//  BankApp
//
//  Created by Ivan Hontarau on 25.05.25.
//


//
//  ViewControllerAccount.swift
//  BankApp
//
//   Created by DIma, Demid and Dora, Masha. DEATH PACT. on 28.05.24.
//

import UIKit
import SQLite

class ViewControllerAccount: UIViewController, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        strings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: acountDataCell.identifier, for: indexPath) as! acountDataCell
        cell.titleLabel.text = titles[indexPath.row]
        cell.dataLabel.text = strings[indexPath.row]
        return cell
    }

    var strings: [String] = []
    var titles: [String] = []
    var accountId: Int64?

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.register(acountDataCell.nib(), forCellReuseIdentifier: acountDataCell.identifier)

        let accountIdExpression = Expression<Int64>("account_id")
        let userIdExpression = Expression<Int64>("user_id")
        let accountTypeExpression = Expression<String>("account_type")
        let accountSubtypeExpression = Expression<String?>("account_subtype")
        let balanceExpression = Expression<Double>("balance")
        let overdraftLimitExpression = Expression<Double?>("overdraft_limit")
        let username = Expression<String>("username")
        let accounts = Table("accounts")
        let users = Table("users")
        let path = Bundle.main.path(forResource: "db", ofType: "sqlite3")!
        do {
            let db = try Connection(path, readonly: true)
            for account in try db.prepare(accounts) {
                if (account[accountIdExpression] == accountId) {
                    for user in try db.prepare(users) {
                        if (user[userIdExpression] == account[userIdExpression]) {
                            titles.append("Owner")
                            titles.append("Account ID")
                            titles.append("Account Type")
                            strings.append(user[username])
                            strings.append(String(account[accountIdExpression]))
                            strings.append(account[accountTypeExpression])
                            if (account[accountTypeExpression] == "Card") {
                                titles.append("Account Sub Type")
                                strings.append(account[accountSubtypeExpression]!)
                                if (account[accountSubtypeExpression] == "Salary") {
                                    titles.append("Overdraft Limit")
                                    strings.append(String(account[overdraftLimitExpression]!))
                                }
                            }

                            titles.append("Balance")
                            strings.append("\(account[balanceExpression])$")

                        }
                    }
                }
            }


        } catch {
            print("error connectng data base")
            return
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
