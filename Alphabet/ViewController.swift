//
//  ViewController.swift
//  Alphabet
//
//  Created by Pavel Nikipelov on 16.04.2024.
//

import UIKit

class ViewController: UIViewController {

    // Создаем collectionView с помощью конструктора UICollectionView
    let collectionView: UICollectionView = {
        // Создаем flow layout для collectionView
        let layout = UICollectionViewFlowLayout()
        // Устанавливаем ориентацию прокрутки вертикальной
        layout.scrollDirection = .vertical
        // Создаем collectionView с полученным layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Возвращаем созданный collectionView
        return collectionView
    }()
    
    private let letters = [
                "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к",
                "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц",
                "ч", "ш" , "щ", "ъ", "ы", "ь", "э", "ю", "я"
            ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрируем нашу ячейку с наследованием от класса, который мы создали ранее
        collectionView.register(LetterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // регистрируем хедер для нашей вью
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        // регистрируем футер для нашей вью
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        
        view.addSubview(collectionView)
        
        setupCollectionView()
    }

    func setupCollectionView() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // прописываем что источник данных в самом классе
        collectionView.dataSource = self
        
        // прописываем наш вью контроллер делегатом коллекции
        collectionView.delegate = self
    }
}


// расщирение для непосредственного создания нашей ячейки и прописывание сколько их будет(1) и настройка нашей ячейки(2)
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count // количество объектов в массиве леттер (вместо того чтобы писать четкое количество, так как массив может меняться
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LetterCollectionViewCell // приводим к типу нашей новой ячейки
        
        cell?.titleLabel.text = letters[indexPath.row]
        cell?.titleLabel.textColor = .white
        cell?.contentView.backgroundColor = .gray
        
        return cell!
    }
}

// расширение для непосредственного создания наших хедеров и футеров
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        case UICollectionView.elementKindSectionFooter:
            id = "footer"
        default:
            id = ""
        }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as! SupplementaryView
        view.titleLabel.text = "Здесь находится Supplementary view"
        return view
    }
}

// необходимо для управления размерами элемента нашего хедера и футера
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // хедер
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section) // получаем на вход номер
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath) // получаем у коллекции вью
        
        return headerView.systemLayoutSizeFitting( // рассчитываем размер
            CGSize(width: collectionView.frame.width,
                   height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel)
    }
    
    // футер
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let footerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: indexPath)
        
        return footerView.systemLayoutSizeFitting( // рассчитываем размер
            CGSize(width: collectionView.frame.width,
                   height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel)
    }
    
    // задаем размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: 50) // ширину коллекции делем на два чтобы на каждой строке помещалось ровно по 2 ячейки, высоту делаем 50
    }
    
    // задаем отступ на строке между ячейками (равный 0, чтобы у нас располагалось по 2 ячейки на строке)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // задаем отступ в столбце между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

