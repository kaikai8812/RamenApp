//
//  SendDBModel.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseStorage
import PKHUD  //ローディング画面表示用

//ユーザ登録後、画面遷移用プロトコル
protocol SendProfileDone {
    func checkOK()
}

//投稿完了後のプロトコル
protocol DoneSendCentents {
    func checkDoneContents()
}

//フォロー関係のプロトコル
protocol DoneFollowAction {
    func checkFollow(flag:Bool)
}


class SendDBModel{
    
    let db = Firestore.firestore()
    var sendProfileDone:SendProfileDone?
    var doneSendContents:DoneSendCentents?
    var doneFollowAction:DoneFollowAction?
    
    //構造体をアプリ内に保存するために使用
    var userDefaultsEX = UserDefaultsEX()
    
    var myProfile = [String]()
    
    //プロフィール情報をDBに保存する(新規登録)
    func sendProfileDB(userName:String, profileText:String, imageData:Data) {
        
        //ローディング画面を表示する
        HUD.show(.progress)
        HUD.dimsBackground = true
        
        //Storageの保存設定 (ProfileImage-ランダムな文字列+日付+jpgに保存)
        
        let imageRef = Storage.storage().reference().child("ProfileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(imageData, metadata: nil) { metaData, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            // 送信した画像データを、urlで入手
            imageRef.downloadURL { imageURL, error in
                
                if imageURL != nil {
                    
                    //アプリ内にユーザ情報を保存しておく
                    //ユーザ情報を持った構造体を作成
                    let profileModel = ProfileModel(userName: userName, userID: Auth.auth().currentUser!.uid, profileText: profileText, imageURLString: imageURL?.absoluteString)
                    
                    print(profileModel.userName)
                    print(profileModel.userID)
                    print(profileModel.imageURLString)
               print("")
                    //アプリ内に、構造体をData型にencodeしてから保存(UserDefaultsEXを使用)
                    self.userDefaultsEX.set(value: profileModel, key: "profile")
//
                    
                    
                    //FireStoreへ、ユーザ名、画像、紹介文、ログインid,登録日時を保存 (documet名は、ログインid)
                    self.db.collection("Users").document(Auth.auth().currentUser!.uid).setData(["UserName": userName, "profileText": profileText, "UserID": Auth.auth().currentUser!.uid, "image": imageURL!.absoluteString, "Date": String(Date().timeIntervalSince1970)])
                    
                    //fireStoreへデータ送信が完了したら、画面遷移を行う。
                    self.sendProfileDone?.checkOK()
                }
            }
        }
    }
    
    //投稿データをfireStoreへ保存する 
    func sendContentDB(price:String,category:String,shopName:String,review:String,userName:String,imageData:Data,sender:ProfileModel,rate:Double) {
        
        let imageRef = Storage.storage().reference().child("contentImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(imageData, metadata: nil) { metaData, error in
            
            if error != nil{
                return
            }
            imageRef.downloadURL { url, error in
                
                if error != nil{
                    return
                }
                
                if url != nil{
                    print()
                    self.myProfile.append(sender.imageURLString!)
                    self.myProfile.append(sender.profileText!)
                    self.myProfile.append(sender.userID!)
                    self.myProfile.append(sender.userName!)
                    
                    //User別で投稿を保存する
                    //お店の位置情報と、料理自体の名前、あとで追加予定
                    self.db.collection("Users").document(Auth.auth().currentUser!.uid).collection("ownContents").document().setData(["userName":userName,"userID":Auth.auth().currentUser!.uid, "price":price,"shopName":shopName,"review":review,"image":url?.absoluteString,"sender":self.myProfile,"rate":rate, "Date": String(Date().timeIntervalSince1970)])
                    
                    //カテゴリー別で投稿を保存する
                    //お店の位置情報と、料理自体の名前、あとで追加予定
                    self.db.collection(category).document().setData(["userName":userName,"userID":Auth.auth().currentUser!.uid, "price":price,"shopName":shopName,"review":review,"image":url?.absoluteString,"sender":self.myProfile,"rate":rate, "Date": String(Date().timeIntervalSince1970)])
                    
                    //画面遷移を行うプロトコルを発動
                    self.doneSendContents?.checkDoneContents()
                }
            }
        }
    }
    
    //フォロー関係のメソッド
    //ここでのuserIDは、プロフィール画面上のuserのid
    //contentmodelに、相手のユーザー情報が詰まっているので、引数に使用
    func followAction(userID:String, followOrNot:Bool,contentModel:ContentModel){
        
        //ログイン中のユーザの情報を入手
        let loginUserProfile:ProfileModel? = userDefaultsEX.codable(key: "profile")
        //もしuserIDが自分のidでなければ
        if userID != Auth.auth().currentUser?.uid{  //ここのif文、自分のプロフィール画面にはそもそもフォロー画面が表示されないはずなので、必要かも？？要検討
            
            //相手のフォロワー情報に、自分の情報を入れる（相手のフォロワーリストに自分を追加する）
            self.db.collection("Users").document(userID).collection("follower").document(Auth.auth().currentUser!.uid).setData(["follower" : Auth.auth().currentUser?.uid,"followOrNot": followOrNot, "userID": loginUserProfile?.userID, "userName": loginUserProfile?.userName, "image": loginUserProfile?.imageURLString, "profileText":loginUserProfile?.profileText])
            
        }
        
        //自分のフォローリフトに、フォローする相手の情報を追加する
        self.db.collection("Users").document(Auth.auth().currentUser!.uid).collection("follow").document(userID).setData(["follow" : userID,"followOrNot": followOrNot, "userID": contentModel.userID, "userName": contentModel.userName, "image": contentModel.sender![0], "profileText":contentModel.sender![1]])
        
        //プロトコルを発動
        doneFollowAction?.checkFollow(flag: followOrNot)
        
    }
    
}
