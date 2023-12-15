//
//  ViewController.swift
//  TelrSDK
//
//  Created by Telr Sdk on 10/02/2020.
//  Copyright (c) 2020 Telr Sdk. All rights reserved.
//

import UIKit
import TelrSDK
import WebKit
class ViewController: UIViewController {
    
    
    @IBOutlet weak var jsFrameStack: UIStackView!
   
    @IBOutlet weak var webviewStack: UIStackView!
    
    var seamless = false
    
    @IBOutlet weak var jsframeBackView: UIView!
    let tabbyKEY:String = "<tabby_key>"
    

    let KEY:String = "<<AuthKey>>"// TODO fill key
    
    let STOREID:String = "<<Store ID>>" // TODO fill store id
    
    let EMAIL:String = "<<email_id>>" // TODO fill email id
    

    var paymentRequest:PaymentRequest?
    
    @IBOutlet var payBtn: UIButton!
    @IBOutlet var paylaterButton: UIButton!
    @IBOutlet var installmentsButton: UIButton!
   
    @IBOutlet var tabbyButtonSv: UIStackView!
    @IBOutlet var showCardBtn: UIButton!
    @IBOutlet var cardSv: UIStackView!
    @IBOutlet var amountTxt: UITextField!
    @IBOutlet var firstNameTxt: UITextField!
    @IBOutlet var lastNameTxt: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardDetailsArray : [TelrResponseModel] = []
    
