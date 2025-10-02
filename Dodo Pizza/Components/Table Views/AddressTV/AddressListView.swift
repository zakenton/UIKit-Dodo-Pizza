import UIKit
import SnapKit

final class AddressListView: UIView {

    var onSelect: ((Address) -> Void)?
    func update(addresses: [Address]) {
        self.addresses = addresses
        tableView.reloadData()
        updateHeightConstraintIfNeeded()
    }

    // MARK: Private
    private var addresses: [Address] = []

    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = .white
        tv.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        tv.showsVerticalScrollIndicator = true
        tv.tableFooterView = UIView()
        return tv
    }()

    private var heightConstraint: Constraint?

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addViews()
        setupConstraints()
        configureTable()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension AddressListView {
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 12
        clipsToBounds = true
    }

    func addViews() {
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.snp.makeConstraints { make in
            heightConstraint = make.height.lessThanOrEqualTo(260).constraint
        }
    }

    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: AddressTableViewCell.reuseId)
    }

    func updateHeightConstraintIfNeeded() {
        layoutIfNeeded()
        tableView.layoutIfNeeded()
        let contentHeight = tableView.contentSize.height
        let target = min(contentHeight, 260)
        heightConstraint?.update(offset: target)
        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension AddressListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { addresses.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressTableViewCell = tableView.dequeueCell(indexPath)
        cell.configure(address: addresses[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selected = addresses[indexPath.row]
        onSelect?(selected)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 64 }
}
