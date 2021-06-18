//
//  ProfileEditViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/06/12.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseAuth

class ProfileEditViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextView: UITextField!
    @IBOutlet weak var userProfileTextView: UITextView!
    
    //loadModelのインスタンス化
    let loadModel = LoadModel()
    let sendDataModel = SendDBModel()
    
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
        
        //imageViewを、Data型に変換
        let imageData = (profileImageView.image?.jpegData(compressionQuality: 0.1))!
        
        
        //プロフィール情報の更新
        sendDataModel.updateProfileData(userID: (profileData?.userID)!, userName: userNameTextView.text!, profileText: userProfileTextView.text, imageData: imageData)
        
        //変更成功のアラートを表示する。
        
        //自分のプロフィール画面へと戻る
        
    }
    
    
}

//プロフィール情報更新、FireBaseとの通信部記述、完了
