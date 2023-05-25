//
//  GadgetObservable.swift
//  SmartHomeClone
//
//  Created by Daniel Agbemava on 22/07/2022.
//

import Foundation
import SwiftUI

class GadgetObservable: ObservableObject {

    @Published public var isOn: Bool = false
    var name: String
    var onIconName: String
    var offIconName: String
    var backgroundColor: Color



    init(name: String, onIconName: String, offIconName: String, backgroundColor: Color) {
        self.name = name
        self.onIconName = onIconName
        self.offIconName = offIconName
        self.backgroundColor = backgroundColor
    }

}
