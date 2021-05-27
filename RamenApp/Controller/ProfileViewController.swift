//
//  ProfileViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/27.
//

import UIKit
import FirebaseAuth
import SDWebImage
import Cosmos
import SSSpinnerButton


//Detailから遷移してきた場合(他人のプロフィール)と、自分のプロフィール画面、二つの画面で使用する。
class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GetDataProtocol,GetProfileDataProtocol,DoneFollowAction, GetFollowDataProtocol, GetFollowersDataProtocol {
    
    //モデルのインスタンス化
    var loadModel = LoadModel()
    var sendDBModel = SendDBModel()
    
    //投稿詳細画面から遷移してきた際に、遷移元の投稿の詳細が格納されるインスタンス
    var contentModel:ContentModel?
    
    //loadModelから入手してきたデータを入れる配列
    var contentModelArray = [ContentModel]()
    var followerArray = [FollowerModel]()
    var followArray = [FollowModel]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followButton: SSSpinnerButton!
    @IBOutlet weak var profileTextLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //プロトコル委任関係
        tableView.delegate = self
        tableView.dataSource = self
        sendDBModel.doneFollowAction = self
        
        //カスタムセルが使用できるように設定
        tableView.register(UINib(nibName: "ContentsCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        //プロフィール画像のデザイン記述
        imageView.layer.cornerRadius = imageView.frame.width/2
        
        //自分のプロフィールページかそうでないかで場合分け
        if self.tabBarController?.selectedIndex == 2{
            //もし、タブバーを使用して自分のプロフィールページを見ている場合の処理 => フォローボタンを消す
            followButton.isHidden = true
            //ログインしているユーザー（自分）の場合なので、現在の自分のIDでsetUpを行う
            setUp(userID: Auth.auth().currentUser!.uid)
            
        } else {
            
            if contentModel?.userID == Auth.auth().currentUser?.uid{
                //自分の投稿から自分のプロフィールページに渡ってきた場合  => フォローボタンを消す
                followButton.isHidden = true
            }
            
            //自分のプロフィール画面でない時は、遷移前画面から受け取ったcontentModelの情報を使ってsetUpを行う.
            setUp(userID: (contentModel?.userID)!)
            //プロフィール情報を画面に反映
            imageView.sd_setImage(with: URL(string: (contentModel?.sender![0])!), completed: nil)
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            userNameLabel.text = contentModel?.sender![3]
            profileTextLabel.text = contentModel?.sender![1]
            
        }
    }
    
    //userIDを引数にとって、ユーザの情報を取得するメソッドを作成
    func setUp(userID:String){
        
        loadModel.getDataProtocol = self
        loadModel.getProfileDataProtocol = self
        loadModel.getFollowDataProtocol = self
        loadModel.getFollowersDataProtocol = self
        //表示ユーザのプロフィールを取得
        loadModel.loadProfile(userID: userID)
        //フォロワーデータを取得
        loadModel.getFollowerData(userID: userID)
        //フォローデータを取得
        loadModel.getFollowData(userID: userID)
        //投稿コンテンツの取得
        loadModel.loadOwnContents(userID: userID)
        
    }
    
    
    @IBAction func follow(_ sender: Any) {
        
        //フォロー処理が終了するまで、アニメーションを行う。
        
        followButton.startAnimate(spinnerType: .ballClipRotate, spinnercolor: .blue, spinnerSize: 20) {
            
            //もしボタン表記が「フォローをする」だったら、followOrnot == trueにして、相手をフォローする。
            if self.followButton.titleLabel?.text == "フォローをする" {
                
                self.sendDBModel.followAction(userID: (self.contentModel?.userID)!, followOrNot: true, contentModel: self.contentModel!)
                
                //もしボタン表記が「フォローをする」だったら、followOrnot == falseにして、相手のフォローを外す。
            }else if self.followButton.titleLabel?.text == "フォローをやめる"{
                self.sendDBModel.followAction(userID: (self.contentModel?.userID)!, followOrNot: false, contentModel: self.contentModel!)
            }
        }
    }
    
    //フォローボタンをタップした後、条件によってフォローボタンの表記を変更するデリゲートメソッド(ボタンの表記を変える際、)
    func checkFollow(flag: Bool) {
        //もし、フォローをした後ならば!
        if flag == true {
            self.followButton.stopAnimatingWithCompletionType(completionType: .none) {
                
                self.followButton.setTitle("フォローをやめる", for: .normal)
                
            }
            //もし、フォローを外した後ならば
        }else{
            self.followButton.stopAnimatingWithCompletionType(completionType: .none) {
                
                self.followButton.setTitle("フォローをする", for: .normal)
            }
        }
    }
    
    
    //フォローに関するデリゲートメソッド
    func getFollowData(followArray: [FollowModel]) {
        
        self.followArray = []
        self.followArray = followArray
        //フォロー数を反映させる。
        followLabel.text = String(self.followArray.count)
    }
    
    //フォロワーに関するデリゲートメソッド
    func getFollowersData(followersArray: [FollowerModel], exist: Bool) {
        
        self.followerArray = []
        self.followerArray = followersArray
        
        //フォロワー数を反映させる
        followerLabel.text = String(followerArray.count)
        
        //もし、ユーザーのフォロワーに自分が入っている => すでにフォロー済みの状態だったら、ボタンの文字を変更する
        if exist == true {
            followButton.setTitle("フォローをやめる", for: .normal)
        } else {
            followButton.setTitle("フォローをする", for: .normal)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentModelArray.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContentsCell
        
        cell.contentImageView.sd_setImage(with: URL(string: contentModelArray[indexPath.row].imageURLString!), completed: nil)
        cell.priceLabel.text = contentModelArray[indexPath.row].price
        cell.shopNameLabel.text = contentModelArray[indexPath.row].shopName
        cell.reviewLabel.text = contentModelArray[indexPath.row].review
        cell.reviewRatingView.rating = contentModelArray[indexPath.row].rate!
        
        return cell
    }
    
    
    
    //投稿データを全て入手したら、tebleViewを更新するデリゲートメソッド
    func getData(dataArray: [ContentModel]) {
        
        contentModelArray = []
        contentModelArray = dataArray
        tableView.reloadData()
    }
    
    //プロフィールデータを受信したら、受信内容をもとにviewに反映する。
    func getProfileData(dataArray: [ProfileModel]) {
        
        imageView.sd_setImage(with: URL(string: dataArray[0].imageURLString!), completed: nil)
        profileTextLabel.text = dataArray[0].profileText
        
    }
    
    
}
