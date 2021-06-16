//
//  WebViewController.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/27.
//

import UIKit
import WebKit  //webViewの表示のため
import PKHUD   //ローディング画面表示のため

class WebViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    //画面遷移元から、店名を獲得してくる
    var shopName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //WKNavigationDelegateのプロトコルの委任受け入れ
        webView.navigationDelegate = self
        
        //webViewがアクセスするURLを指定し、コンピュータでも認識できるようにエンコード
        let myURL = URL(string: "https://www.google.com/search?q=\(shopName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        //URLリクエストを作成
        let myRequest = URLRequest(url: myURL!)
        //作成したリクエストをもとに、webページをロードして表示する。
        webView.load(myRequest)
    }
    
    
    //戻るボタンの作成（ツールバー）
    @IBAction func back(_ sender: Any) {
        webView.goBack()
    }
    
    //進むボタンの作成（ツールバー）
    @IBAction func forward(_ sender: Any) {
        webView.goForward()
    }
    
    //webViewの読み込みが開始された際に呼び出される(ローディング画面開始)
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        HUD.show(.progress)
    }
    
    //webViewの表示が終了した際に呼び出される(ローディング画面終了)
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        HUD.hide()
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
