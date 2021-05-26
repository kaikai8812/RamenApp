//
//  ContentModel.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/27.
//

import Foundation

struct ContentModel {
    
//    var profileModel:ProfileModel?
    
    let userName:String?
    let userID:String?
    let price:String?
    let shopName:String?
    let review:String?
    let imageURLString:String?
    let rate:Double?
    //データを配列でまず受け取るので、そのときにはsender?
    var sender:[String]?
    
}

//self.db.collection("Users").document(Auth.auth().currentUser!.uid).collection("ownContents").document().setData(["userName":userName,"userID":Auth.auth().currentUser!.uid, "price":price,"shopName":shopName,"reView":reView,"image":url?.absoluteString,"sender":self.myProfile,"rate":rate, "Date": String(Date().timeIntervalSince1970)])
