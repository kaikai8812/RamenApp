//
//  TabBarController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/28.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.items![0].image = UIImage(named: "tab1notSelected")?.withRenderingMode(.alwaysOriginal)
        tabBar.items![1].image = UIImage(named: "tab2notSelected")?.withRenderingMode(.alwaysOriginal)
        tabBar.items![2].image = UIImage(named: "tab3notSelected")?.withRenderingMode(.alwaysOriginal)
        
        tabBar.items![0].selectedImage = UIImage(named: "tab1")
        tabBar.items![1].selectedImage = UIImage(named: "tab2")
        tabBar.items![2].selectedImage = UIImage(named: "tab3")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
