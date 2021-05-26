//
//  CheckModel.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/26.
//

import Foundation
import Photos

class CheckModel{
    
    func showCheckPermission(){
        PHPhotoLibrary.requestAuthorization{ (status) in
            switch(status){
            
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorized:
                print("authorized")
            case .limited:
                print("limited")
            @unknown default:
                break
            }
        }
        
    }
    
}
