//
//  CountryImageCarouselTableViewCell.swift
//  TouristGuideUIkit
//
//  Created by Neosoft on 03/10/24.
//

import UIKit

protocol CountryImageCarouselProtocol: AnyObject {
    func categoryDidChange(index: Int)
}
class CountryImageCarouselTableViewCell: UITableViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: CountryImageCarouselProtocol?
    
    var countryList: [Country]? {
        didSet{
            pageControl.numberOfPages = countryList?.count ?? 0
            pageControl.currentPage = 0
            pageControl.currentPageIndicatorTintColor = .red
            pageControl.pageIndicatorTintColor = .systemPink
                .withAlphaComponent(0.3)
        }
    }
    var updateBottomView: ((Int) -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerXIBCell(type: CountryImageCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CountryImageCarouselTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CountryImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryImageCollectionViewCell", for: indexPath) as? CountryImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let image = countryList?[indexPath.item].image else {
            cell.countryFlagImage.image = UIImage(systemName: "photo.artframe")
            return cell
        }
        cell.countryFlagImage.image = UIImage(named: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        updateBottomView?(pageControl.currentPage)
        guard let delegate = delegate else { return }
        delegate.categoryDidChange(index: pageControl.currentPage)
    }
}
