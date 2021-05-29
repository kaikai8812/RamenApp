//
//  UserDefauts.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import Foundation

class UserDefaultsEX: UserDefaults {

    //目的　＝　UserDefaultsで、profileモデルの各値を全て別々に保存する
    //引数は、Profileモデル型でもらう
    func set(value: ProfileModel, key: String){
        let userName = value.userName
        let userID = value.userID
        let profileText = value.profileText
        let imageURLString = value.imageURLString
        
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(userID, forKey: "userID")
        UserDefaults.standard.set(profileText, forKey: "profileText")
        UserDefaults.standard.set(imageURLString, forKey: "imageURLString")
        
    }
    
    

    
    //別々に保存されたprofile型の値等を取り出して、Profile型のデータに入れ直した後、profile型のデータで値を返す。
    func codable(key:String) -> ProfileModel {
        
        var profile = ProfileModel()
        
        let userName = UserDefaults.standard.object(forKey: "userName")
        let userID = UserDefaults.standard.object(forKey: "userID")
        let profileText = UserDefaults.standard.object(forKey: "profileText")
        let imageURLString = UserDefaults.standard.object(forKey: "imageURLString")
    
        profile.userName = userName as! String
        profile.userID = userID as! String
        profile.profileText = profileText as! String
        profile.imageURLString = imageURLString as! String
        
        return profile
    }
    

}
