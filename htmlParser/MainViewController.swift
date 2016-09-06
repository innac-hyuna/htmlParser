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
    var parsField1: UITextField!
    var parsedData: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewWeb = UIWebView()
        viewWeb.tintColor = UIColor.grayColor()
        viewWeb.delegate = self
        view.addSubview(viewWeb)
        
        parsField1 = UITextField()
        parsField1.text = "a"
        parsField1.delegate = self
        parsField1.setDesignField(20, borderWidth:1,  borderColor: UIColor.blackColor(), bgColor: UIColor.grayColor())
        view.addSubview(parsField1)
        
        parsField = UITextField()
        parsField.text = "item_description_title"
        parsField.delegate = self
        parsField.setDesignField(20, borderWidth:1,  borderColor: UIColor.blackColor(), bgColor: UIColor.grayColor())
        view.addSubview(parsField)
        
        urlField = UITextField()
        urlField.text = "https://www.discogs.com/sell/list?format=Vinyl"
        urlField.delegate = self
        urlField.setDesignField(20, borderWidth:1,  borderColor: UIColor.blackColor(), bgColor: UIColor.grayColor())
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
        
        parsField1.snp_makeConstraints { (make) in
            make.top.equalTo(urlField.snp_bottom).offset(10)
            make.left.equalTo(view).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        
        parsField.snp_makeConstraints { (make) in
            make.top.equalTo(urlField.snp_bottom).offset(10)
            make.left.equalTo(parsField1.snp_right).offset(10)
            make.width.equalTo(view).offset(-150)
            make.height.equalTo(35)
        }
        
        viewWeb.snp_makeConstraints { (make) in
            make.top.equalTo(parsField.snp_bottom).offset(10)
            make.left.equalTo(view)
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
            for link in doc.css("\(parsField1.text!), class") {
                if link["class"] == parsField.text! {
                   text = "\(text) \n \(link.content!)"}
                
            }
            parsedData.text = text
        }
        
       return true
    }

}

