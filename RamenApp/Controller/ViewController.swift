//
//  ViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/25.
//

import UIKit
import AMPagerTabs //上部タブ作成のためのライブラリ

class ViewController: AMPagerTabsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings.tabBackgroundColor = #colorLiteral(red: 0.2819149196, green: 0.7462226748, blue: 0.6821211576, alpha: 1)
        settings.tabButtonColor = #colorLiteral(red: 0.2819149196, green: 0.7462226748, blue: 0.6821211576, alpha: 1)
        tabFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        isTabButtonShouldFit = true
        self.viewControllers = getTabs()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func getTabs() -> [UIViewController] {  //viewcontrollerが入った配列を返す
        
        var vcArray = [UIViewController]()
        
        for i in 0..<5 {
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "view1") as! CameraViewController
           
            viewController.title = ""
            viewController.index = i
        
            vcArray.append(viewController)
            
        }
        return vcArray
    }
    
    
}
