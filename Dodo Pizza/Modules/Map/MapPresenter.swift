//
//  MapPresenter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 26.08.25.
//

protocol IMapPresenterInput: AnyObject {
    func viewDidLoad()
    func didSelectRestoran(address: Address)
}

final class MapPresenter {
    weak var view: IMapVCInput?
    
    private var interactor: IMapInteractorInput
    
    init(interactor: IMapInteractorInput) {
        self.interactor = interactor
    }
}

extension MapPresenter: IMapPresenterInput {
    func viewDidLoad() {
        interactor.getRestorans()
    }
    
    func didSelectRestoran(address: Address) {
        
    }
}

extension MapPresenter: IMapInteractorOutput {
    func didLoad(addresses: [Address]) {
        view?.fetchRestorans(address: addresses)
    }
    
    func didFail(_ error: any Error) {
        
    }
}

private extension MapPresenter {
    
}

