//
//  MapVC.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 29.06.25.
//

import UIKit
import MapKit

protocol IMapVCInput: AnyObject {
    func fetchRestorans(address: [Address])
    func fetchUserAddress(address: [Address])
    func showUserPin(at coordinate: CLLocationCoordinate2D, title: String, subtitle: String?)
    func showMessage(_ text: String)
    func promptSaveAddress(availableMarks: [Mark])
}

class MapVC: UIViewController {
    private let presenter: IMapPresenterInput
    private lazy var selectOptions = SelectorView()
    lazy var mapView = MapView()
    lazy var bottomSheet = BottomSheetView()

    private let inputDebouncer = Debouncer(delay: 0.6)

    init(presenter: IMapPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupViews()

        selectOptions.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        bottomSheet.configure(for: .delivery)
        bottomSheet.onConfirmTap = { [weak self] in
                self?.presenter.confirmCurrentAddress()
            }
        bottomSheet.addressDelegate = self
        bottomSheet.bindAddressInput()
    }
}

// MARK: - IMapVCInput
extension MapVC: IMapVCInput {
    func fetchRestorans(address: [Address]) {
        mapView.setupMap(restaurants: address)
    }

    func fetchUserAddress(address: [Address]) {
        
    }
    
    func showUserPin(at coordinate: CLLocationCoordinate2D, title: String, subtitle: String?) {
        mapView.centerMap(on: coordinate)
        mapView.addAnnotation(at: coordinate, title: title, subtitle: subtitle)
    }
    
    func promptSaveAddress(availableMarks: [Mark]) {
        let alert = UIAlertController(title: "Сохранить адрес?",
                                      message: "Выберите метку для адреса.",
                                      preferredStyle: .actionSheet)
        for m in availableMarks {
            alert.addAction(UIAlertAction(title: m.rawValue, style: .default, handler: { [weak self] _ in
                self?.presenter.saveConfirmedAddress(with: m)
            }))
        }
        alert.addAction(UIAlertAction(title: "Не сохранять", style: .cancel))
        present(alert, animated: true)
    }
    
    func showMessage(_ text: String) {
        let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak alert] in
            alert?.dismiss(animated: true)
        }
    }
}

// MARK: - AddressInputViewDelegate
extension MapVC: AddressInputViewDelegate {
    func addressInputDidChange(_ text: String) {
        inputDebouncer.submit { [weak self] in
            self?.presenter.searchAddress(query: text) // геокодинг теперь вне VC
        }
    }
    func addressInputDidSubmit(_ text: String) {
        presenter.searchAddress(query: text)
    }
}

// MARK: - SetupViews
private extension MapVC {
    @objc func selectionChanged(_ sender: SelectorView) {
        bottomSheet.configure(for: sender.selectedIndex == 0 ? .delivery : .order)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        addViews()
        setupConstraints()
        bottomSheet.fetchAdresses(restorant: StoreService.fetchStores())
    }

    func addViews() {
        view.addSubview(mapView)
        view.addSubview(selectOptions)
        view.addSubview(bottomSheet)
    }

    func setupConstraints() {
        mapView.snp.makeConstraints { $0.edges.equalToSuperview() }
        selectOptions.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(Layout.offset8)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        bottomSheet.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.40)
        }
    }
}

//MARK: Debouncer
final class Debouncer {
    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?

    init(delay: TimeInterval) { self.delay = delay }

    func submit(_ action: @escaping () -> Void) {
        workItem?.cancel()
        let item = DispatchWorkItem(block: action)
        workItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
    }
}
