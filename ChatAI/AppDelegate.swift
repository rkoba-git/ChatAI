//
//  AppDelegate.swift
//  ChatAI
//
//  Created by 小林麟太郎 on 2023/01/05.
//

import SwiftUI

//アプリ側の動作に合わせて動かす処理
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 起動時に1回だけやる処理をここに記述する
        //起動時の処理
        APICaller.shared.setup()
        print("setup()完了")
        return true
    }
}
