//
//  CreateUserViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import UIKit
import FirebaseAuth

class CreateUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var profileTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    //モデルのインスタンス化
    var sendDBModel = SendDBModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //各種レイアウト調整
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        userNameTextField.layer.cornerRadius = 20
        profileTextView.layer.cornerRadius = 20
        doneButton.layer.cornerRadius = 20
        
        profileImageView.isUserInteractionEnabled = true

        
    }
    

    @IBAction func profileImageTap(_ sender: Any) {
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
            
            Auth.auth().signInAnonymously { [self] result, error in
                
                //プロフィールに設定した画像をData型にして圧縮
                let imageData = profileImageView.image?.jpegData(compressionQuality: 0.1)
                
                if error != nil {
                    print(error.debugDescription)
                }else{
                    
                    sendDBModel.sendProfileDB(userName: <#T##String#>, profileText: <#T##String#>, imageData: <#T##Data#>)
                    
                }
                
            }
            
        }
        
    }
    
}

