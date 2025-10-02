import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - View Elements
    private let productImageView = ImageView(style: .bannerCell)
    private let titleLebel = Label(style: .bannerTitle)
    private let priceLabel = Label(style: .bannerPrice)
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLebel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: ProductView) {
        productImageView.image = UIImage(named: product.imageURL)
        titleLebel.text = product.name
        priceLabel.text = String(format: "%.2f€", product.price)
    }
}

// MARK: - Setup
extension BannerCollectionViewCell {
    private func setupView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = false
        
        
        contentView.addSubview(productImageView)
        contentView.addSubview(textStack)
    }
    
    private func setupLayout() {
        
        productImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        textStack.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
    }
}

