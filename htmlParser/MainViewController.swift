//
//  ViewController.swift
//  htmlParser
//
//  Created by FE Team TV on 9/6/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
import Alamofire
import Kanna

class MainViewController: UIViewController {
    
    var rowCount = 9
    var urlString = "https://www.discogs.com/sell/item/"
    var lists : Results<RowDataRealm>!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(DataRealmTVCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.grayColor()
        view.addSubview(tableView)
        parseHTML(1)
        setupLayout()
    }    
    
    func setupLayout() {

        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-20)
            make.height.equalTo(view)
        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readTasksAndUpdateUI(){
        lists = uiRealm.objects(RowDataRealm)
        self.tableView.setEditing(false, animated: true)
        self.tableView.reloadData()
    }
    
    func parseHTML(i: Int) {
        Alamofire.request(.GET, "\(urlString)\(i)").responseString { [unowned self] response in
          if response.result.isSuccess {
            if let doc = Kanna.HTML(html: response.result.value!, encoding: NSUTF8StringEncoding) {
            var text = ""
            var price = ""
            var label = ""
            var format = ""
            var country = ""
            var released = ""
            var genre = ""
            // Search for nodes by CSS
            for link in doc.css("span") {
                if link["itemprop"] == "name" && (link["title"] != nil || link.content != nil) {
                    text = link["title"] ?? link.content! }
                
                if link["class"] == "price" {
                    price =  link.content!
                }
                
             }
                
             var linkBefore = ""
                
             for link in doc.css("div") {
                
                switch linkBefore {
                case "Label:" :
                    if let linkcss = link.at_css("a") {
                        label = linkcss.content!.trimSim("\n")
                        linkBefore = link.content ?? ""
                    }
                 case "Format:" :
                    if  link["class"] == "content"{
                        if let linkcss = link.content {
                            format =  linkcss.trimSim("\n")
                            linkBefore = linkcss }
                    }
                 case "Country:" :
                    if  link["class"] == "content"{
                        if let linkcss = link.content {
                            country =  linkcss.trimSim("\n")
                            linkBefore = linkcss }
                    }
                case "Released:":
                    if  link["class"] == "content"{
                        if let linkcss = link.text {
                            released =  linkcss.trimSim("\n")
                            linkBefore = linkcss }
                    }
                case "Genre:" :
                    if  link["class"] == "content"{
                        if let linkcss = link.text {
                            genre = linkcss.trimSim("\n")
                            linkBefore = linkcss }
                    }
                default:
                     linkBefore = link.content ?? ""
                }
                
               }
                
                if text != "" {
                    let rowData = RowDataRealm()
                    rowData.id = rowData.IncrementaID()
                    rowData.title = text
                    rowData.price = price
                    rowData.label = label
                    rowData.format = format
                    rowData.country = country
                    rowData.released = Int(released) ?? 0
                    rowData.genre = genre
                    
                    try! uiRealm.write({ () -> Void in
                        uiRealm.add(rowData)
                        self.readTasksAndUpdateUI()
                        if i < self.rowCount {
                            self.parseHTML(i + 1)
                        }
                    })}
                }
            }
        }
    }
}

// #MARK: UIWebViewDelegate

extension MainViewController : UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
       return true
    }

}

// #MARK: UITableViewDelegate

extension MainViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 150
    }
}

// #MARK: UITableViewDataSource

extension MainViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DataRealmTVCell
       
        let dList = lists[indexPath.row]
        cell.idLabel.text = String(dList.id)
        cell.title.text = dList.title
        cell.label.text = dList.label
        cell.country.text = dList.country
        cell.format.text  = dList.format
        cell.genre.text = dList.genre
        cell.released.text = String(dList.released)
        cell.price.text = dList.price
        
        return cell
    }
    
}

