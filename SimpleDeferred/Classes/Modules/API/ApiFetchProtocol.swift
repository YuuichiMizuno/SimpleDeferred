//
//  ApiFetchProtocol.swift
//  SimpleDeferred
//
//  Created by Yuuichi Watanabe on 2018/06/21.
//  Copyright © 2018年 Yuuichi Watanabe. All rights reserved.
//

import UIKit



protocol ApiFetch {

    func fetch()

    func fetchFailed(_ error: NSError)
    
    func fetchSucceeded()
    
    func fetched()
}



enum APIRespnseErrorType: Int {
    case unknwon         = 0
    case requestInvalid  = 1
    case emptyData       = 2
    case responseInvalid = 3
}
