//
//  Observable+Ext.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
