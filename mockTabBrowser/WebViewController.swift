//
//  WebViewController.swift
//  mockTabBrowser
//
//  Created by mzgk on 2016/11/18.
//  Copyright © 2016年 mzgk. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // StatusBarの文字を白くする
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

