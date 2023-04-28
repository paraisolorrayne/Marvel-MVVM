import Foundation
import UIKit

final class ComicsViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero)
        return collectionView
    }()
    
    private let viewModel: ComicsViewModelProtocol
    
    init(viewModel: ComicsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchComicList()
        bindViewModelEvent()
    }

    override func loadView() {
        // create a layout to be used
        let layout = createLayout()
        // set the frame and layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // set the view to be this UICollectionView
        self.view = collectionView
    }

    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(112))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ComicsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension ComicsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ComicCollectionViewCell.self)", for: indexPath) as? ComicCollectionViewCell else {
            fatalError("Unable to dequeue subclassed cell")
        }

        let data = viewModel.getModelForCell(index: indexPath.row)
        cell.setupCell(model: ComicDTO.Resume.init(image: data.image, title: data.title))
        
        return cell
    }
}
private extension ComicsViewController {
    private func configureView() {
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: "\(ComicCollectionViewCell.self)")
    }
    
    private func fetchComicList() {
        viewModel.fetchComicList()
    }
    
    private func bindViewModelEvent() {
        viewModel.onFetchComicSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.onFetchComicFailure = { error in
            print(error)
        }
    }
}
