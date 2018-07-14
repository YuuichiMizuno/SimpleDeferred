//
//  SamplePresenter.swift
//  SimpleDeferred
//
//  Created by WatanabeYuuichi on 2018/06/24.
//  Copyright © 2018年 WatanabeYuuichi. All rights reserved.
//

import UIKit



class SamplePresenter: NSObject {

    // MARK: - properties
    let wheatherModel = WheatherModel()
    
    
    // MARK: - properties
    func fetchWheather(_ handler: @escaping (Result<Any>) -> Void) {
        wheatherModel.fetch() { (result) in
            switch result {
            case .success(let value): handler(Result.success(value))
            case .failure(let error): handler(Result.failure(error))
            }
        }
    }

}
