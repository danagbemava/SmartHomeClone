//
//  HomeView.swift
//  SmartHomeClone
//
//  Created by Daniel Agbemava on 21/07/2022.
//

import SwiftUI


struct HomeView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill( LinearGradient(
                    colors: [.mint.opacity(0.4), .pink.opacity(0.4), .white],
                    startPoint: .leading,
                    endPoint: .bottomTrailing
                ))
                .ignoresSafeArea()

            VStack(alignment: .center) {

                HStack {
                    Text("Hi, Dean")
                        .fontWeight(.bold)
                        .font(.title)

                    Spacer()

                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                }

                VStack(alignment: .leading) {
                    HStack {
                        Text("A total of 4 devices")
                            .fontWeight(.regular)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Button(action: {

                        }, label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                        })
                    }

                    Spacer()
                        .frame(height: 16)

                    Text("Living Room")
                        .fontWeight(.bold)
                        .font(.title3)

                    Spacer()
                        .frame(height: 16)

                    Grid (horizontalSpacing: 20, verticalSpacing: 20) {
                        GridRow {
                            GadgetView(
                                gadgetObserver: GadgetObservable(
                                    name: "Smart\nSpotlight",
                                    onIconName: "light.max",
                                    offIconName: "light.min",
                                    backgroundColor: .red
                                ),
                                destinationView: {
                                    Text("Some destination")
                                }
                            )

                            GadgetView(
                                gadgetObserver: GadgetObservable(
                                    name: "Smart\nAC",
                                    onIconName: "light.max",
                                    offIconName: "light.min",
                                    backgroundColor: .indigo
                                ),
                                destinationView: {
                                    GadgetDetailView(
                                        gadgetObserver:GadgetObservable(
                                            name: "Smart\nAC",
                                            onIconName: "light.max",
                                            offIconName: "light.min",
                                            backgroundColor: .indigo
                                        )
                                    )
                                }
                            )
                        }

                        GridRow {
                            GadgetView(
                                gadgetObserver: GadgetObservable(
                                    name: "Smart\nTV",
                                    onIconName: "tv.fill",
                                    offIconName: "tv",
                                    backgroundColor: .pink
                                ),
                                destinationView: {
                                    Text("Some destination")
                                }
                            )

                            GadgetView(
                                gadgetObserver: GadgetObservable(
                                    name: "Smart\nSound",
                                    onIconName: "speaker.fill",
                                    offIconName: "speaker.slash.fill",
                                    backgroundColor: .red
                                ),
                                destinationView: {
                                    Text("Some destination")
                                }
                            )
                        }
                    }
                }
                .padding(16)
                .padding(8)
                .background(.white)
                .cornerRadius(16, antialiased: true)
            }
            .padding(16)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
