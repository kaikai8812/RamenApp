//
//  SceneDelegate.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let storyboard:UIStoryboard = self.grabStoryboard()
                                
        if let window = window{
        window.rootViewController = storyboard.instantiateInitialViewController() as UIViewController?
        }

        self.window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func grabStoryboard() -> UIStoryboard{
                  
                  var storyboard = UIStoryboard()
                  let height = UIScreen.main.bounds.size.height
                  if height == 896 {
                      storyboard = UIStoryboard(name: "Main", bundle: nil)
                    print("Main起動")
                    //iPhoneX,XS,11pro
                     
                  }else if height == 736 {
                      storyboard = UIStoryboard(name: "iPhone8plus", bundle: nil)
                    print("Main起動")
                      //iPhone8Plus
                  }else if height == 812{
                      storyboard = UIStoryboard(name: "iPhone11Pro", bundle: nil)
                    print("Main起動")
                       //iPhoneX,XS,11pro
                  }else if height == 667{
                      storyboard = UIStoryboard(name: "se", bundle: nil)
                    print("se起動")
                       //iPhonese
                  }else if height == 1112{
                      
                      switch UIDevice.current.model {
                      case "iPnone" :
                      storyboard = UIStoryboard(name: "se", bundle: nil)
                          break
                      case "iPad" :
                      storyboard = UIStoryboard(name: "iPad", bundle: nil)
                      print("iPad")
                          break
                      default:
                          break
                      }
                  }
                  return storyboard
          }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

