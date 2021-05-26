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


class SendDBModel{
    
    let db = Firestore.firestore()
    var sendProfileDone:SendProfileDone?
    
    //構造体をアプリ内に保存するために使用
    var userDefaultsEX = UserDefaultsEX()
    
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
                    
                    //アプリ内に、構造体をData型にencodeしてから保存(UserDefaultsEXを使用)
                    self.userDefaultsEX.set(value: profileModel, forKey: "profile")
                    
                    //FireStoreへ、ユーザ名、画像、紹介文、ログインid,登録日時を保存 (documet名は、ログインid)
                    self.db.collection("Users").document(Auth.auth().currentUser!.uid).setData(["UserName": userName, "profileText": profileText, "UserID": Auth.auth().currentUser!.uid, "image": imageURL!.absoluteString, "Date": String(Date().timeIntervalSince1970)])
                    
                   
                    
                    //fireStoreへデータ送信が完了したら、画面遷移を行う。
                    self.sendProfileDone?.checkOK()ら
                }
            }
        }
    }
    
    
    
}
