//
//  Apperance.swift
//  WTest
//
//  Created by Edson iMAC on 20/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

struct Apperance {
    static func setNavigationBarStyle() {
        let navAppearance = UINavigationBar.appearance()
        let tabBar = UITabBar.appearance()
        let font = UIFont.systemFont(ofSize: 17, weight: .bold)
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        navAppearance.barStyle = .black
        navAppearance.barTintColor = UIColor.init(red: 61 / 255, green: 14 / 255, blue: 42 / 255, alpha: 1)
        navAppearance.isTranslucent = false
        navAppearance.tintColor = UIColor.white
        navAppearance.shadowImage = UIImage.imageWithColor(color: UIColor.init(red: 61 / 255, green: 14 / 255, blue: 42 / 255, alpha: 1))
        navAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font]
        barButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font], for: .normal)
        barButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: -200, vertical: 0), for: UIBarMetrics.default)
        tabBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
    }
}

