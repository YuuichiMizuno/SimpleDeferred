//
//  Deferred.swift
//  SimpleDeferred
//
//  Created by Yuuichi Watanabe on 2018/04/05.
//  Copyright © 2018年 Yuuichi Watanabe. All rights reserved.
//

import UIKit



class Deferred: NSObject {

    // MARK: - properties
    enum State: Int{
        case unresolved
        case resolved
        case rejected
    }
    fileprivate var state: State = .unresolved
    fileprivate var resolvedTasks:  Array<(Any?)->Void> = []
    fileprivate var failedTasks:    Array<(Any?)->Void> = []  // rejecteds
    fileprivate var finallyTasks:   Array<(Any?)->Void> = []
    fileprivate var responseObject: Any? = nil

    
    // MARK: - public
    /// stack
    /// Feedback is necessary to advance the task.
    func then(_ callBack: @escaping (Any)->Void) -> Deferred {
        resolvedTasks.append(callBack)
        return self
    }
    /// stack
    /// Feedback is necessary to advance the task.
    func fail(_ callBack: @escaping (Any)->Void) -> Deferred {
        failedTasks.append(callBack)
        return self
    }
    /// stack
    func finally(_ callBack: @escaping (Any)->Void) -> Deferred {
        finallyTasks.append(callBack)
        return self
    }
    /// trigger
    func fire() {
        switch state {
        case .unresolved:
            self.switchResolved()
            self.excute()
        case .resolved, .rejected:
            break // Do nothing
        }
    }
    /// feedback
    func resolve(_ response: Any? = nil){
        switch state {
        case .unresolved, .resolved:
            self.switchResolved()
            self.responseObject = response
            self.excute()
        case .rejected:
            break // Do nothing
        }
    }
    /// feedback
    func reject(_ response: Any? = nil){
        // do any state
        self.switchRejected()
        self.responseObject = response
        self.excute()
    }
    /// feedback
    func finish(){
        self.excute()
    }
    
}



// MARK: - private
extension Deferred {

    fileprivate func excute() {
        switch state {
        case .unresolved, .resolved:
            self.executeResolveTask()
        case .rejected:
            self.execureFailureTask()
        }
    }
    
    fileprivate func switchResolved() {
        state = .resolved
    }
    
    fileprivate func switchRejected() {
        state = .rejected
    }
    
    fileprivate func executeResolveTask() {
        if let first = resolvedTasks.first {
            resolvedTasks.removeFirst(1)
            let response = self.responseObject ?? nil
            self.responseObject = nil
            first(response)
        }
        else if let final = finallyTasks.first {
            finallyTasks.removeFirst(1)
            final(nil)
        }
    }
    
    fileprivate func execureFailureTask() {
        if let first = failedTasks.first {
            failedTasks.removeFirst(1)
            let response = self.responseObject ?? nil
            self.responseObject = nil
            first(response)
        }
        else if let final = finallyTasks.first {
            finallyTasks.removeFirst(1)
            final(nil)
        }
    }

}
