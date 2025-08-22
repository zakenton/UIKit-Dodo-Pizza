//
//  DeliveryView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 20.07.25.
//

import UIKit
import SnapKit
import CoreLocation

final class DeliveryView: UIView {

    // MARK: UI Elements
    private let myAddressButton = Button(style: .savedAddress("Saved Address"))

    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Houpt str. 1, 98000 Berlin"
        tf.font = .systemFont(ofSize: 16)
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.isUserInteractionEnabled = true
        return tf
    }()

    private let saveAddressButton = Button(style: .useThisAddress("Use this Address"))

    // Наш новый список
    private let addressListView = AddressListView()

    // Паблик API: наружу отдаем выбранный адрес
    var onAddressPicked: ((Address) -> Void)?

    // Локальное состояние
    private var isShowingList = false

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addViews()
        setupConstraints()
        addTargets()
        showAddNewAddressView() // стартуем с формы ввода
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: Public
extension DeliveryView {
    /// Передай сохранённые адреса сюда — список обновится
    func setSavedAddresses(_ addresses: [Address]) {
        addressListView.update(addresses: addresses)
    }
}

//MARK: Button Action
private extension DeliveryView {

    func addTargets() {
        myAddressButton.addTarget(self, action: #selector(didTapChangeViewButton), for: .touchUpInside)

        // обработка выбора адреса из списка
        addressListView.onSelect = { [weak self] selected in
            guard let self else { return }
            self.onAddressPicked?(selected)
            // Заполним поле и вернемся к форме
            self.addressTextField.text = "\(selected.address), \(selected.zipcode) \(selected.city)"
            self.toggleMode(showList: false)
        }
    }

    @objc func didTapChangeViewButton() {
        toggleMode(showList: !isShowingList)
    }

    func toggleMode(showList: Bool) {
        isShowingList = showList
        if showList {
            showAddressList()
        } else {
            showAddNewAddressView()
        }
    }
}


//MARK: Setup View
private extension DeliveryView {

    func showAddressList() {
        addressTextField.isHidden = true
        saveAddressButton.isHidden = true
        addressListView.isHidden = false
        myAddressButton.configuration?.attributedTitle = AttributedString("+ Add new")
        // затемним фон родительского DeliveryView и отключим взаимодействия вне списка
        backgroundColor = UIColor.black.withAlphaComponent(0.03)
        isUserInteractionEnabled = true
    }

    func showAddNewAddressView() {
        addressTextField.isHidden = false
        saveAddressButton.isHidden = false
        addressListView.isHidden = true
        myAddressButton.configuration?.attributedTitle = AttributedString("📍Saved Address")
        backgroundColor = .white
        isUserInteractionEnabled = true
    }

    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 15
        clipsToBounds = true
    }

    //MARK: add Views
    func addViews() {
        addSubview(myAddressButton)
        addSubview(addressTextField)
        addSubview(saveAddressButton)
        addSubview(addressListView)
    }

    // MARK: Constraints
    func setupConstraints() {
        myAddressButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalTo(snp.centerX).inset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }

        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(myAddressButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }

        saveAddressButton.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(12)
        }

        addressListView.snp.makeConstraints { make in
            make.top.equalTo(myAddressButton.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12) // даст таблице шанс занять всё доступное пространство
        }
    }
}
