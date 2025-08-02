import UIKit

class EmptyView: UIView {
    
    var emptyImageView = ImageView(style: .emptyView)
    
    var emptyTitleLabel = Label(style: .emptyTitle, text: "Nothing here yet... 🍕")
    
    var emptyDescriptionLabel = Label(style: .emptyDescription, text: "Add a pizza to your cart! Or maybe two)")
    
    var emptyShippingLabel = Label(style: .emptyDescription, text: "We'll deliver your order from €10🚀")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyView {
    func setupViews() {
        
        addSubview(emptyImageView)
        addSubview(emptyTitleLabel)
        addSubview(emptyDescriptionLabel)
        addSubview(emptyShippingLabel)
    }
    
    func setupConstraints() {
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(self).inset(110)
            make.left.right.equalTo(self).inset(10)
        }
        
        emptyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(65)
            make.centerX.equalTo(self)
        }
        
        emptyDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyTitleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(self).inset(50)
            make.centerX.equalTo(self)
        }
        
        emptyShippingLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyDescriptionLabel.snp.bottom).offset(10)
            make.left.right.equalTo(self).inset(50)
            make.centerX.equalTo(self)
        }
    }
}
