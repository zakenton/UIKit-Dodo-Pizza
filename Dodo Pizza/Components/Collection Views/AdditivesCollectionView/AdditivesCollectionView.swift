import UIKit
import SnapKit

final class AdditivesCollectionView: UIView {

    // MARK: - Public API
    var onSelect: ((Int) -> Void)?

    private var items: [ProductAdditiveView] = []
    private var heightConstraint: Constraint?

    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        let itemsInRow: CGFloat = 3
        let totalSpacing = layout.minimumInteritemSpacing * (itemsInRow - 1) + layout.sectionInset.left + layout.sectionInset.right
        let width = (Layout.screenWidth - totalSpacing) / itemsInRow
        layout.itemSize = CGSize(width: width, height: 180)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.registerCell(AdditivesCell.self)
        return cv
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup
    private func setup() {
        addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.snp.makeConstraints { make in
            heightConstraint = make.height.equalTo(100).constraint
        }
    }

    // MARK: - Public Method
    func update(with items: [ProductAdditiveView]) {
        self.items = items
        collectionView.reloadData()
        layoutIfNeeded()
        updateHeight()
    }
    
    func toggleSelection(in index: Int, newValue: Bool) {
        guard items.indices.contains(index) else {return}
        items[index].isSelected = newValue
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }

    private func updateHeight() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let itemsPerRow: CGFloat = 3
        let rows = ceil(CGFloat(items.count) / itemsPerRow)
        let cellHeight = layout.itemSize.height
        let spacing = layout.minimumLineSpacing
        let insets = layout.sectionInset

        let totalHeight = rows * cellHeight + max(0, rows - 1) * spacing + insets.top + insets.bottom

        heightConstraint?.update(offset: totalHeight)
        self.superview?.layoutIfNeeded()
    }
}


// MARK: - UICollectionViewDataSource & Delegate
extension AdditivesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as AdditivesCell
        let model = items[indexPath.item]
        cell.configure(with: model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelect?(indexPath.item)
    }
}
