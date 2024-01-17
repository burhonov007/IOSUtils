//
//  HorizontalList.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: HORIZONTAL COLLECTION VIEW

import UIKit

protocol HorizontalListDelegate {
    associatedtype Model
    func configure(data: Model, indexPath: IndexPath)
}

class HorizontalList<T: UICollectionViewCell, M>: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where T : HorizontalListDelegate, T.Model == M {
    
    private let cellIdentifier = "cell"
    private var collectionView: UICollectionView!
    private var _heightAnchor: NSLayoutConstraint!
    
    var data: [M] = [] {
        didSet { collectionView.reloadData() }
    }
    var spacing: CGFloat = 0.0 {
        didSet { collectionView.reloadData() }
    }
    var cellWidth: CGFloat?  {
        didSet { collectionView.reloadData() }
    }
    var cellMultiplier: CGFloat? {
        didSet { collectionView.reloadData() }
    }
    var cellHeight: CGFloat = 0.0 {
        didSet { _heightAnchor.constant = padding.top + cellHeight + padding.bottom }
    }
    
    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            _heightAnchor.constant = padding.top + cellHeight + padding.bottom
            collectionView.reloadData()
        }
    }
    
    var didSelect: ((M) -> Void)?
    var didChangePage: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func scrollToPage(page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        _heightAnchor = collectionView.heightAnchor.constraint(equalToConstant: 0)
        _heightAnchor.isActive = true
        
        collectionView.register(T.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let indexPath = collectionView.getCurrentIndex() else { return }
        didChangePage?(indexPath.row)
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! T
        cell.configure(data: data[indexPath.row], indexPath: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(data[indexPath.row])
    }
    
        
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cellWidth = cellWidth {
            return CGSize(width: cellWidth, height: cellHeight)
        }
        if let cellMultiplier = cellMultiplier {
            return CGSize(width: cellHeight * cellMultiplier, height: cellHeight)
        }
        return CGSize(width: cellHeight, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return padding
    }
    
}


// MARK: USAGE

/// var paymentsBtn = UICreator.arrowBtnCreator(title: "Платежи")
/// var horizontalList = HorizontalList<PaymentsCell, Payments>()
/// let paymentsData = [
///     Payments(image: UIImage(named: "payment1")!, title: "Оплата по QR"),
///     Payments(image: UIImage(named: "phone")!, title: "Мобильная связь"),
///     Payments(image: UIImage(named: "payment2")!, title: "Интернете, TV, подписки"),
///     Payments(image: UIImage(named: "payment3")!, title: "Коммунальные услуги"),
///     Payments(image: UIImage(named: "payment4")!, title: "Транспортные карты"),
/// ]
/// private func setupView() {
///     horizontalList.data = paymentsData
///     horizontalList.cellHeight = 102
///     horizontalList.cellWidth = 115
///     horizontalList.spacing = 10
///     horizontalList.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
///     horizontalList.didSelect = { data in
///         print(data)
///     }
/// }
