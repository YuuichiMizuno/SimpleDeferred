//
//  WheatherModel.swift
//  SimpleDeferred
//
//  Created by Yuuichi Watanabe on 2018/07/14.
//  Copyright © 2018年 WatanabeYuuichi. All rights reserved.
//

import UIKit



class WheatherModel: NSObject {

    // MARK: - public
    func fetch(_ handler: @escaping (Result<Any>) -> Void) {
        
        // dummy. only for sample.  write fetch with AlamoFire.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            handler(Result.success("dummyVlaue"))
        }
    }
    
}
