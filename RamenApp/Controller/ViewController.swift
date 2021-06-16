//
//  ViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/25.
//

import UIKit
import AMPagerTabs //上部タブ作成のためのライブラリ
import FirebaseAuth

class ViewController: AMPagerTabsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //上部タブのレイアウトの設定
        settings.tabBackgroundColor = #colorLiteral(red: 0.2819149196, green: 0.7462226748, blue: 0.6821211576, alpha: 1)
        settings.tabButtonColor = #colorLiteral(red: 0.2819149196, green: 0.7462226748, blue: 0.6821211576, alpha: 1)
        settings.tabHeight = 120
        tabFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        isTabButtonShouldFit = true
        self.viewControllers = getTabs()
        
        //サインインしているかどうかで場合分け
        if Auth.auth().currentUser != nil {
            //サインインしている場合
            performSegue(withIdentifier: "signInVC", sender: nil)
            
        }else{
            //サインインしていない場合
            performSegue(withIdentifier: "createVC", sender: nil)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    func getTabs() -> [UIViewController] {  //viewcontrollerが入った配列を返す
        
        var vcArray = [UIViewController]()
        
        for i in 0..<4 {
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "view1") as! ContentsViewController
           
            viewController.title = "\(Constants.titleArray[i])"
            //タブ番号を渡して、どのカテゴリーを表示させるかを判別させる。
            viewController.index = i
        
            vcArray.append(viewController)
            
        }
        return vcArray
    }
    
    
}

