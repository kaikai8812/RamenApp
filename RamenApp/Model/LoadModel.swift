//
//  LoadModel.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import Foundation
import Firebase

//contentデータ取得時のプロトコル
protocol GetDataProtocol {
    
    func getData(dataArray:[ContentModel])
    
}

protocol GetProfileDataProtocol {
    
    func getProfileData(dataArray:[ProfileModel])
    
}

//相手のフォロワーに自分が存在するかどうかを判別するexist => いた場合、フォローボタンをフォロー済み状態に変更するため。
protocol GetFollowersDataProtocol {
    
    func getFollowersData(followersArray:[FollowerModel], exist:Bool)
    
}

protocol GetFollowDataProtocol {
    
    func getFollowData(followArray:[FollowModel])
    
}

class LoadModel {
    
    let db = Firestore.firestore()
    
    //fireStoreから取得したデータを、配列で取得するため
    var contentModelArray:[ContentModel] = []
    var profileModelArray:[ProfileModel] = []
    
    //プロトコルのインスタンス化
    var getDataProtocol:GetDataProtocol?
    var getProfileDataProtocol:GetProfileDataProtocol?
    var getFollowersDataProtocol:GetFollowersDataProtocol?
    var getFollowDataProtocol:GetFollowDataProtocol?
    
    
    //フォローフォロワーの人数関係のインスタンス
    var followModelArray:[FollowModel]?
    var followerModelArray:[FollowerModel]?
    var ownFollowOrNot:Bool?
    
    
    //カテゴリー別でデータを受信するメソッド
    func loadContents(category:String) {
        
        db.collection(category).order(by: "Date").addSnapshotListener { [self] snapShot, error in
            
            print(category)
            print("デバック")
            
            self.contentModelArray = []
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc {
                    print(doc.documentID)
                    let data = doc.data()
                    
                    print((data["userID"] as? String)!)
                    print((data["userName"] as? String)!)
                    print((data["image"] as? String)!)
                    print((data["shopName"] as? String)!)
                    print((data["sender"] as? [String])!)
                    print((data["review"] as? String)!)
                    print((data["price"] as? String)!)
                    print((data["rate"] as? Double)!)
                    print((data["Date"] as? String)!)
                    print("")
                    
                    var test = String()
                    test = data["userName"] as! String
                    print(test)
                    
                    //もし必要とするデータがfireStoreに存在し、入手することができたら
                    if let userID = (data["userID"])! as? String, let userName = (data["userName"])! as? String, let image = (data["image"])! as? String,let shopName = (data["shopName"])! as? String,let review = (data["review"])! as? String,let price = (data["price"])! as? String,let sender = (data["sender"])! as? [String],let rate = (data["rate"])! as? Double, let date = (data["Date"])! as? String{
                        
                        //データが入ったモデルをインスタンス化
                        let contentModel = ContentModel(userName: userName, userID: userID, price: price, shopName: shopName, review: review, imageURLString: image, rate: rate, sender: sender)
                        
                        //配列に代入
                        self.contentModelArray.append(contentModel)
                        
                    }
                }
                //プロトコルメソッドを起動
                self.getDataProtocol?.getData(dataArray: self.contentModelArray)
                
            }
        }
    }
    
    //プロフィール画面で、ユーザー別の投稿データを取得する際に使用
    func loadOwnContents(userID:String) {
        
        db.collection("Users").document(userID).collection("ownContents").order(by: "date").addSnapshotListener { [self] snapShot, error in
            
            self.contentModelArray = []
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    //もし必要とするデータがfireStoreに存在し、入手することができたら
                    if let userID = data["userID"] as? String, let userName = data["userName"] as? String, let image = data["image"] as? String,let shopName = data["shopName"] as? String,let review = data["review"] as? String,let price = data["price"] as? String,let sender = data["sender"] as? [String],let rate = data["rate"] as? Double, let date = data["Date"] as? String{
                        
                        //データが入ったモデルをインスタンス化
                        let contentModel = ContentModel(userName: userName, userID: userID, price: price, shopName: shopName, review: review, imageURLString: image, rate: rate, sender: sender)
                        
                        //配列に代入
                        self.contentModelArray.append(contentModel)
                    }
                }
                //プロトコルメソッドを起動
                self.getDataProtocol?.getData(dataArray: self.contentModelArray)
            }
        }
    }
    
    func loadProfile(userID:String) {
        
        db.collection("Users").document(userID).addSnapshotListener { snapShot, error in
            
            self.profileModelArray = []
            
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.data() {
                
                if let userName = snapShotDoc["UserName"] as? String, let userID = snapShotDoc["UserID"] as? String, let image = snapShotDoc["image"] as? String, let profileText = snapShotDoc["profileText"] as? String {
                    
                    let profileModel = ProfileModel(userName: userName, userID: userID, profileText: profileText, imageURLString: image)
                    
                    self.profileModelArray.append(profileModel)
                }
            }
            //プロフィール画面のフォローボタンの表記を変更するプロトコルメソッド
            self.getProfileDataProtocol?.getProfileData(dataArray: self.profileModelArray)
        }
    }
    
    //フォロワーの情報のみを集めるメソッド(ここでフォロワーの詳細情報まで集めておくことで、フォロワー一覧画面を作成するときにデータをそのまま使えるので便利)
    
    func getFollowerData(userID:String) {
        
        db.collection("Users").document(userID).collection("follower").addSnapshotListener { snapShot, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.documents{
                
                self.followerModelArray = []
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    if let follower = data["follower"] as? String, let followOrNot = data["followOrNot"] as? Bool, let image = data["image"] as? String, let profileText = data["profileText"] as? String, let userID = data["userID"] as? String, let userName = data["userName"] as? String {
                        
                        //対象のデータが、自分をフォローしているかどうかを判定
                        if userID == Auth.auth().currentUser?.uid{
                            self.ownFollowOrNot = followOrNot
                        }
                        
                        if followOrNot == true {
                            let followerModel = FollowerModel(follower: follower, followOrNot: followOrNot, image: image, profileText: profileText, userID: userID, userName: userName)
                            
                            self.followerModelArray?.append(followerModel)
                        }
                    }
                }
                self.getFollowersDataProtocol?.getFollowersData(followersArray: self.followerModelArray!, exist: self.ownFollowOrNot ?? false)
            }
            
        }
        
    }
    
    //フォロワーの情報のみを集めるメソッド(ここでフォローの詳細情報まで集めておくことで、フォロ一覧画面を作成するときにデータをそのまま使えるので便利)
    func getFollowData(userID:String) {
        
        db.collection("Users").document(userID).collection("follow").addSnapshotListener { snapShot, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.documents{
                
                self.followModelArray = []
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    if let follow = data["follow"] as? String, let followOrNot = data["followOrNot"] as? Bool, let image = data["image"] as? String, let profileText = data["profileText"] as? String, let userID = data["userID"] as? String, let userName = data["userName"] as? String {
                        
                        
                        if followOrNot == true {
                            let followModel = FollowModel(follow: follow, followOrNot: followOrNot, image: image, profileText: profileText, userID: userID, userName: userName)
                            
                            self.followModelArray?.append(followModel)
                        }
                    }
                }
                self.getFollowDataProtocol?.getFollowData(followArray: self.followModelArray!)
            }
            
        }
        
    }
}

