import UIKit

enum ImageStyle {
    case logoHeader
    case bannerCell
    case productCell
    case detail
    case cart
    case emptyView
}

final class ImageView: UIImageView {
    
    private let style: ImageStyle
    private let imageUrl: String?
    
    init(style: ImageStyle, imageUrl: String? = nil) {
        self.style = style
        self.imageUrl = imageUrl
        super.init(frame: .zero)
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        switch style {
        case .logoHeader:
            configureLogoHeader()
        case .bannerCell:
            configureBannerCell()
        case .productCell:
            configureProductCell()
        case .detail:
            configureDetailImage()
        case .cart:
            configureCartImage()
        case .emptyView:
            configureEmptyView()
        }
    }
    
    // MARK: - Configuration Methods
    
    private func configureLogoHeader() {
        image = UIImage(named: "logoDodoPizza")
        contentMode = .scaleAspectFill
        clipsToBounds = true
        let aspectRatio: CGFloat = 386 / 2316
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: widthAnchor, multiplier: aspectRatio)
        ])
    }
    
    private func configureBannerCell() {
        contentMode = .scaleAspectFill
        let size = Layout.screenWidth * 0.20
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    private func configureProductCell() {
        image = UIImage.hawaii
        contentMode = .scaleAspectFill
        let size = Layout.screenWidth * 0.40
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    private func configureDetailImage() {
        contentMode = .scaleAspectFit
        let size = Layout.screenWidth * 0.70
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    private func configureCartImage() {
        contentMode = .scaleAspectFill
    }
    
    private func configureEmptyView() {
        image = UIImage(named: "empty view")
        contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([

            heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
