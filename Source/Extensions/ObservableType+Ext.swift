//
//  ObservableType+Ext.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType {
    
    func sinkErrorMessage(into relay: BehaviorRelay<String?>) -> Observable<Element> {
        self.catch { error in
            relay.accept(error.localizedDescription)
            return .error(error)
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }
}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

