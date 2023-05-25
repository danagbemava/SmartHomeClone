//
//  GadgetView.swift
//  SmartHomeClone
//
//  Created by Daniel Agbemava on 21/07/2022.
//

import SwiftUI

struct GadgetView<Destination: View>: View {

    @StateObject var gadgetObserver: GadgetObservable
    @ViewBuilder var destinationView: Destination

    var body: some View {
        NavigationLink(destination: destinationView) {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: gadgetObserver.isOn ? gadgetObserver.onIconName : gadgetObserver.offIconName)
                //                    . resizable()
                //                    .frame(width: 30, height: 20)
                    .foregroundColor(gadgetObserver.isOn ? .white : .black)


                Text(gadgetObserver.name)
                    .foregroundColor(gadgetObserver.isOn ? .white : .black)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)

                //                Spacer()
                //                    .frame(height: 20)

                Toggle(isOn: $gadgetObserver.isOn) {
                    Text("")
                }
                .toggleStyle(CustomToggleStyle())

            }
            .padding()
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 16).fill(gadgetObserver.isOn ? gadgetObserver.backgroundColor : .white))
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1))
            .foregroundColor(gadgetObserver.isOn ? gadgetObserver.backgroundColor : .black)
        }.buttonStyle(NoHighlightButtonStyle())

    }
}

struct GadgetView_Previews: PreviewProvider {
    static var previews: some View {
        let observer = GadgetObservable(name: "Smart Spotlight", onIconName: "light.max", offIconName: "light.min", backgroundColor: Color.red)
        GadgetView(gadgetObserver: observer) {
            GadgetDetailView(gadgetObserver: observer)
        }

    }
}


struct CustomToggleStyle : ToggleStyle {

    let width: CGFloat = 50
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                Capsule()
                    .frame(width: width, height: width / 2)
                    .foregroundColor(configuration.isOn ? .white.opacity(0.5) : .black)

                Capsule()
                    .frame(width: (width / 2) - 4, height: width / 2 - 6)
                    .padding(4)
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    }
            }
        }
    }
}

struct NoHighlightButtonStyle : ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
