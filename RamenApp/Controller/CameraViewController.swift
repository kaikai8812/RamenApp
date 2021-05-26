//
//  CameraViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import UIKit
import YPImagePicker  //フィルター付きカメラの導入
import EMAlertController //カテゴリー選択アラート用
import PKHUD

class CameraViewController: UIViewController {
    
    
    @IBOutlet weak var cotentImageView: UIImageView!
    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var cayegorySelectButton: UIButton!
    
    
    
    //選択されたカテゴリーを保持するため。
    var categoryString = String()
    
    //モデルのインスタンス化
    var userDefaultsEX:UserDefaultsEX?
    var sendDBModel = SendDBModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cotentImageView.layer.cornerRadius = 20
        cotentImageView.clipsToBounds = true  //どういった意味を持つか再度確認
        
        
        if cotentImageView.image != nil {
            
        }else{
            //contentImageViewに何も設定されていないのであれば、カメラを起動する。
            showCamera()
        }
    
    }

    //YPImagePickerを利用したフィルターカメラを起動するメソッド
    func showCamera(){
            var config = YPImagePickerConfiguration()
            // [Edit configuration here ...]
            // Build a picker with your configuration
            config.isScrollToChangeModesEnabled = true
            config.onlySquareImagesFromCamera = true
            config.usesFrontCamera = false
            config.showsPhotoFilters = true
            config.showsVideoTrimmer = true
            config.shouldSaveNewPicturesToAlbum = true
            config.albumName = "DefaultYPImagePickerAlbumName"
            config.startOnScreen = YPPickerScreen.photo
    //        config.screens = [.photo]
            //ここにの値を.photoに変えると、アルバムではなくカメラを使用することができる。どちらも使用できるようにしておくこと！！
            config.screens = [.library]
            config.showsCrop = .none
            config.targetImageSize = YPImageSize.original
            config.overlayView = UIView()
            config.hidesStatusBar = true
            config.hidesBottomBar = false
            config.hidesCancelButton = false
            config.preferredStatusBarStyle = UIStatusBarStyle.default
            config.maxCameraZoomFactor = 1.0
            let picker = YPImagePicker(configuration: config)
        
            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    self.cotentImageView.image = photo.image
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
        }
    
    
    //contentImageviewをタップした際に呼ばれる
    @IBAction func retake(_ sender: Any) {
        showCamera()
    }
    
    
    //カテゴリーを選択する(アラートを表示)
    @IBAction func showCategory(_ sender: Any) {
        
        let alert = EMAlertController(title: "この中で", message: "選択してね")
        
        for i in 0 ..< Constants.menuArray.count {
            
            let categoryButton = EMAlertAction(title: Constants.titleArray[i], style: .normal) {
                
                //カテゴリーが選択された後の挙動を設定（タップされた時点で行われる挙動を設定している）
                self.categoryString = Constants.menuArray[i]
                self.cayegorySelectButton.text(Constants.titleArray[i])
            }
            //作成したアラートアクションを追加（for文内）
            alert.addAction(categoryButton)
        }
        //アラートの閉じる欄を作成
        let closeButton = EMAlertAction(title: "閉じる", style: .cancel)
        alert.addAction(closeButton)
        //アラートのデザインを設定
        alert.cornerRadius = 10.0
        alert.iconImage = UIImage(named: "ok")
        //アラートを表示
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func send(_ sender: Any) {
        
        //ロード画面の表示
        HUD.show(.progress)
        HUD.dimsBackground = true
        
        //プロフィール情報を保存した構造体がアプリ内に保存されているので、それをデコードして持ってくる。
        let profile:ProfileModel? = userDefaultsEX?.codable(forKey: "profile")
        
        if shopNameTextField.text != nil && shopNameTextField.text != nil && categoryString != nil && reviewTextView.text != nil {
            
            //FireStoreに、投稿情報を保存する。
            
        }
    }
}
