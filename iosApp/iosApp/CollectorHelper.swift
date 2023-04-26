//
//  CollectorHelper.swift
//  iosApp
//
//  Created by WonHee Jung on 2023/04/26.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

class Collector<T> : Kotlinx_coroutines_coreFlowCollector {
    let callback:(T) -> Void

    init(callback: @escaping (T) -> Void) {
        self.callback = callback
    }
    
    func emit(value: Any?, completionHandler: @escaping (Error?) -> Void) {
        callback(value as! T)
        completionHandler(nil)
    }
}