    @IBAction func showcardbtnPressed(_ sender: Any) {
        
        if(cardSv.isHidden == true){
            cardSv.isHidden = false
            showCardBtn.setTitle("Hide telr cards",for: .normal)
        }else{
            cardSv.isHidden = true
            showCardBtn.setTitle("Show telr stored cards",for: .normal)
        }
    }
    var cardToken = ""
    @IBAction func payWithJSCardTokenBtnPressed(_ sender: Any) {
        if((self.amountTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter amount", type: "Error")
        }else if((self.firstNameTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter first name", type: "Error")
        }else if((self.lastNameTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter last name", type: "Error")
        }else {
            if(cardToken==""){
                self.showAlert(message: "Please enter card details", type: "Error")
            }else{
                //Mark:-If you what change the back button as custome back button on navigation
                let customBackButton = UIButton(type: .custom)
                customBackButton.setTitle("Back", for: .normal)
                customBackButton.setTitleColor(.black, for: .normal)
            
                paymentRequest = preparePaymentRequestJSSDK(cardToken: self.cardToken)
                let telrController = TelrController()
                telrController.delegate = self
                telrController.customBackButton = customBackButton
                telrController.paymentRequest = paymentRequest!
                self.navigationController?.pushViewController(telrController, animated: true)
            }
        }
    }
    @IBAction func payWithTabbyBtnPressed(_ sender: Any) {
        if(tabbyButtonSv.isHidden == true){
            tabbyButtonSv.isHidden = false
            
        }else{
            tabbyButtonSv.isHidden = true
           
            
        }
        
    }
    func getTabbyBody() -> String {
        let body = """
        {
          "payment": {
              "amount": 1000,
              "buyer": {
                "dob": "1987-10-20",
                "email": "successful.payment@tabby.ai",
                "name": "John Doe",
                "phone": "+971500000001"
              },
              "buyer_history": {
                "loyalty_level": 10,
                "registered_since": "2019-10-05T17:45:17+00:00",
                "wishlist_count": 421
              },
              "currency": "AED",
              "description": "Tabby Store Order #3",
              "order": {
                "items": [
                  {
                    "description": "To be displayed in Tabby order information",
                    "product_url": "https://tabby.store/p/SKU123",
                    "quantity": 1,
                    "reference_id": "SKU123",
                    "title": "Sample Item #1",
                    "unit_price": "300"
                  },
                  {
                    "description": "To be displayed in Tabby order information",
                    "product_url": "https://tabby.store/p/SKU124",
                    "quantity": 1,
                    "reference_id": "SKU124",
                    "title": "Sample Item #2",
                    "unit_price": "600"
                  }
                ],
                "reference_id": "xxxx-xxxxxx-xxxx",
                "shipping_amount": "50",
                "tax_amount": "50"
              },
              "order_history": [
                {
                  "amount": "\(self.amountTxt.text ?? "0")",
                  "buyer": {
                    "name": "\(self.firstNameTxt.text ?? "") \(self.lastNameTxt.text ?? "")",
                    "phone": "+971-505-5566-33"
                  },
                  "items": [
                    {
                      "quantity": 4,
                      "title": "Sample Item #3",
                      "unit_price": "250",
                      "reference_id": "item-sku",
                      "ordered": 4,
                      "captured": 4,
                      "shipped": 4,
                      "refunded": 1
                    }
                  ],
                  "payment_method": "CoD",
                  "purchased_at": "2019-10-05T18:45:17+00:00",
                  "shipping_address": {
                    "address": "Sample Address #1",
                    "city": "Dubai"
                  },
                  "status": "complete"
                }
              ],
              "shipping_address": {
                "address": "Sample Address #2",
                "city": "Dubai"
              }
          }
        }
        """
        return body
    }
    @IBAction func paylaterButtonAction() {
        
        if((self.amountTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter amount", type: "Error")
        }else if((self.firstNameTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter first name", type: "Error")
        }else if((self.lastNameTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter last name", type: "Error")
        }else {
            Chekout().getCheckoutSession(apikey: tabbyKEY,productType:"pay_later", body: getTabbyBody()) { (isProductType, session) in
                DispatchQueue.main.async {
                    if(isProductType) {
                        
                        if(session != nil ){
                            
                            let customBackButton = UIButton(type: .custom)
                            customBackButton.setTitle("Back", for: .normal)
                            customBackButton.setTitleColor(.black, for: .normal)
                            let tabbyController = TabbyController()
                            tabbyController.productType = "pay_later"
                            tabbyController.session = session
                            tabbyController.delegate = self
                            tabbyController.apiKey = self.tabbyKEY
                            tabbyController.customBackButton = customBackButton
                            self.navigationController?.pushViewController(tabbyController, animated: true)
                            
                            }
                        
                        
                    }
                }
                
            }
        }
        

    }
    
    @IBAction func installmentsButtonAction() {
        
        if((self.amountTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter amount", type: "Error")
        }else if((self.firstNameTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter first name", type: "Error")
        }else if((self.lastNameTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter last name", type: "Error")
        }else {
            Chekout().getCheckoutSession(apikey: tabbyKEY,productType:"installments", body: getTabbyBody()) { (isProductType, session) in
                DispatchQueue.main.async {
                    if(isProductType) {
                        
                        if(session != nil ){
                            
                                let tabbyController = TabbyController()
                                tabbyController.productType = "installments"
                                tabbyController.session = session
                                tabbyController.delegate = self
                                tabbyController.apiKey = self.tabbyKEY
                                //self.navigationController?.pushViewController(tabbyController, animated: true)
                                let nav = UINavigationController(rootViewController: tabbyController)
                                self.navigationController?.present(nav, animated: true, completion: nil)
                            }
                        
                        
                    }
                }
        }
        
       
            
        }
        
        
    }
    @IBAction func payBtnPressed(_ sender: Any) {
        
        if((self.amountTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter amount", type: "Error")
        }else if((self.firstNameTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter first name", type: "Error")
        }else if((self.lastNameTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter last name", type: "Error")
        }else {
            //Mark:-If you what change the back button as custome back button on navigation
            let customBackButton = UIButton(type: .custom)
            customBackButton.setTitle("Back", for: .normal)
            customBackButton.setTitleColor(.black, for: .normal)
        
            paymentRequest = preparePaymentRequest()
            
            let telrController = TelrController()
            telrController.delegate = self
            telrController.customBackButton = customBackButton
            telrController.paymentRequest = paymentRequest!
            self.navigationController?.pushViewController(telrController, animated: true)
        }
    }
    
   

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        logoContainer.addSubview(imageView)
        self.navigationItem.titleView = logoContainer
        self.setupToHideKeyboardOnTapOnView()
        self.displaySavedCard()
        
        paylaterButton.setTitleColor(.black, for: .normal)
        paylaterButton.backgroundColor = UIColor(red:0.24, green:0.93, blue:0.75, alpha:1.0)
        installmentsButton.setTitleColor(.black, for: .normal)
        installmentsButton.backgroundColor = UIColor(red:0.24, green:0.93, blue:0.75, alpha:1.0)
        
        self.jsFrameStack.isHidden = !self.seamless
        self.webviewStack.isHidden = self.seamless
        self.cardSv.isHidden = self.seamless
        if(self.seamless){
            self.loadJSFrame()
        }
    }
    override func viewDidLayoutSubviews() {
        webView?.frame = self.jsframeBackView?.bounds ?? CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    var webView : WKWebView!
    
    func loadJSFrame()  {
        
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: self.jsframeBackView.bounds, configuration: config)
        webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.alwaysBounceHorizontal = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.isDirectionalLockEnabled = true
        self.jsframeBackView.addSubview(webView)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        let currency = "AED"
        let mode = "1"
        let temp = PaymentRequest()
        temp.store = self.STOREID
        temp.transTest = mode
        temp.key = self.KEY
        temp.api_custref = "12344"
        temp.getCardsinfo() { (cardDetails) in
            let urlString = "https://secure.telr.com/jssdk/v2/token_frame.html?sdk=ios&store_id=\(self.STOREID)&currency=\(currency)&test_mode=\(mode)&saved_cards=\(cardDetails.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) ?? "")"
            
            
            print("urlString \(urlString)")
            if let url = URL(string:urlString) {
                print(url)
                DispatchQueue.main.async {
                    self.webView.load(URLRequest(url: url))
                }
            }
        }
    }
    
    
    private func displaySavedCard() {
        let savedCard = TelrResponseModel().getSavedCards()
        self.cardDetailsArray = savedCard
        if(savedCard.count == 0){
             
            showCardBtn.isHidden = true
            cardSv.isHidden = true
            showCardBtn.setTitle("Show telr stored cards",for: .normal)
            
         }else{
            
            showCardBtn.isHidden = false
            cardSv.isHidden = false
            showCardBtn.setTitle("Hide telr cards",for: .normal)
            
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    private func showAlert(message:String,type:String){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               
                let alert = UIAlertController(title: type, message: message, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           
                self.present(alert, animated: true, completion: nil)
                
            }
           
        }
    
}




//Mark:- Payment Request Builder
extension ViewController:TelrControllerDelegate{
    
    
    //Mark:- This method call when user click on back button
    func didPaymentCancel() {
        print("didPaymentCancel")
        self.showAlert(message: "didPaymentCancel", type: "Cancel")
    }
    
    //Mark:- This method call when payment done successfully
    func didPaymentSuccess(response: TelrResponseModel) {
        
        print("didPaymentSuccess")
           
        print("month \(String(describing: response.month))")
        
        print("year \(String(describing: response.year))")
        
        print("Trace \(String(describing: response.trace))")
        print("Trace \(String(describing: response.trace))")
        
        print("Status \(String(describing: response.status))")
        
        print("Avs \(String(describing: response.avs))")
        
        print("Code \(String(describing: response.code))")
        
        print("Ca_valid \(String(describing: response.ca_valid))")
        
        print("Card Code \(String(describing: response.cardCode))")
        
        print("Card Last4 \(String(describing: response.cardLast4))")
        
        print("CVV \(String(describing: response.cvv))")
        
        print("TransRef \(String(describing: response.transRef))")
        
        //For save the card you need to store tranRef and when you are going to make second trans using thistranRef
        if !seamless {
            self.displaySavedCard()
        }
        self.showAlert(message: "didPaymentSuccess\n month \(String(describing: response.month))\nyear \(String(describing: response.year))\nTrace \(String(describing: response.trace))\nStatus \(String(describing: response.status))\nAvs \(String(describing: response.avs))\nCode \(String(describing: response.code))\nCa_valid \(String(describing: response.ca_valid))\nCard Code \(String(describing: response.cardCode))\nCard Last4 \(String(describing: response.cardLast4))\nCard Last4 \(String(describing: response.cardLast4))\nCVV \(String(describing: response.cvv))\nTransRef \(String(describing: response.transRef))", type: "Success")
      
    }
    
    //Mark:- This method call when user click on cancel button and if payment get failed
    func didPaymentFail(messge: String) {
        print("didPaymentFail")
        self.showAlert(message: "didPaymentFail \(messge)", type: "Fail")
    }
        
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardDetailsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        let model = self.cardDetailsArray[indexPath.item]
        
        cell.holderNameLbl.text = "\(model.billingFName ?? "") \(model.billingLName ?? "")"
        cell.validtrrought.text = "Valid : \(model.month ?? "")/\(model.year ?? "")"
        cell.cardNumberLbl.text = " **** **** **** \(model.cardLast4 ?? "")"
        cell.payBtn.tag = indexPath.item
        cell.payBtn.addTarget(self, action: #selector(payBtnPressed), for: .touchUpInside)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    @objc func payBtnPressed(btn:UIButton){
        if((self.amountTxt.text ?? "").isEmpty){
            self.showAlert(message: "Enter amount", type: "Error")
        }else{
            let cardDetails = self.cardDetailsArray[btn.tag]
            paymentRequest = preparePaymentRequestSaveCard(lastresponse: cardDetails)
            let telrController = TelrController()
            telrController.delegate = self
            telrController.paymentRequest = paymentRequest!
            let nav = UINavigationController(rootViewController: telrController)
            self.navigationController?.present(nav, animated: true, completion: nil)
        }
        
    }
    
}

//Mark:- Payment Request Builder
extension ViewController{
    
    private func preparePaymentRequestJSSDK(cardToken:String) -> PaymentRequest{
    
    
        let paymentReq = PaymentRequest()
    
        paymentReq.key = KEY
   
        paymentReq.api_custref = "12344" // send user logged user id here
        
        paymentReq.store = STOREID
    
        paymentReq.appId = "123456789"
   
        paymentReq.appName = "TelrSDK"
    
        paymentReq.appUser = "123456"
    
        paymentReq.appVersion = "0.0.1"
    
        paymentReq.transTest = "1"//1"//0
   
        paymentReq.transType = "paypage"
   
        paymentReq.transClass = "ecom"
    
        paymentReq.transCartid = String(arc4random())
    
        paymentReq.transDesc = "Test API"
    
        paymentReq.transCurrency = "AED"
    
       paymentReq.transAmount = self.amountTxt.text!
    
        paymentReq.billingEmail = EMAIL
       
        paymentReq.billingPhone = "8888888888"
    
        paymentReq.billingFName = self.firstNameTxt.text!
    
        paymentReq.billingLName = self.lastNameTxt.text!
    
        paymentReq.billingTitle = "Mr"
    
        paymentReq.city = "Dubai"
    
        paymentReq.country = "AE"
    
        paymentReq.region = "Dubai"
    
        paymentReq.address = "line 1"
       
        paymentReq.zip = "414202"
    
        paymentReq.language = "en"
        
        paymentReq.cardToken = cardToken
    
        return paymentReq

    }
    
    private func preparePaymentRequest() -> PaymentRequest{
    
    
        let paymentReq = PaymentRequest()
    
     
        paymentReq.key = KEY
   
        paymentReq.store = STOREID
        
        paymentReq.api_custref = "12344"
    
        paymentReq.appId = "123456789"
   
        paymentReq.appName = "TelrSDK"
    
        paymentReq.appUser = "123456"
    
        paymentReq.appVersion = "0.0.1"
    
        paymentReq.transTest = "1"//1"//0
   
        paymentReq.transType = "paypage"
   
        paymentReq.transClass = "ecom"
    
        paymentReq.transCartid = String(arc4random())
    
        paymentReq.transDesc = "Test API"
    
        paymentReq.transCurrency = "AED"
    
        paymentReq.transAmount = amountTxt.text!
    
        paymentReq.billingEmail = EMAIL
       
        paymentReq.billingPhone = "8888888888"
    
        paymentReq.billingFName = self.firstNameTxt.text!
    
        paymentReq.billingLName = self.lastNameTxt.text!
    
        paymentReq.billingTitle = "Mr"
    
        paymentReq.city = "Dubai"
    
        paymentReq.country = "AE"
    
        paymentReq.region = "Dubai"
    
        paymentReq.address = "line 1"
    
        paymentReq.language = "en"
        
//        Repeat billing
        paymentReq.repeat_amount = "1"
        paymentReq.repeat_interval = "1"
        paymentReq.repeat_period = "M"
        paymentReq.repeat_term = "3"
        paymentReq.repeat_final = ""
        paymentReq.repeat_start = "28072023"
        
//        Split Payment ID
        paymentReq.split_id = "105"
    
        return paymentReq

    }



    private func preparePaymentRequestSaveCard(lastresponse:TelrResponseModel) -> PaymentRequest{

     
        let paymentReq = PaymentRequest()
     
        paymentReq.key = lastresponse.key ?? ""
        
       
        paymentReq.store = lastresponse.store ?? ""
     
        paymentReq.appId = lastresponse.appId ?? ""
     
        paymentReq.appName = lastresponse.appName ?? ""
     
        paymentReq.appUser = lastresponse.appUser ?? ""
     
        paymentReq.appVersion = lastresponse.appVersion ?? ""
     
        paymentReq.transTest = lastresponse.transTest ?? ""
        
//        //Mark:- Without CVV
//
//        paymentReq.transType = "sale"
//
//        paymentReq.transClass = "cont"
        
//        paymentReq.transRef = lastresponse.transRef ?? ""
        
        
        //Mark:- With CVV

        paymentReq.transType = "paypage"

        paymentReq.transClass = "ecom"
        
        paymentReq.transFirstRef = lastresponse.transFirstRef ?? ""
        
        //
        
        paymentReq.transCartid = String(arc4random())
     
        paymentReq.transDesc = lastresponse.transDesc ?? ""
     
        paymentReq.transCurrency = lastresponse.transCurrency ?? ""
     
        paymentReq.billingFName = lastresponse.billingFName ?? ""
     
        paymentReq.billingLName = lastresponse.billingLName ?? ""
     
        paymentReq.billingTitle = lastresponse.billingTitle ?? ""
     
        paymentReq.city = lastresponse.city ?? ""
     
        paymentReq.country = lastresponse.country ?? ""
     
        paymentReq.region = lastresponse.region ?? ""
     
        paymentReq.address = lastresponse.address ?? ""
        
        paymentReq.zip = lastresponse.zip ?? ""
        
     
        paymentReq.transAmount = amountTxt.text!
            
        paymentReq.billingEmail = lastresponse.billingEmail ?? ""
        
        paymentReq.billingPhone = lastresponse.billingPhone ?? ""
     
        paymentReq.language = "en"
     
        return paymentReq

     }
}


class Cell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    
    
    @IBOutlet weak var validtrrought: UILabel!
    
    @IBOutlet weak var holderNameLbl: UILabel!
    
    @IBOutlet weak var cardNumberLbl: UILabel!
    
    @IBOutlet weak var payBtn: UIButton!
    
    
}


extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}




extension ViewController:TabbyControllerDelegate{
   
    //Mark:- This method call when user click on back button
    func didTabbyPaymentCancel() {
        print("didPaymentCancel")
        self.showAlert(message: "didPaymentCancel", type: "Cancel")
    }
    
    //Mark:- This method call when payment done successfully
    func didTabbyPaymentSuccess(response: [String : Any]?) {
        
        print("didPaymentSuccess\(response!)")
       
        self.showAlert(message: "didPaymentSuccess", type: "Success")
      
    }
    
    //Mark:- This method call when user click on cancel button and if payment get failed
    func didTabbyPaymentFail(messge: String) {
        print("didPaymentFail")
        self.showAlert(message: "didPaymentFail \(messge)", type: "Fail")
    }
        
}

extension ViewController : WKNavigationDelegate, WKUIDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
       print("decidePolicyFor navigationAction")
       print("6     =\(webView.url!)")
       decisionHandler(.allow)

    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if let urlString = webView.url?.relativeString {
            print("Url = \(urlString)")
            if ((urlString.contains("telr://internal?payment_token="))){
                let cardToken = urlString.replacingOccurrences(of: "telr://internal?payment_token=", with: "")
                print("Url = \(cardToken)")
                self.cardToken = cardToken
            }else{
                self.cardToken = ""
            }
        }else{
            self.cardToken = ""
        }



    }
}
