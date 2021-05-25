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

class SendDBModel{
    
    let db = Firestore.firestore()
    
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
            imageRef.downloadURL { url, error in
                
                if url != nil {
                    
                    //FireStoreへ、ユーザ名、画像、紹介文、ログインid,登録日時を保存 (documet名は、ログインid)
                    self.db.collection("Users").document(Auth.auth().currentUser!.uid).setData(["UserName": userName, "profileText": profileText, "UserID": Auth.auth().currentUser!.uid, "image": url?.absoluteString, "Date": String(Date().timeIntervalSince1970)])
                    
                }
                
            }
            
        }
        
    }
    
}
