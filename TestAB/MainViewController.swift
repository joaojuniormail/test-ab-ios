//
//  ViewController.swift
//  TestAB
//
//  Created by João Batista da Silva Junior - JBT on 17/06/21.
//

import UIKit
import Alamofire
import VWO

class MainViewController: UIViewController {
    
    var mainView: MainView {
        return self.view as! MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.enterButtonAction = self.onEnterButtonTouch
        self.mainView.buyButtonAction = self.onBuyButtonTouch
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.checkLastVersionApp()
    }
    
    override func loadView() {
        self.view = MainView()
    }
    
    func onEnterButtonTouch(){
        print("Enter button")
    }
    
    func onBuyButtonTouch(){
        let venda = Double.random(in: 10..<500);
        print("Buy button. Venda: \(venda)")
        VWO.trackConversion("meta_venda", value: venda)
    }
    
    func checkLastVersionApp(){
        AF.request("https://apps.apple.com/br/app/id1168148250")
            .responseString { response in
                var htmlDocument:String = ""
                if let html = try? response.result.get() {
                    htmlDocument = html
                }
                let regex = try? NSRegularExpression(pattern: "(whats-new__latest__version\">)(.*?)(</p>)")
                var version = regex?.matches(in: htmlDocument, range: NSMakeRange(0, 4))
                print(htmlDocument)
            }
    }
    
    
    
}

