//
//  LetterCollectionViewCell.swift
//  Alphabet
//
//  Created by Pavel Nikipelov on 16.04.2024.
//

/* Создаем отдельный класс для нашей ячейки, чтобы использовать ее а не дефолтную
который наследуется от UICollectionViewCell
 */

import UIKit

class LetterCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    // перезаписываем стандартный метод чтобы использовать нашу ячейку а не дефолтную
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel) // добавляем наш лейбл
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([ // настраиваем констрейнты
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
