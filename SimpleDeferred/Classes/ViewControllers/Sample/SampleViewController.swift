//
//  SampleViewController.swift
//  SimpleDeferred
//
//  Created by WatanabeYuuichi on 2018/06/24.
//  Copyright © 2018年 WatanabeYuuichi. All rights reserved.
//

import UIKit



class SampleViewController: UIViewController {

    // MARK: - properties
    let presenter = SamplePresenter()

    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetch()
    }


    // MARK: - public
    // write if need.
}



// MARK: - ApiFetch
extension SampleViewController: ApiFetch {

    func fetch() {
        let deferred = Deferred()
            deferred.then { _ in
                self.presenter.fetchWheather{ (result) in
                    switch result {
                    case .success(let value):
                        print("// VC.fetch1 > success")
                        deferred.resolve(value)
                        
                    case .failure(let error):
                        print("// VC.fetch1 > failure")
                        deferred.reject(error)
                    }
                }
            }
            .then { obj in
                self.presenter.fetchWheather{ (result) in
                    switch result {
                    case .success(let value):
                        print("// VC.fetch2 > success")
                        self.fetchSucceeded()
                        deferred.resolve(value)
                        
                    case .failure(let error):
                        print("// VC.fetch2 > failure")
                        deferred.reject(error)
                    }
                }
            }
            .fail { obj in
                if let error = obj as? NSError {
                    self.fetchFailed(error)
                }
                deferred.finish()
            }
            .finally { _ in
                self.fetched()
            }
            .fire()
    }

    func fetchFailed(_ error: NSError) {
        print("fetch 失敗しました！")
    }

    func fetchSucceeded() {
        print("fetch 成功しました！")
    }

    func fetched() {
        print("fetch 終了します。")
    }


}
