//
//  ContentDetailViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/28.
//

import UIKit

class ContentDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, GetDataProtocol {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var loadModel:LoadModel?
    var contentModel:ContentModel?
    var contentModelArray = [ContentModel]()
    
    //userIDは、遷移前画面から渡ってくる
    var userID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadModel?.getDataProtocol = self
        
        tableView.register(UINib(nibName: "ContentCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        loadModel?.loadOwnContents(userID: userID)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentModelArray.count
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 329    //適当
    }
    
    func getData(dataArray: [ContentModel]) {
        contentModelArray = []
        contentModelArray = dataArray
        tableView.reloadData()
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
