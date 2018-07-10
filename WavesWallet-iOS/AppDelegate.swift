//
//  AppDelegate.swift
//  WavesWallet-iOS
//
//  Created by Alexey Koloskov on 20/04/2017.
//  Copyright © 2017 Waves Platform. All rights reserved.
//

import Gloss
import IQKeyboardManagerSwift
import Moya
import RESideMenu
import SVProgressHUD
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let accountBalanceInteractor = AccountBalanceInteractor()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true

        self.showStartController()

        SVProgressHUD.setOffsetFromCenter(UIOffsetMake(0, 40))
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)

        UIBarButtonItem.appearance().tintColor = UIColor.black

//        let hello = StoryboardManager.HelloStoryboard().instantiateViewController(withIdentifier: "HelloLanguagesViewController") as! HelloLanguagesViewController

//        let enter = StoryboardManager.EnterStoryboard().instantiateViewController(withIdentifier: "EnterStartViewController") as! EnterStartViewController
//        let nav = UINavigationController(rootViewController: enter)
//
//        let menuController = StoryboardManager.MainStoryboard().instantiateViewController(withIdentifier: "MenuViewController")
//        let sideMenuViewController = RESideMenu(contentViewController: nav, leftMenuViewController: menuController, rightMenuViewController: nil)!
//        sideMenuViewController.view.backgroundColor = menuController.view.backgroundColor
//        sideMenuViewController.contentViewShadowOffset = CGSize(width: 0, height: 10)
//        sideMenuViewController.contentViewShadowOpacity = 0.2
//        sideMenuViewController.contentViewShadowRadius = 15
//        sideMenuViewController.contentViewShadowEnabled = true
//        sideMenuViewController.panGestureEnabled = false
//        window?.rootViewController = sideMenuViewController

//        .map(DataService.Response<[DataService.Response<DataService.Model.Asset>]>.self)
//        let appservice = self.appservice
//            .rx
//            .request(.getAsset(id: "EvN8cvuGKC2t1PA8ZEsgJth3paenSP4UAd8Z6K14z2P4"))
//            .map(API.Response<API.Model.Asset>.self)
//
//        appservice.subscribe(onSuccess: { model in
//            print("model: \(model)")
//        }) { error in
//            print("error: \(error)")
//        }

        accountBalanceInteractor
            .balanceBy(accountId: "3PCAB4sHXgvtu5NPoen6EXR5yaNbvsEA8Fj")
            .subscribe(onNext: { model in
                print("model: \(model)")
            }, onError: { error in
                print("error: \(error)")
            })

//        let addreses = self.nodeService
//            .rx
//            .request(.getAccountBalance(id: "3PCAB4sHXgvtu5NPoen6EXR5yaNbvsEA8Fj"))
//            .map(Node.Model.AccountBalance.self).subscribe(onSuccess: { (account) in
//                print("model: \(account)")
//            }) { (error) in
//                print("error: \(error)")
//            }
//
//
//        let assets = self.nodeAssetsService
//            .rx
//            .request(.getBalanceForAssets(accountId: "3PCAB4sHXgvtu5NPoen6EXR5yaNbvsEA8Fj"))
//            .map([Node.Model.AssetBalance].self).subscribe(onSuccess: { (account) in
//                print("model: \(account)")
//            }) { (error) in
//                print("error: \(error)")
//        }

        return true
    }

    func showStartController() {
        self.window?.backgroundColor = AppColors.wavesColor
        let realm = WalletManager.getWalletsRealm()
        let w = realm.objects(WalletItem.self).filter("isLoggedIn == true")
        if w.count > 0 {
            WalletManager.didLogin(toWallet: w[0])
        } else {
            self.window!.rootViewController = StoryboardManager.launchViewController()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        WalletManager.clearPrivateMemoryKey()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if let urlScheme = url.scheme, urlScheme == "waves" {
            OpenUrlManager.openUrl = url
            return true
        } else {
            return false
        }
    }

    class func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
