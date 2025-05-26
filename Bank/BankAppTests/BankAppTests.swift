//
//  BankAppTests.swift
//  BankAppTests
//
//  Created by Ivan Hontarau on 25.05.25.
//

import XCTest
@testable import BankApp

final class BankAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - ViewController Tests
    
    
    // MARK: - ViewControllerMenu Tests
    
    func testMenuViewControllerInitialization() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC = storyboard.instantiateViewController(identifier: "ViewControllerMenu") as? ViewControllerMenu
        
        XCTAssertNotNil(menuVC)
        menuVC?.loadViewIfNeeded()
    }
    
    func testMenuViewControllerUserIdStorage() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC = storyboard.instantiateViewController(identifier: "ViewControllerMenu") as! ViewControllerMenu
        
        let testUserId: Int64 = 123
        menuVC.receivedUserId = testUserId
        
        XCTAssertEqual(menuVC.receivedUserId, testUserId)
    }
    
    // MARK: - ViewControllerAccounts Tests
    
    func testAccountsViewControllerInitialization() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let accountsVC = storyboard.instantiateViewController(identifier: "accounts") as? ViewControllerAccounts
        
        XCTAssertNotNil(accountsVC)
        accountsVC?.loadViewIfNeeded()
        
        XCTAssertNotNil(accountsVC?.table)
        XCTAssertEqual(accountsVC?.dataSourceArray.count, 0)
        XCTAssertEqual(accountsVC?.idArray.count, 0)
    }
    
    // MARK: - ViewControllerConverter Tests
    
    func testConverterViewControllerInitialization() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let converterVC = storyboard.instantiateViewController(identifier: "converter") as? ViewControllerConverter
        
        XCTAssertNotNil(converterVC)
        converterVC?.loadViewIfNeeded()
        
        XCTAssertNotNil(converterVC?.inputCurrency)
        XCTAssertNotNil(converterVC?.outputCurrency)
        XCTAssertNotNil(converterVC?.inputField)
        XCTAssertNotNil(converterVC?.outputField)
    }
    
    func testCurrencyConversionModel() throws {
        let testRates = ["USD": 1.0, "EUR": 0.85, "RUB": 75.0]
        let conversion = ViewControllerConverter.CurrencyConversion(rates: testRates)
        
        XCTAssertEqual(conversion.rates["USD"], 1.0)
        XCTAssertEqual(conversion.rates["EUR"], 0.85)
        XCTAssertEqual(conversion.rates["RUB"], 75.0)
    }
    
    // MARK: - Custom Cells Tests
    
    func testAccountsCellIdentifier() throws {
        XCTAssertEqual(accountsCell.identifier, "accountsCell")
    }
    
    func testAccountsCellNib() throws {
        let nib = accountsCell.nib()
        XCTAssertNotNil(nib)
        
        let objects = nib.instantiate(withOwner: nil, options: nil)
        XCTAssertTrue(objects.count > 0)
        XCTAssertTrue(objects.first is accountsCell)
    }
    
    func testAccountDataCellIdentifier() throws {
        XCTAssertEqual(acountDataCell.identifier, "acountDataCell")
    }
    
    func testAccountDataCellNib() throws {
        let nib = acountDataCell.nib()
        XCTAssertNotNil(nib)
        
        let objects = nib.instantiate(withOwner: nil, options: nil)
        XCTAssertTrue(objects.count > 0)
        XCTAssertTrue(objects.first is acountDataCell)
    }
    
    // MARK: - Helper Functions Tests
    
    func testDatabaseCopyFunction() throws {
        let tempDir = NSTemporaryDirectory()
        let sourcePath = tempDir + "test_db.sqlite3"
        
        // Create test file
        let testData = "test database".data(using: .utf8)!
        FileManager.default.createFile(atPath: sourcePath, contents: testData, attributes: nil)
        
        // Test copy function
        let result = copyDatabaseIfNeeded(sourcePath: sourcePath)
        
        // Clean up
        try? FileManager.default.removeItem(atPath: sourcePath)
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        try? FileManager.default.removeItem(atPath: documents + "/db.sqlite3")
        
        XCTAssertTrue(result)
    }

}
