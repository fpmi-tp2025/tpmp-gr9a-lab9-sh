//
//  ViewController.swift
//  BankApp
//
//  Created by Ivan Hontarau on 25.05.25.
//

import UIKit
import SQLite

func copyDatabaseIfNeeded(sourcePath: String) -> Bool {
    let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let destinationPath = documents + "/db.sqlite3"
    let exists = FileManager.default.fileExists(atPath: destinationPath)
    guard !exists else {
        return false
    }
    do {
        try FileManager.default.copyItem(atPath: sourcePath, toPath: destinationPath)
        return true
    } catch {
        print("error during file copy: \(error)")
        return false
    }
}

class ViewController: UIViewController {
    var userId: Int64?
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!

    @IBAction func tryLogin(_ sender: Any) {
        let path = Bundle.main.path(forResource: "db", ofType: "sqlite3")!
        let user_id = Expression<Int64>("user_id")
        let username = Expression<String>("username")
        let password = Expression<String>("password")
        let users = Table("users")
        do {
            let db = try Connection(path, readonly: true)
            let cur_username = usernameField.text
            let cur_password = passwordField.text
            var flag = false
            for user in try db.prepare(users) {
                if (user[username] == cur_username && user[password] == cur_password) {
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)

                    let viewController = storyBoard.instantiateViewController(identifier: "ViewControllerMenu") as! ViewControllerMenu
                    viewController.receivedUserId = user[user_id]
                    self.present(viewController, animated: false, completion: nil)
                    errorLabel.text = ""
                    flag = true
                }
            }
            if (!flag) {
                errorLabel.text = NSLocalizedString("invalid username or password", comment: "")
            }
        } catch {
            print(NSLocalizedString("error connecting to database", comment: ""))
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
