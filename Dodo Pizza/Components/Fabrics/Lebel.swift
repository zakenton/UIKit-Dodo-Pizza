import UIKit

enum LabelStyle {
    case menuLabel
    case bannerTitle
    case bannerPrice
    case productCellTitle
    case productCellDescription
    case detailDescription
    case mapMark
    case mapAddress
    case cartTitle
    case cartOption
    case cartPrice
    case emptyTitle
    case emptyDescription
}

final class Label: UILabel {
    
    init(style: LabelStyle, text: String = "") {
        super.init(frame: .zero)
        configure(with: style, text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with style: LabelStyle, text: String) {
        self.text = text
        translatesAutoresizingMaskIntoConstraints = false
        
        switch style {
        case .menuLabel:
            configureMenuLabel()
        case .bannerTitle:
            configureBannerTitle()
        case .bannerPrice:
            configureBannerPrice()
        case .productCellTitle:
            configureProductCellTitle()
        case .productCellDescription:
            configureProductCellDescription()
        case .detailDescription:
            configureDetailDescription()
        case .mapMark:
            configureMapMark()
        case .mapAddress:
            configureMapAddress()
        case .cartTitle:
            configureCartTitle()
        case .cartOption:
            configureCartOption()
        case .cartPrice:
            configureCartPrice()
        case .emptyTitle:
            configureEmptyTitle()
        case .emptyDescription:
            configureEmptyDescription()
        }
    }
    
    // MARK: - Configuration Methods
    
    private func configureMenuLabel() {
        font = .systemFont(ofSize: 25, weight: .medium)
        textAlignment = .left
        textColor = AppColor.Label.black
    }
    
    private func configureBannerTitle() {
        font = .systemFont(ofSize: 16, weight: .medium)
        textAlignment = .left
        textColor = AppColor.Label.black
    }
    
    private func configureBannerPrice() {
        font = .systemFont(ofSize: 14)
        textAlignment = .left
        textColor = AppColor.Label.black
    }
    
    private func configureProductCellTitle() {
        font = .systemFont(ofSize: 20, weight: .medium)
        textAlignment = .left
        textColor = AppColor.Label.black
    }
    
    private func configureProductCellDescription() {
        font = .systemFont(ofSize: 15, weight: .medium)
        textAlignment = .left
        textColor = AppColor.Label.gray
    }
    
    private func configureDetailDescription() {
        font = .systemFont(ofSize: 16, weight: .medium)
        textAlignment = .center
        textColor = AppColor.Label.gray
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
    
    private func configureMapMark() {
        font = .systemFont(ofSize: 18, weight: .medium)
        textAlignment = .left
        textColor = AppColor.Label.black
    }
    
    private func configureMapAddress() {
        font = .systemFont(ofSize: 15, weight: .medium)
        textAlignment = .left
        textColor = AppColor.Label.gray
    }
    
    private func configureCartTitle() {
        font = .boldSystemFont(ofSize: 16)
        numberOfLines = 1
    }
    
    private func configureCartOption() {
        font = .systemFont(ofSize: 14)
        textColor = AppColor.Label.gray
        numberOfLines = 1
    }
    
    private func configureCartPrice() {
        font = .systemFont(ofSize: 16, weight: .semibold)
        textColor = AppColor.Label.black
    }
    
    private func configureEmptyTitle() {
        font = .systemFont(ofSize: 22, weight: .bold)
        textAlignment = .center
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func configureEmptyDescription() {
        numberOfLines = 0
        font = .systemFont(ofSize: 15, weight: .medium)
        textAlignment = .center
    }
}
