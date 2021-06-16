//
//  Constants.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import Foundation

struct Constants {
    
    //カテゴリーを後からでも変更しやすいように、staticで管理を行う。
    //static -> 「静的」な変数、プログラム内で一回初期化したら、再度初期化することはできず、値が保持され続ける特徴を持つ。
    //カテゴリー名は、プログラムが一度立ち上がったあとは、変更されることがないのでstaticで使用している。
    //また、インスタンス化をせずともしようができるので、無駄なメモリを食わずにすむ。
    
    //カテゴリー名を表示させたい場合は、titleArrayを使用する
    static let titleArray = ["あっさり", "コッテリ", "つけ麺", "二郎系"]
    
    //データの保存、抽出など、fireStoreとの通信を行う際は、menuArrayを使用する。
    static let menuArray = ["category1", "category2", "category3", "category4"]
    
}
