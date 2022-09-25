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
    private let searchList = PublishRelay<[Gif]>()
    private var offset = 0
    private var dataSource: [Gif] = []
    private var currentSearchText = ""
    struct Input {
        var segmentedControlIndex: Driver<Int>
        var searchText: Driver<String>
    }
    
    struct Output {
        var segmentIndex: Observable<Int>
        var searchList: Observable<[Gif]>

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
        
        return Output(segmentIndex: segmentIndex.asObservable(),searchList: searchList.asObservable())
    }
    
    func search(_ text: String) {
        Task {
            offset = 0
            currentSearchText = text
            let gifs = try await Network.search(text: text, offset:offset)
            
            dataSource = gifs
            searchList.accept(dataSource)
            offset += 1
        }
    }
    
    func searchMore() {
        
        Task {
            let gifs = try await Network.search(text: currentSearchText, offset:offset)
            dataSource.append(contentsOf: gifs)
            searchList.accept(dataSource)
            offset += 1

        }

    }
    
    func getGif(index: Int) -> Gif {
        return dataSource[index]
    }
    
    func getDataCount() -> Int {
        return dataSource.count
    }
}
