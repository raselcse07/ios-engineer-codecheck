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
    
    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { error in
            assertionFailure("Error!!!")
            return Driver.empty()
        }
    }
}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

