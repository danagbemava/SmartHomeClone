//
//  GadgetControlView.swift
//  SmartHomeClone
//
//  Created by Daniel Agbemava on 22/07/2022.
//

import SwiftUI

struct GadgetControlView: View {

    @State var isActive: Bool = false
    var icon: String

    var body: some View {
        Image(systemName: icon)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .foregroundColor(isActive ? .black : .white)
            .background(isActive ? .white : .white.opacity(0.4))
            .cornerRadius(16)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isActive.toggle()
                }
            }
//            .padding()

    }
}

struct GadgetControlView_Previews: PreviewProvider {
    static var previews: some View {
        GadgetControlView(
            icon: "snowflake"
        )
    }
}
