//
//  DetailViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/27.
//

import UIKit
import SDWebImage
import Cosmos
import ActiveLabel

class DetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //tableヘッダー作成関連
    var headerImageView = UIImageView()
    var blurEffectView = UIVisualEffectView()
    
    //contentsViewControllerから遷移してきた際に、タップしたcontentの情報が入ってくる変数
    var contentModel:ContentModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //ヘッダーにcontentの画像を載せるための設定
        headerImageView.sd_setImage(with: URL(string: (contentModel?.imageURLString)!), completed: nil)
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        headerImageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 2)
        tableView.tableHeaderView = headerImageView
        
        //ヘッダーに対しエフェクトを作成する。(曇りガラス)
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tableView.tableHeaderView!.bounds
        blurEffectView.alpha = 0.0
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.tableHeaderView?.addSubview(blurEffectView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //ヘッダーのブラー処理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        blurEffectView.alpha = 1.0
        //下へ行けば行くほど、ブラーが濃くなる処理
        blurEffectView.alpha = scrollView.contentOffset.y / 200
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        //各項目に値を設定する。
        let shopNameLabel = cell.contentView.viewWithTag(1) as! UILabel
        shopNameLabel.text = contentModel?.shopName
        
        let priceLabel = cell.contentView.viewWithTag(2) as! UILabel
        priceLabel.text = contentModel?.price
        
        let reviewRatingView = cell.contentView.viewWithTag(4) as! CosmosView
        reviewRatingView.rating = (contentModel?.rate)!
        
        let userImageView = cell.contentView.viewWithTag(5) as! UIImageView
        userImageView.sd_setImage(with: URL(string: (contentModel?.sender![0])!), completed: nil)
        userImageView.layer.cornerRadius = 20.0
        
        let userNameLabel = cell.contentView.viewWithTag(6) as! UILabel
        userNameLabel.text = contentModel?.sender![3]
        
        let userProfileTextView = cell.contentView.viewWithTag(7) as! UITextView
        userProfileTextView.text = contentModel?.sender![1]
        
        
        //ハッシュタグ関係の記述
        let reviewTextLabel = cell.contentView.viewWithTag(3) as! ActiveLabel
        reviewTextLabel.text = contentModel?.review
        
        //ハッシュタグをタップした際に、対応したハッシュタグの投稿が表示される画面へ遷移
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height
    }
    
    //webVCへ画面遷移を行う
    @IBAction func toWebView(_ sender: Any) {
        performSegue(withIdentifier: "webVC", sender: nil)
    }
    
    //webVCへの画面遷移の際に呼ばれるメソッド
    //webVCへ、shopNameの値を渡す。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webVC = segue.destination as! WebViewController
        webVC.shopName = (contentModel?.shopName)!
        
    }
    
    //プロフィール画面への遷移を行う（ユーザプロフィールイメージ画像をタップ）
    @IBAction func toProfileVC(_ sender: Any) {
        
        let profileVC = storyboard?.instantiateViewController(identifier: "profileVC") as! ProfileViewController
      
        //contentの情報を渡す
        profileVC.contentModel = contentModel
        //画面遷移
        navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    
    
    //

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
