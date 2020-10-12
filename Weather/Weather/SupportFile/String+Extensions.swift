//
//  String+Extensions.swift
//  Weather
//
//  Created by Кирилл Коновалов on 9.10.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation

extension String {
    func escaped() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
