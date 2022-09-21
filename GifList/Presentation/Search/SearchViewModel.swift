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
        var searchText: Driver<String>
    }
    
    struct Output {
        var segmentIndex: Observable<Int>
    }
    
    func transform(input: Input) -> Output {
        input.segmentedControlIndex.drive{[weak self] index in
            print("index \(index)")
            self?.segmentIndex.accept(index)
        }.disposed(by: disposeBag)
        input.searchText
            .throttle(.milliseconds(2000))
            .drive{ [weak self] text in
            print("text \(text)")
            self?.search(text)
        }.disposed(by: disposeBag)
        return Output(segmentIndex: segmentIndex.asObservable())
    }
    
    func search(_ text: String) {
       
        
        do {
            try  Network.search(text, offset: 0)
        } catch let error {
            print(error)
        }
    }
}
