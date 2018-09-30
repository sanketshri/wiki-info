//
//  Detail_VC.swift
//  Wiki-Info
//
//  Created by Sanket on 30/09/18.
//  Copyright © 2018 Developer Sanket. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class Detail_VC : UIViewController,UIDocumentInteractionControllerDelegate{


var pageId : Int?
let webView = WKWebView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
    super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    showDetail()

}

func showDetail(){

    let url: URL! = URL(string:"https://en.wikipedia.org/?curid=\(pageId!)")
    print(url)
    let res = webView.load(URLRequest(url: url))
    print(res)

    if res != nil {
        view.addSubview(webView)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
  }
}

