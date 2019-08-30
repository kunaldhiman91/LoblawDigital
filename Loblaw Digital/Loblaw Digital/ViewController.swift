//
//  ViewController.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testNetworkCall()
        // Do any additional setup after loading the view.
    }
    
    
    func testNetworkCall() {
        
        let home = LDHomeServiceRequest()
       
        do {
            try home.requestData(completionHandler: { (isSuccessful, data) in
                if isSuccessful {
                    print("\(String(describing: String(data: data!, encoding: .utf8)))")
                }
                
            })
        } catch let error as BuilderError {
            
            switch error {
            case .unableBuildURL(let message):
                print(message)
                
            case .unableToResolveURL(let url):
                print(url.absoluteString + "faulty")
            }
            
        } catch {
            
        }
        
    }
    
//    func testNetworkCall() {
//
//        let contentFetcher = LDContentFetcher.shared
//        let url = URL(string: "https://1234.com")
//        let urlRequest = URLRequest(url: url!)
//
//
//        contentFetcher.requestContent(request: urlRequest) { (result) in
//            switch result {
//            case .success(let data):
//                print("\(String(describing: String(data: data, encoding: .utf8)))")
//            case .failure(let error):
//
//                let title = "Sorry"
//                var message = ""
//
//                switch (error as LDRequestError) {
//
//                case .encountered404:
//
//                    message = "We are currently in maintainace mode. Please come back later."
//
//                case.otherError(let errorCode):
//
//                    message = "Unable to complete the request. Request error encountered - \(errorCode)"
//
//                }
//
//                self.showNetworkAlert(title: title,
//                                      message: message,
//                                      handler: nil)
//
//            }
//        }
//    }
}

