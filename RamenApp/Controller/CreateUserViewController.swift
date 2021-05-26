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
    var checkModel = CheckModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendDBModel.sendProfileDone = self
        
        //各種レイアウト調整
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        userNameTextField.layer.cornerRadius = 20
        profileTextView.layer.cornerRadius = 20
        doneButton.layer.cornerRadius = 20
        
        profileImageView.isUserInteractionEnabled = true
        
        //カメラとアルバムの使用許可を求めるメソッド
        checkModel.showCheckPermission()
        
        
    }
    
    
    @IBAction func profileImageviewTap(_ sender: Any) {
        showAlert()
    }
    
    
    
    //カメラを起動するメソッド
    func doCamera(){
        
        let sourceType:UIImagePickerController.SourceType = .camera
        
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    //アルバムを起動するときのメソッド
    func doAlbum(){
        
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    
    //カメラかアルバムで、画像を選択した際に、選択した画像をどう処理するかを記述
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if info[.originalImage] as? UIImage != nil{
            
            let selectedImage = info[.originalImage] as! UIImage
            profileImageView.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    //カメラやアルバムの選択をキャンセルした際に、どのような動作をするか
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.doCamera()
        }
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            
            self.doAlbum()
        }
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
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
    
    //画面がタップされたら、キーボードを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTextField.resignFirstResponder()
        profileTextView.resignFirstResponder()
    }
    
}


