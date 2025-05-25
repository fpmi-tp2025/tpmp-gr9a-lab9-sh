//
//  ViewControllerAccounts.swift
//  BankApp
//
//  Created by Ivan Hontarau on 25.05.25.
//


import UIKit
import SQLite

class ViewControllerAccounts: UIViewController {
    @IBOutlet weak var table: UITableView!

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)

    }

    var dataSourceArray: [String] = []
    var idArray: [Int64] = []

    var userId: Int64?

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self

        table.register(accountsCell.nib(), forCellReuseIdentifier: accountsCell.identifier)
        let path = Bundle.main.path(forResource: "db", ofType: "sqlite3")!
        let accounts = Table("accounts")
        let user_id = Expression<Int64>("user_id")
        let blocked = Expression<Bool>("is_blocked")
        do {
            let db = try Connection(path, readonly: true)
            for account in try db.prepare(accounts) {
                if (account[user_id] == userId && !account[blocked]) {
                    addToTable(account: account)
                }
            }
        } catch {
            print("error connectng data base")
            return
        }
    }

    func addToTable(account: Row) {
        let accountIdExpression = Expression<Int64>("account_id")
        let accountTypeExpression = Expression<String>("account_type")
        let balanceExpression = Expression<Double>("balance")

        let accountId = account[accountIdExpression]
        let accountType = account[accountTypeExpression]
        let balance = account[balanceExpression]

        // Create a new row for the table
        let newRow = "\(String(accountId)) \(String(accountType)) \(String(balance))$"
        idArray.append(accountId)

        dataSourceArray.append(newRow)

        table.reloadData()
    }



}

extension ViewControllerAccounts: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: accountsCell.identifier, for: indexPath) as! accountsCell
        cell.customLabel.text = dataSourceArray[indexPath.row]
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected:\(idArray[indexPath.row])")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "account") as! ViewControllerAccount
        viewController.accountId = idArray[indexPath.row]
        self.present(viewController, animated: false, completion: nil)
    }
}
