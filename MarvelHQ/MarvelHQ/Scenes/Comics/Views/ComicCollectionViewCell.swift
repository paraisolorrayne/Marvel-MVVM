import UIKit

final class ComicCollectionViewCell: UICollectionViewCell {

    fileprivate let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configureView() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 74).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setupCell(model: ComicDTO.Resume) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string:model.image) ?? URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGo9Pe1tGuaOoWxPNX6xlcAZdrc9-qygmQPw&usqp=CAU")!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(named: "AppIcon")
                }
            }
        }
        titleLabel.text = model.title
    }
}
