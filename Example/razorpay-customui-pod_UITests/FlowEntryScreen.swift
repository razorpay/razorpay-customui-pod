//
//  FlowEntryScreen.swift
//  razorpay-customui-pod
//
//  Created by Vivek Rajesh Shindhe on 03/12/25.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest

final class FlowEntryScreen {
    private let app : XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }

    
    func tapCell(cellName: CellNameType) {
        let cell = app.cells[cellName.rawValue].otherElements.firstMatch
        XCTAssertTrue(cell.exists)
        cell.tap()
    }
    
    
    // MARK: - Enums
    enum CellNameType: String {
        case cardCell = "Card Payment"
        case netBankingCell = "Net Banking"
        case payWithCred = "Pay with Cred"
        case walletPayment = "Wallet Payment"
        case upi = "UPI"
        case emi = "EMI"
    }
}
