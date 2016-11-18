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

    var activeTabIndex = 0

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

        // 1ページ（画面）単位でスクロール
        webCollectionView.isPagingEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


// MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // temporary
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabCollectionView {
            let cell = tabCollectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as! TabCollectionViewCell
            // アクティブなタブの背景色を変更する
            if indexPath.item == activeTabIndex {
                cell.backgroundColor = UIColor.blue
            }
            else {
                cell.backgroundColor = UIColor.black
            }
            cell.indexLabel.text = String(indexPath.item)
            return cell
        }
        else {
            let cell = webCollectionView.dequeueReusableCell(withReuseIdentifier: "WebCell", for: indexPath) as! WebCollectionViewCell
            cell.indexLabel.text = String(indexPath.item)
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
            activeTabIndex = indexPath.item
            tabCollectionView.reloadData()
            // タブに対応するWebCellを表示する
            webCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }

// MARK: - WebView操作
    // スワイプでタブも切り替える
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.selectedTabBySwipe(scrollView)
//    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.selectedTabBySwipe(scrollView)
    }

    // 該当のタブをアクティブ状態にする
    func selectedTabBySwipe(_ scrollView: UIScrollView) {
        if scrollView != webCollectionView {
            return
        }

        // 今時点で見えているタブの取得
        let visibleTabs = tabCollectionView.indexPathsForVisibleItems
        var indexes = [Int]()
        for tab in visibleTabs {
            indexes.append(tab.item)
        }
        indexes.sort()

        // 今表示されたWebViewのインデックスを取得
        let activeWebViewIndexs = webCollectionView.indexPathsForVisibleItems

        // アクティブになるタブ（＝今表示されたWebViewのインデックス）を設定し、リフレッシュさせて色を変更しておく
        activeTabIndex = activeWebViewIndexs[0].item
        tabCollectionView.reloadData()

        // 今時点で見えているタブの範囲外なら、スクロールして表示する
        if activeTabIndex <= indexes.first! {
            tabCollectionView.scrollToItem(at: activeWebViewIndexs[0], at: .left, animated: true)
        }
        if activeTabIndex >= indexes.last! {
            tabCollectionView.scrollToItem(at: activeWebViewIndexs[0], at: .right, animated: true)
        }
    }
}

