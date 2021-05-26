//
//  UserDefauts.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import Foundation

class UserDefaultsEX: UserDefaults {
    
    //構造体をアプリ内に保存するために作成
    
    //Element = 要素、Codable = プロトコル(型)
    //JSONEncoderを用いてエンコード(Data型へ変換)→Userdefaultsへセット
    func set<Element: Codable>(value: Element, forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    //Element = 要素、Codable = プロトコル(型)
    //JSONDecoderを用いてデコード(Data型を構造体へ変換)
    func codable<Element: Codable>(forKey key: String) -> Element? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let element = try? JSONDecoder().decode(Element.self, from: data)
        return element
    }
}
