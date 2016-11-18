//
//  WebViewController.swift
//  mockTabBrowser
//
//  Created by mzgk on 2016/11/18.
//  Copyright © 2016年 mzgk. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var webCollectionView: UICollectionView!

    var activeTabID = 0

    // StatusBarの文字を白くする
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

// MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        webCollectionView.delegate = self
        webCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


// MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // temporary
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabCollectionView {
            let cell = tabCollectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as! TabCollectionViewCell
            // アクティブなタブの背景色を変更する
            if indexPath.item == activeTabID {
                cell.backgroundColor = UIColor.blue
            }
            else {
                cell.backgroundColor = UIColor.black
            }
            return cell
        }
        else {
            let cell = webCollectionView.dequeueReusableCell(withReuseIdentifier: "WebCell", for: indexPath) as! WebCollectionViewCell
            return cell
        }
    }

// MARK: - UICollectionViewDelegateFlowLayout
    // セルサイズを生成
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabCollectionView {
            return CGSize(width: 100.0, height: 32)
        }
        else {
            return CGSize(width: webCollectionView.frame.size.width, height: webCollectionView.frame.size.height)
        }
    }

// MARK: - Tab操作
    // Tabをタップ → タブに対応するWebViewCellを表示させる
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabCollectionView {
            activeTabID = indexPath.item
            tabCollectionView.reloadData()
            // タブに対応するWebCellを表示する
            webCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
}

