//
//  CameraViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import UIKit
import SDWebImage
import Cosmos
import FirebaseAuth

class ContentsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GetDataProtocol {
   
    
    
    
    //indexの値で、loadするカテゴリーの種類を判別する。
    var index = Int()
    
    var contentModelArray = [ContentModel]()
    var loadModel = LoadModel()
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //渡ってきたindexの値によって、loadするデータを場合分けする
        switch index {
        case index:
            
            //デリゲートメソッドの委任
            loadModel.getDataProtocol = self
            
            //indexを用いて、カテゴリーを判別してデータをダウンロード
            loadModel.loadContents(category: Constants.menuArray[index])
            
            //collectionView関係のプロトコル委任
            collectionView.delegate = self
            collectionView.dataSource = self
            
        default:
            break
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //collectionView更新用デリゲートメソッド(fireStoreから撮ってきたデータを格納した配列がdataArrayに入っている。)
    func getData(dataArray: [ContentModel]) {
        contentModelArray = []
        contentModelArray = dataArray
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //ここ、switch文必要なのか？？呼ばれる際には一旦contentModelArrayのなかみは確定しているのではないか？？
//        switch index {
//        case index:
            return contentModelArray.count
//        default:
//            break
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        //セルのデザイン設定
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        
        //表示するcontentの内容設定
        
        //投稿imageの設定
        let contentImageView = cell.contentView.viewWithTag(1) as! UIImageView
        contentImageView.sd_setImage(with: URL(string: contentModelArray[indexPath.row].imageURLString!), completed: nil)
        contentImageView.layer.cornerRadius = 20
        
        //店名labelの表示設定
        let contentLabel = cell.contentView.viewWithTag(2) as! UILabel
        contentLabel.text = contentModelArray[indexPath.row].shopName
        
        //星レビューの表示設定
        let contentCosmosView = cell.contentView.viewWithTag(3) as! CosmosView
        contentCosmosView.rating = contentModelArray[indexPath.row].rate!
        
        
        return cell
    }
    
    //セルをタップした際の挙動
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //移動先には、どのデータをタップしたのかを判別できるようにしなくては鳴らない！
        performSegue(withIdentifier: "detailVC", sender: indexPath.row)
    }
    
    
    //detailVCへ画面遷移する際に、タップしたcontentの情報を送信する記述
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailVC = segue.destination as? DetailViewController
        
        //senderとしてタップしたセルのindexPath.rowが渡ってきている。
        detailVC?.contentModel = contentModelArray[sender as! Int]
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
