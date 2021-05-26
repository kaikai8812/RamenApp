//
//  CreateUserViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import UIKit
import FirebaseAuth
import PKHUD //ロード画面表示関係

class CreateUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SendProfileDone {
 
    
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var profileTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    //モデルのインスタンス化
    var sendDBModel = SendDBModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendDBModel.sendProfileDone = self
        
        //各種レイアウト調整
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        userNameTextField.layer.cornerRadius = 20
        profileTextView.layer.cornerRadius = 20
        doneButton.layer.cornerRadius = 20
        
        profileImageView.isUserInteractionEnabled = true

        
    }
    

    @IBAction func profileImageTap(_ sender: Any) {
        openCamera()
    }
    
    
    func openCamera(){
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
//            cameraPicker.showsCameraControls = true
            present(cameraPicker, animated: true, completion: nil)
            
        }else{
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let pickedImage = info[.editedImage] as? UIImage
        {
            profileImageView.image = pickedImage
            //閉じる処理
            picker.dismiss(animated: true, completion: nil)
         }
 
    }
 
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        
        //アカウントを作成する

        //userNameが空でないなら
        if userNameTextField.text?.isEmpty != true {
            
            //FireBaseAuthを用いて、匿名ログインを行う
            Auth.auth().signInAnonymously { [self] result, error in
                
                //プロフィールに設定した画像をData型にして圧縮
                let imageData = profileImageView.image?.jpegData(compressionQuality: 0.1)
                
                if error != nil {
                    print(error.debugDescription)
                }else{
                    //モデルメソッドを使用して、ユーザ情報をFireStoreに送信
                    sendDBModel.sendProfileDB(userName: userNameTextField.text!, profileText: profileTextView.text!, imageData: imageData!)
                    
                }
                
            }
            
        }
        
    }
    
    //SendDBModelのデリゲートメソッド(ユーザ新規登録後に呼ばれる。)
    func checkOK() {
        
        HUD.hide()  //ロード画面を終了する
        
        //画面遷移(画面を戻る)
        dismiss(animated: true, completion: nil)
        
    }
    
}


