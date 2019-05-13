//
//  SearchPresenter.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public protocol SearchPresenterProtocol {
    var gifItems: [GifDTO] { set get }
    func search( _ value: String)
    func cancel()
    func getGifs() 
}

public class SearchPresenter: SearchPresenterProtocol {

    public var interactor: SearchInteractorProtocol!
    public var wireframe: SearchWireframeProtocol!
    public weak var view: SearchViewControllerProtocol?
    public var gifItems = [GifDTO]()
    
    private var value: String = ""
    
    public func search( _ value: String) {
        self.value = value
        self.view?.startLoading()
        interactor.searchWith(value) { [weak self] (item, error) in
            
            self?.view?.finishLoading()
            
            if var gifItem = item, error == nil {
                gifItem.title = value
                self?.interactor.save(gifItem)
                self?.view?.reload()
            } else {
                DispatchQueue.main.async {
                    self?.view?.alert(message: "We cannot found Gif", title: "Sorry!")
                }
            }
        }
    }
    
    public func getGifs() {
        gifItems = interactor.setAllItems()
    }
    
    public func cancel() {
        DispatchQueue.main.async {
            self.view?.reload()
        }
    }
}
