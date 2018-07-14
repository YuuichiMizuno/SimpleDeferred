//
//  Result.swift
//  SimpleDeferred
//
//  Created by Yuuichi Watanabe on 2018/07/14.
//  Copyright © 2018年 WatanabeYuuichi. All rights reserved.
//

import Foundation



/// only use for sample (use alamofire)
enum Result<Value> {
    case success(Value)
    case failure(Error)
    
    var value: Value? {
        switch self {
        case .success(let value):   return value
        case .failure:              return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success:              return nil
        case .failure(let error):   return error
        }
    }
    
}


