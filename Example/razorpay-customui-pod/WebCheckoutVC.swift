//
//  WebCheckoutVC.swift
//  SampleApp-CustomUI
//
//  Created by Ramprasad A on 20/08/21.
//

import UIKit
import Razorpay
import WebKit

enum PaymentType:String,Codable {
    case fetchSubscription
    case fetchPaymentMethods
    case makePayment
    case externalPaymentEntity
    case makeVASPayment
    case makeCredPayment
    case upiPayment
}

class WebCheckoutVC: UIViewController, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
    var paymentType: PaymentType = .makePayment
    var payload: PayloadModel?
    var razorpay: RazorpayCheckout?
    var wkWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = WKWebViewConfiguration()
//        if #available(iOS 14, *) {
//            configuration.limitsNavigationsToAppBoundDomains = false
//        }
        self.wkWebView = WKWebView(frame: self.view.frame, configuration: configuration)
//        self.wkWebView = WKWebView(frame: .zero)
        self.razorpay = RazorpayCheckout.initWithKey(payload?.key ?? "", andDelegate: self, withPaymentWebView: wkWebView)
        self.wkWebView.navigationDelegate = self
        self.wkWebView.configuration.userContentController.add(self, name: "testController")
        
        self.wkWebView.uiDelegate = self
        self.setConstraintsToWebView()
        self.setRightBarButtonItem()
        self.title = self.payload?.title
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.triggerAppropriatePayment()
    }
}

extension WebCheckoutVC: WKUIDelegate {
    
}

extension WebCheckoutVC: RazorpayPaymentCompletionProtocol {
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]) {
        print(payment_id)
        self.razorpay = nil
        self.displayAlert(title: "SUCCESS", message: "Payment Id \(payment_id)")
    }
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]) {
        self.razorpay = nil
        self.printAsJson(response)
        DispatchQueue.main.async {
            self.displayAlert(title: "FAILURE", message: str)
        }
        print(response)
    }
}

extension WebCheckoutVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.razorpay?.webView(webView, didCommit: navigation)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.razorpay?.webView(webView, didFinish: navigation)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.razorpay?.webView(webView, didFail: navigation, withError: error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.razorpay?.webView(webView, didFailProvisionalNavigation: navigation, withError: error)
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
//        print("loading URL"+(navigationAction.request.url?.absoluteString ?? "nil value"))
//        self.razorpay?.webView(webView, decidePolicyFor: navigationAction)
//        decisionHandler(.allow)
//    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
        print("loading URL"+(navigationAction.request.url?.absoluteString ?? "nil value"))
        if let razorpay = self.razorpay {
            self.razorpay?.webView(webView, decidePolicyFor: navigationAction, handler: decisionHandler)
        }else{
            decisionHandler(.allow)
        }
        
    }
    
}

extension WebCheckoutVC {
    
    func triggerAppropriatePayment() {
        RazorpayCheckout.getAppsWhichSupportUpi{ upiApps in
            print(upiApps)
        }
        self.printAsJson(payload?.options ?? [:])
        switch self.payload?.paymentType {
        case .makeCredPayment:
            if self.isCredAppAvailable() == 1 {
                self.razorpay?.payWithCred(withOptions: payload?.options ?? [:]) { successResponse in
                    print(successResponse)
                    self.displayAlert(title: "Success", message: successResponse.debugDescription)
                } andFailureCallback: { errorResponse in
                    print(errorResponse)
                    self.displayAlert(title: "Error", message: errorResponse)
                }
            } else {
                self.razorpay?.authorize(payload?.options ?? [:])
            }
            
        default:
            self.razorpay?.authorize(payload?.options ?? [:])
        }
    }
    
    func displayAlert(title:String,message:String) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            [weak self](action) in
            self?.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func printAsJson(_ dict: [AnyHashable: Any]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            print(decoded)
        } catch (let e) {
            print(e)
        }
    }
    
    func setConstraintsToWebView() {
        
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(wkWebView)
        
        let safeAreaGuides = self.view.safeAreaLayoutGuide
        let topConstraint = wkWebView.topAnchor.constraint(equalTo: safeAreaGuides.topAnchor)
        let bottomConstraint = wkWebView.bottomAnchor.constraint(equalTo: safeAreaGuides.bottomAnchor)
        let leadingConstraint = wkWebView.leadingAnchor.constraint(equalTo: safeAreaGuides.leadingAnchor)
        let trailingConstraint = wkWebView.trailingAnchor.constraint(equalTo: safeAreaGuides.trailingAnchor)
        NSLayoutConstraint.activate([topConstraint,bottomConstraint,leadingConstraint,trailingConstraint])
    }
    
    func setRightBarButtonItem() {
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelPaymentByUser))
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc
    func handleCancelPaymentByUser() {
        let alertController = UIAlertController(title: "Cancel Transaction", message: "Are you sure you want to cancel the current transaciton ? You will be taken back to checkout page, where you can choose another payment option", preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Do Not Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let okayAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { action in
            self.razorpay?.userCancelledPayment()
            self.displayAlert(title: "FAILURE", message: "User Cancelled Payment")
            self.razorpay = nil
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
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

