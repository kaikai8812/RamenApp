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
import Cosmos

class CameraViewController: UIViewController,DoneSendCentents {
  
    
    
    
    @IBOutlet weak var cotentImageView: UIImageView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var reviewCosmosview: CosmosView!
    @IBOutlet weak var cayegorySelectButton: UIButton!
    
    
    
    //選択されたカテゴリーを保持するため。
    var categoryString:String?
    
    //モデルのインスタンス化
    var userDefaultsEX = UserDefaultsEX()
    var sendDBModel = SendDBModel()
    var loadModel = LoadModel()
    var profileModel = ProfileModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cotentImageView.layer.cornerRadius = 20
        cotentImageView.clipsToBounds = true  //どういった意味を持つか再度確認
        
        
        if cotentImageView.image != nil {
            
        }else{
            //contentImageViewに何も設定されていないのであれば、カメラを起動する。
            showCamera()
        }
    
        //コンテンツ送信後のデリゲートメソッドの委任許可
        sendDBModel.doneSendContents = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
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
        
        let alert = EMAlertController(title: "カテゴリーを", message: "選択してください")
        
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
        
        //未入力項目があった場合は、処理をストップする。
        if cotentImageView.image == nil || priceTextField.text?.isEmpty == true || shopNameTextField.text?.isEmpty == true || reviewTextView.text?.isEmpty == true || categoryString == nil {
            
            checkAlert()
            return
            //アラートを表示させ、処理を止める
        }
        
        
        HUD.show(.progress)
        HUD.dimsBackground = true
        
        
        
        //アプリ内に保存した情報を、Profile型にまとめて、profileに代入
        var profile = ProfileModel()
        profile  = userDefaultsEX.codable(key: "profile")
        if shopNameTextField.text != nil && shopNameTextField.text != nil && categoryString != nil && reviewTextView.text != nil {
            
            //FireStoreに、投稿情報を保存する。
            sendDBModel.sendContentDB(price: priceTextField.text!, category: categoryString!, shopName: shopNameTextField.text!, review: reviewTextView.text!, userName: (profile.userName)!, imageData: (cotentImageView.image?.jpegData(compressionQuality: 0.1))!, sender: profile, rate: reviewCosmosview.rating)
            
            
            //追加項目、ハッシュタグが存在した場合は、ハッシュタグ別にfireStoreにデータを保存する記述
            
            let hashTagText = reviewTextView.text as NSString?
                    do{
                        let regex = try NSRegularExpression(pattern: "#\\S+", options: [])
                        //見つけたハッシュタグを、for文で回しているっぽい・
                        for match in regex.matches(in: hashTagText! as String, options: [], range: NSRange(location: 0, length: hashTagText!.length)) {
                                
                            //sendDBModelで、ハッシュタグ別にデータを保存するメソッドを作成する。
                            print(hashTagText)
                            print("テスト")
                        }
                    }catch{
                        
                    }
            
            
            
            
            //投稿に成功したら、アラートを表示させる。
            successAlert()
        
        }
       
        
    }
    
    func checkDoneContents() {
        HUD.hide()
        self.tabBarController?.selectedIndex = 0
        
        //画面遷移後、fireStoreからコンテンツのロードを行う。（カテゴリーは、デフォルトでcategory1を表示する）
        loadModel.loadContents(category: Constants.menuArray[0])
        
    }
    //成功アラートの作成
    func successAlert() {
        let alert = EMAlertController(icon: UIImage(named: "check"), title: "投稿完了", message: "投稿に成功しました！")
        let doneAction = EMAlertAction(title: "OK", style: .normal)
        alert.addAction(doneAction)
        present(alert, animated: true, completion: nil)
    }
    
    func checkAlert (){
        let alert = EMAlertController(icon: UIImage(named: "sorry"),title: "入力に漏れがあります！", message: "全ての項目が入力できているか、確認してください。")
        let doneAction = EMAlertAction(title: "OK", style: .normal)
        alert.addAction(doneAction)
        present(alert, animated: true, completion: nil)
    }


    
}



