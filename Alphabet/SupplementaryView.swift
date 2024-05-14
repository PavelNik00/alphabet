//
//  SupplementaryView.swift
//  Alphabet
//
//  Created by Pavel Nikipelov on 16.04.2024.
//

/* Создаем отдельный класс для нашего хедера и футера то есть для supplementary view
который наследуется от UICollectionReusableView
 */

import UIKit

class SupplementaryView: UICollectionReusableView {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
