//
//  ViewController.swift
//  htmlParser
//
//  Created by FE Team TV on 9/6/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import SnapKit
import Kanna

class MainViewController: UIViewController {
    
    var urlField: UITextField!
    var viewWeb: UIWebView!
    var parsField: UITextField!
    var parsedData: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWeb = UIWebView()
        viewWeb.tintColor = UIColor.grayColor()
        viewWeb.delegate = self
        view.addSubview(viewWeb)
        
        parsField = UITextField()
        parsField.backgroundColor = UIColor.grayColor()
        parsField.autocapitalizationType = UITextAutocapitalizationType.None
        parsField.delegate = self
        view.addSubview(parsField)
        
        urlField = UITextField()
        urlField.text = "https://www.discogs.com/sell/list?format=Vinyl"
        urlField.backgroundColor = UIColor.grayColor()
        urlField.delegate = self
        view.addSubview(urlField)
        
        parsedData = UITextView()
        parsedData.backgroundColor = UIColor.grayColor()
        view.addSubview(parsedData)
        
        setupLayout()
       
    }
    
    func setupLayout() {
        
        urlField.snp_makeConstraints { (make) in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-20)
            make.height.equalTo(35)
        }
        
        parsField.snp_makeConstraints { (make) in
            make.top.equalTo(urlField.snp_bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-20)
            make.height.equalTo(35)
        }
        
        viewWeb.snp_makeConstraints { (make) in
            make.top.equalTo(parsField.snp_bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-20)
            make.height.equalTo(400)
        }
        
        parsedData.snp_makeConstraints { (make) in
            make.top.equalTo(viewWeb.snp_bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-20)
            make.height.equalTo(150)
        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }   
    
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if !(parsField.text == "" && urlField.text == "") {
            print("end edit")
            let req = NSURLRequest(URL: NSURL(string: urlField.text!)!)
            viewWeb.loadRequest(req)
        }
    }
}

extension MainViewController : UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let htmlData = webView.stringByEvaluatingJavaScriptFromString("document.documentElement.outerHTML")
        
        if let doc = Kanna.HTML(html: htmlData!, encoding: NSUTF8StringEncoding) {
            print(doc.title)
            var text = ""
            // Search for nodes by CSS
            for link in doc.css("span, class") {
                if link["class"] == parsField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) {
                   text = "\(text) \n \(link.content!)"}
                
            }
            parsedData.text = text
        }
        
       return true
    }

}

