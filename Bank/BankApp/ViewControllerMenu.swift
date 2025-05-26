//
//  ViewControllerMenu.swift
//  BankApp
//
//  Created by Ivan Hontarau on 25.05.25.
//



import UIKit

class ViewControllerMenu: UIViewController {
    var receivedUserId: Int64?

    @IBAction func openConverter(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = storyBoard.instantiateViewController(identifier: "converter")
        self.present(viewController, animated: false, completion: nil)
    }

    @IBAction func openMap(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = storyBoard.instantiateViewController(identifier: "map")
        self.present(viewController, animated: false, completion: nil)
    }

    @IBAction func openTable(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        if let viewController = storyBoard.instantiateViewController(identifier: "accounts") as? ViewControllerAccounts {
            viewController.userId = receivedUserId
            self.present(viewController, animated: false, completion: nil)
        } else {
            print("Failed to instantiate ViewControllerAccounts with identifier 'accounts'")
        }
    }


    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let receivedUserId = receivedUserId {
            print("Received user id: \(receivedUserId)")
        } else {
            print("User id not received")
        }
    }


    // MARK: - Navigation

}
