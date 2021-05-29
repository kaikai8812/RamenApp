//
//  FollowAndFollowerViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/28.
//

import UIKit
import SDWebImage

class FollowAndFollowerViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    //前画面からのタップしたボタンを判別するtag番号
    var tag = Int()
    
    //ユーザ情報が入っている
    var followArray = [FollowModel]()
    var followerArray = [FollowerModel]()
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //遷移元のタップした箇所によって、変化
        if tag == 1 {
            segmentControl.selectedSegmentIndex = 0
        }else if tag == 2{
            segmentControl.selectedSegmentIndex = 1
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return    1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0  {
            
            return followArray.count
            
        }else if segmentControl.selectedSegmentIndex == 1{
            
            return followerArray.count
            
        } else {
            
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let userImageView = cell.contentView.viewWithTag(1) as! UIImageView
        let userNameLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        //セグメントの値でフォローかフォロワーどちらを表示させるかを判別
        
        //フォローリストを表示
        if segmentControl.selectedSegmentIndex == 0{
            userImageView.sd_setImage(with: URL(string: followArray[indexPath.row].image!), completed: nil)
            userNameLabel.text = followArray[indexPath.row].userName
            
            //フォロワーリストを表示
        } else if segmentControl.selectedSegmentIndex == 1{
            userImageView.sd_setImage(with: URL(string: followerArray[indexPath.row].image!), completed: nil)
            userNameLabel.text = followerArray[indexPath.row].userName
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contentDetailVC = storyboard?.instantiateViewController(withIdentifier: "contentDetailVC") as! ContentDetailViewController
        
        if segmentControl.selectedSegmentIndex == 0 {
            contentDetailVC.userID = followArray[indexPath.row].userID!
        } else if segmentControl.selectedSegmentIndex == 1{
            contentDetailVC.userID = followerArray[indexPath.row].userID!
        }
        
        self.navigationController?.pushViewController(contentDetailVC, animated: true)
        
    }
    
    
    
    //セグメントを変更した場合は、そのセグメントのindexに合わせて、tableViewの表示を変更する。
    @IBAction func segmentChangeAction(_ sender: UISegmentedControl) {
        
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
