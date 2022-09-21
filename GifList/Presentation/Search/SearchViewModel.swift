//
//  SearchViewModel.swift
//  GifList
//
//  Created by Hwi kang on 2022/09/21.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    //MARK: Property
    private let disposeBag = DisposeBag()
    let segmentIndex = BehaviorRelay<Int>(value: 0)
    struct Input {
        var segmentedControlIndex: Driver<Int>
    }
    
    struct Output {
        var segmentIndex: Observable<Int>
    }
    
    func transform(input: Input) -> Output {
        input.segmentedControlIndex.drive{[weak self] index in
            print("index \(index)")
            self?.segmentIndex.accept(index)
        }.disposed(by: disposeBag)
        
        return Output(segmentIndex: segmentIndex.asObservable())
    }
}
