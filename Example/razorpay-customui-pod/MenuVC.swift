//
//  MenuVC.swift
//  SampleApp-CustomUI
//
//  Created by Ramprasad A on 20/08/21.
//

import UIKit
import Razorpay

struct PayloadModel {
    var title: String
    var options: [String: Any]
//    var key: String = "rzp_live_JbQIqxBRizNPmu"
    var key: String = "rzp_test_1DP5mmOlF5G5ag"
//    var key: String = "rzp_live_partner_Jgy1T7ZabnnFB1"
//    var key: String = "rzp_live_5W8oZPBNQPbZDE"
//    var key: String = "rzp_live_INaX9xm2rADfMM"
    var paymentType: PaymentType
}
    
class MenuVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var payloadArray: [PayloadModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            print("Bundle Identifier: \(bundleIdentifier)")
        } else {
            print("Could not retrieve bundle identifier.")
        }
        guard let dynamicFlowLayout = self.collectionView.collectionViewLayout as? DynamicHeightFlowLayout else{
            assertionFailure("could not get flow layout instance")
            return
        }
        dynamicFlowLayout.delegate = self
        self.populateDataSource()
        
        RazorpayCheckout.getAppsWhichSupportUpi { upiApps in
            debugPrint(upiApps)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Razorpay CustomUI"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MenuVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.payloadArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        menuItemCell.setData(model: self.payloadArray[indexPath.row])
        return menuItemCell
    }
}

extension MenuVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.title = ""
        if let webVC = storyboard.instantiateViewController(identifier: "WebCheckoutVC") as? WebCheckoutVC {
            
            webVC.payload = self.payloadArray[indexPath.row]
            
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
}

extension MenuVC {
    
    func populateDataSource() {

        var cardPaymentDict: [String : Any] = [:]
            
        cardPaymentDict = [
            "amount": "100",
            "currency": "INR",
            "email": "vivek.shindhe@razorpay.com",
            "contact": "9999912345",
            "method": "card",
            "card[name]": "Test User",
            "card[number]": "4386289407660153",
            "card[expiry_month]": "11",
            "card[expiry_year]": "32",
            "card[cvv]": "123",
            "display_logo": false
        ]
        self.payloadArray = [PayloadModel(title: "Card Payment", options: cardPaymentDict, paymentType: .makePayment)]
        cardPaymentDict = [:]
        
        cardPaymentDict = [
            "amount": "100",
            "currency": "INR",
            "email": "ramprasad179@gmail.com",
            "contact": "9663976539",
            "app_present": isCredAppAvailable(),
            "method": "app",
            "provider": "cred"
        ]
        if (isCredAppAvailable() == 1) {
            cardPaymentDict["callback_url"] = "razorpay://"
        }
        
        self.payloadArray += [PayloadModel(title: "Pay with Cred", options: cardPaymentDict, paymentType: .makeCredPayment)]
        cardPaymentDict = [:]
        
        cardPaymentDict = [
            "amount": "100",
            "currency": "INR",
            "email": "a@b.com",
            "contact": "1234567890",
            "method": "netbanking",
            "bank": "UTIB",
        ]
        
        self.payloadArray += [PayloadModel(title: "Net Banking", options: cardPaymentDict, paymentType: .makePayment)]
        cardPaymentDict = [:]
        
        cardPaymentDict = [
            "amount": "100",
            "currency": "INR",
            "email": "a@b.com",
            "contact": "9731585653",
            "method": "wallet",
            "wallet": "olamoney",
        ]
        
        self.payloadArray += [PayloadModel(title: "Wallet Payment", options: cardPaymentDict, paymentType: .makePayment)]
        cardPaymentDict = [:]
        
        cardPaymentDict = [
            "amount": "100",
            "currency": "INR",
            "email": "a@b.com",
            "contact": "123456789",
            "method": "emi",
            "card[name]": "Test User",
            "card[number]": "4386289407660153",
            "card[expiry_month]": "11",
            "card[expiry_year]": "28",
            "emi_duration": "12",
        ]
        
        self.payloadArray += [PayloadModel(title: "EMI", options: cardPaymentDict, paymentType: .makePayment)]
        cardPaymentDict = [:]
        
        cardPaymentDict = /*[
            "amount": 100, // amount in currency subunits. Defaults to INR. 100 = 100 paise = INR 1.
            "currency": "INR",
            "email": "ramprasad179@gmail.com",
            "contact": "9663976539",
            "method": "upi",
            "vpa":"9663976539@ybl",
            "_[flow]": "intent",
            "upi_app_package_name": "phonepe",
        ] */
        
        
        [
            
            
                "currency":"MYR",
                "amount":"100",
                "email":"test@razorpay.com",
                "contact":"9999999999",
                "method":"fpx",
                "bank":"AGOB"
                
            
        ]
//        [
//                    "amount": 100, // amount in currency subunits. Defaults to INR. 100 = 100 paise = INR 1.
//                    "currency": "INR",
//                    "email": "gaurav.kumar@example.com",
//                    "contact": "9090980808",
////                    "order_id": "order_DBJOWzybf0sJbb",
//                    "method": "upi",
////                    "_[flow]": "intent",
////                    "upi_app_package_name": "phonepe",
//                    "vpa": "success@razorpay" // Optional Parameter
//                ]
        self.payloadArray += [PayloadModel(title: "UPI", options: cardPaymentDict, paymentType: .makePayment)]
        cardPaymentDict = [:]
    }
    
}

extension MenuVC: DynamicHeightFlowLayoutDelegate {
    
    func heightForItem(at indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        switch indexPath.item {
        case 0 :
            height = 170
        case 1 :
            height = 150
        case 2 :
            height = 200
        case 3 :
            height = 250
        case 4 :
            height = 379
        case 5 :
            height = 253
        case 6 :
            height = 192
        case 7 :
            height = 300
        case 8 :
            height = 125
        default :
            height = 100
        }
        return height
    }
}

extension MenuVC {
    
    /// This checks if app is available in the device or not.
    private func isCredAppAvailable() -> Int {
        let credURIScheme = "credpay://" // This will open CRED URL.
        if let urlString = credURIScheme.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let credURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(credURL) {
                    return 1
                }
            }
        }
        return 0
    }
}
