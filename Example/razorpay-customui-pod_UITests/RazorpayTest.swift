//
//  RazorpayTest.swift
//  razorpay-customui-pod_Tests
//
//  Created by Ramprasad A on 18/04/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest

class RazorpayTest: XCTestCase {
    
    var app : XCUIApplication!
    var entry: FlowEntryScreen!
    var sdkWebViewPage: SDKWebViewPage!
    var successString = "SUCCESS"
    var failureString = "FAILURE"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["-UITests"]    // reserved if you ever want it
        app.launch()
        entry = FlowEntryScreen(app: app)
        sdkWebViewPage = SDKWebViewPage(app: app)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }
    
    
    //MARK: - Helper functions
    
    func successAlertExists() {
        let successAlert = app.alerts[successString]
        XCTAssertTrue(successAlert.waitForExistence(timeout: 10), "SUCCESS alert did not appear")

        // If you just want to check that it mentions a payment id:
        let msgPredicate = NSPredicate(format: "label CONTAINS %@", "Payment Id")
        let messageLabel = successAlert.staticTexts.element(matching: msgPredicate)
        XCTAssertTrue(messageLabel.exists, "Alert message does not contain 'Payment Id'")
    }
    
    func failureAlertExist() {
        let failureAlert = app.alerts[failureString]
        XCTAssertTrue(failureAlert.waitForExistence(timeout: 10), "FAILURE alert did not appear")
    }
    
    
    // MARK: - Net banking test cases
    func testNetBankingSuccessPaymentFlow() throws {
        entry.tapCell(cellName: .netBankingCell)
        sdkWebViewPage.tapSuccessButton()
        successAlertExists()
    }

    
    func testNetBankingFailurePaymentFlow() throws {
        entry.tapCell(cellName: .netBankingCell)
        sdkWebViewPage.tapFailureButton()
        failureAlertExist()
    }
    
    
    
    //MARK: - Pay with Cred
    func testPayWithCredSuccessFlow() throws {
        entry.tapCell(cellName: .payWithCred)
        
        
    }
    
    
    //MARK: - EMI
    func testEMISuccessFlow() throws {
        entry.tapCell(cellName: .emi)
        sdkWebViewPage.tapSuccessButton()
        successAlertExists()
    }
    
    
    func testEMIFailureFlow() throws {
        entry.tapCell(cellName: .emi)
        sdkWebViewPage.tapFailureButton()
        failureAlertExist()
    }
    
    //MARK: - UPI
    func testUPISuccesFlow() throws {
        entry.tapCell(cellName: .upi)
        let textField = app.textFields["Your VPA (someone@abc)"]
        
        if textField.waitForExistence(timeout: 10) {
            textField.tap()
            textField.typeText("success@razorpay")
            let button = app.buttons["PAY ₹1"]
            button.firstMatch.tap()
        }
        successAlertExists()
    }
    
    
    //MARK:  - Wallet Payment
    func testWalletSuccessPaymentFlow() throws {
        entry.tapCell(cellName: .walletPayment)
        sdkWebViewPage.tapSuccessButton()
        successAlertExists()
        
    }
    
    
    func testWalletFailurePaymentFlow() throws {
        entry.tapCell(cellName: .walletPayment)
        sdkWebViewPage.tapFailureButton()
       failureAlertExist()
    }
    

    
    //MARK: - Card test Cases
    func testCardSuccessPaymentFlow() throws {

        // 1. Start the flow
        entry.tapCell(cellName: .cardCell)

        // 2. Wait for SDK WebView
//        sdkWeb.waitForAppear()

        // 3. Drive WebView (minimum necessary taps)
        // Replace "Pay" with the actual visible label
        sdkWebViewPage.tapSuccessButton()

        // test if sucees alert gives payment Id or not
        successAlertExists()
        
    }
    
    
    
    func testCardFailurePaymentFlow() throws {

        // 1. Start the flow
        entry.tapCell(cellName: .cardCell)

        // 2. Wait for SDK WebView
//        sdkWeb.waitForAppear()

        // 3. Drive WebView (minimum necessary taps)
        // Replace "Pay" with the actual visible label
        sdkWebViewPage.tapFailureButton()

        failureAlertExist()

    }

}


