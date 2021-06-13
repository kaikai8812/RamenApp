//
//  ProfileEditViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/06/12.
//

import UIKit
import SDWebImage

class ProfileEditViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextView: UITextField!
    @IBOutlet weak var userProfileTextView: UITextView!
    
    //loadModelのインスタンス化
    let loadModel = LoadModel()
    
    let userDefaults = UserDefaultsEX()
    //プロフィール情報を保存
    var profileData:ProfileModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileData = userDefaults.codable(key: "profile")
        userNameTextView.text = profileData?.userName
        userProfileTextView.text = profileData?.profileText
        profileImageView.sd_setImage(with: URL(string: (profileData?.imageURLString)!), completed: nil)
  
    }
    
    
    //行うこと
    //変更ボタンを押したら、プロフィール情報を更新する。

    @IBAction func profileUpdateButton(_ sender: Any) {
    }
    
    
}
