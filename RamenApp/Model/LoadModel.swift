//
//  LoadModel.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import Foundation
import Firebase

protocol GetDataProtocol {
    func getData(dataArray:[ContentModel])
}

class LoadModel {
    
    let db = Firestore.firestore()
    
    //fireStoreから取得したデータを、配列で取得するため
    var contentModelArray:[ContentModel] = []
    
    //プロトコルのインスタンス化
    var getDataProtocol:GetDataProtocol?
    
    
    //カテゴリー別でデータを受信するメソッド
    func loadContents(category:String) {
        
        db.collection(category).order(by: "date").addSnapshotListener { [self] snapShot, error in
            
            self.contentModelArray = []
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    //もし必要とするデータがfireStoreに存在し、入手することができたら
                    if let userID = data["userID"] as? String, let userName = data["userName"] as? String, let image = data["image"] as? String,let shopName = data["shopName"] as? String,let review = data["review"] as? String,let price = data["price"] as? String,let sender = data["dender"] as? [String],let rate = data["rate"] as? Double, let date = data["date"] as? Date{
                        
                        //データが入ったモデルをインスタンス化
                        let contentModel = ContentModel(userName: userName, userID: userID, price: price, shopName: shopName, review: review, imageURLString: image, rate: rate, sender: sender)
                        
                        //配列に代入
                        self.contentModelArray.append(contentModel)
                        
                        //プロトコルメソッドを起動
                        self.getDataProtocol?.getData(dataArray: self.contentModelArray)
                        
                    
                    }
                }
            }
        }
    }
}
