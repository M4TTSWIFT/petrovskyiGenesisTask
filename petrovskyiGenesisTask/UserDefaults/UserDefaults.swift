//
//  UserDefaults.swift
//  petrovskyiGenesisTask
//
//  Created by Mac on 24.08.2022.
//

import UIKit

class UserData {

static var shared = UserData()

private let defaults = UserDefaults.standard

private init() {
    if UserDefaults.standard.object(forKey: "isFirstRun") == nil {
        isFirstRun = true
    }
}

var isFirstRun: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "isFirstRun")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "isFirstRun")
        UserDefaults.standard.synchronize()
        }
    }
}
