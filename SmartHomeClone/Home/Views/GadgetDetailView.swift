//
//  GadgetDetailView.swift
//  SmartHomeClone
//
//  Created by Daniel Agbemava on 22/07/2022.
//

import SwiftUI
import SpriteKit

struct GadgetDetailView: View {

    @ObservedObject var gadgetObserver: GadgetObservable
    @State var temperature: Double = 16
    @State var progressValue: Double = 0
    @State var currentACSpeed : Int?
    @State var backgroundColor : Color = .cyan

    var scene : SKScene {
        let scene = AirParticlesScene()
        scene.multiplier = currentACSpeed
        scene.size = CGSize(width: 300, height: 400)
        scene.scaleMode = .fill
        scene.backgroundColor = .clear
        return scene
    }

    func getScene() -> SKScene {
        let scene = AirParticlesScene()
        scene.multiplier = currentACSpeed
        scene.size = CGSize(width: 300, height: 400)
        scene.scaleMode = .fill
        scene.backgroundColor = .clear
        return scene
    }

    var speedSettings = [1, 2, 3]

    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .ignoresSafeArea()

            if gadgetObserver.isOn {
                withAnimation(.easeInOut) {
                    SpriteView(scene: getScene(), transition: SKTransition.crossFade(withDuration: 2), options: [.allowsTransparency])
                        .ignoresSafeArea()
//                        .frame(maxWidth: .infinity, maxHeight: 400)
//                        .animation(.easeInOut, value: gadgetObserver.isOn)
                }
            }

            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        GadgetControlView(icon: "clock")
                        GadgetControlView(isActive: true, icon: "snowflake")
                        GadgetControlView(icon: "sun.min")
                        GadgetControlView(icon: "drop")
                    }

                    Spacer()
                        .frame(height: 30)

                    ZStack(alignment: .center) {

                        Circle()
                            .trim(from: 0, to: progressValue)
                            .stroke(Color.white, lineWidth: 40)
                            .frame(height: 250)
                            .rotationEffect(.init(degrees: 180))
                            .animation(.easeInOut, value: progressValue)

                        Circle()
                            .stroke(Color.black.opacity(0.1), lineWidth: 40)
                            .frame(height: 250)
                            .rotationEffect(.init(degrees: 180))

                        Circle()
                            .foregroundColor(.white)
                            .frame(height: 200)

                        Text(String(describing: Int(temperature)))
                            .fontWeight(.bold)
                            .font(.system(size: 54))
                            .foregroundColor(.black)
                    }

                    Spacer()
                        .frame(height: 30)


                    HStack {
                        VStack(alignment: .leading) {
                            Text("Speed")
                                .foregroundColor(.white)

                            HStack {

                                ForEach(speedSettings, id: \.self) { speed in

                                    ACSpeedView(selected: currentACSpeed == speed, setting: "\(speed)")
                                        .onTapGesture {
                                            currentACSpeed = speed
                                        }
                                }

                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(.white.opacity(0.4))
                        .cornerRadius(16)


                        VStack(alignment: .leading, spacing: 10) {
                            Text("Power")
                                .foregroundColor(.white)

                            Toggle(isOn: $gadgetObserver.isOn) {
                                HStack {
                                    Text("OFF")
                                        .foregroundColor(gadgetObserver.isOn ? .white.opacity(0.5) : .white)
                                    Text("/")
                                        .foregroundColor(.white)
                                    Text("ON")
                                        .foregroundColor(gadgetObserver.isOn ? .white : .white.opacity(0.5))
                                }
                            }
                            .toggleStyle(FullCustomLabelStyle())
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(.white.opacity(0.4))
                        .cornerRadius(16)

                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Temp")
                            .foregroundColor(.white)


                        Slider(value: $temperature, in: 16...30, step: 1, label: {
                            Text("")
                        }, minimumValueLabel: {
                            Text("16")
                                .foregroundColor(.white)
                        }, maximumValueLabel: {
                            Text("30")
                                .foregroundColor(.white)
                        })
                        .accentColor(.white)
                        .onChange(of: temperature) { _ in
                            convertToProgressValue()

                            withAnimation(.easeInOut) {
                                backgroundColor = getBackgroundColor()
                            }
                        }

                    }
                    .padding()
                    .background(.white.opacity(0.4))
                    .cornerRadius(16)

                }
                .padding()
                .foregroundColor(.blue)
                .ignoresSafeArea()


            }
//            .background(gadgetObserver.isOn ? .black.opacity(0.25) : .clear)
            .animation(.easeInOut(duration: 0.6), value: gadgetObserver.isOn)

        }
        .navigationTitle(gadgetObserver.name)
    }

    func getBackgroundColor() -> Color {
        var backgroundColor: Color
        

        switch temperature {
            case 16..<20:
                backgroundColor = .cyan
            case 20..<25:
                backgroundColor = .blue
            case 25..<30:
                backgroundColor = .purple
            default:
                backgroundColor = .red
        }

        return backgroundColor
    }

    func convertToProgressValue() {
        var tempProgress = temperature

        if temperature == 16 {
            progressValue = 0
            return
        }

        tempProgress = (0.5 / 15) * (temperature - 15)

        print("tempProgress: \(tempProgress)")

        if tempProgress > 0.5 {
            tempProgress = 0.5
        }


        progressValue = tempProgress
    }
}

struct GadgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GadgetDetailView(
            gadgetObserver: GadgetObservable(
                name: "Smart Spotlight",
                onIconName: "light.max",
                offIconName: "light.min",
                backgroundColor: Color.red
            )
        )
    }
}

struct FullCustomLabelStyle : ToggleStyle {

    let width: CGFloat = 50

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {

            configuration.label

            Spacer()

            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                Capsule()
                    .frame(width: width, height: width / 2)
                    .foregroundColor(configuration.isOn ? .white.opacity(0.5) : .black.opacity(0.5))

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

struct ACSpeedView: View {

    var selected: Bool = false
    var setting: String

    var body: some View {

        if selected {
            Text(setting)
                .foregroundColor(.black)
                .padding()
                .background()
                .containerShape(Circle())
        } else  {
            Text(setting)
                .foregroundColor(.white)
                .padding()
                .background(Circle().stroke(lineWidth: 1))
                .foregroundColor(.black)
        }
    }
}


class AirParticlesScene : SKScene {

    let particlesNode = SKEmitterNode(fileNamed: "ACWind.sks")

    var multiplier: Int?

    override func didMove(to view: SKView) {
        guard let particlesNode = particlesNode else { return }


        particlesNode.position = CGPoint(x: size.width/2 , y: size.height/2)
        //        particlesNode.particlePositionRange = CGVector(dx: 600, dy: 600)
        //        particlesNode.particleSize = CGSize(width:30, height: 30)
        particlesNode.particleLifetime = 2
        particlesNode.particleBirthRate = 300
        particlesNode.speed = multiplier == nil ? 100.0 : CGFloat(multiplier!) * 200
        particlesNode.yAcceleration = multiplier == nil ? 10 : CGFloat(multiplier!) * 10 * 2
        particlesNode.particleScale = 1
        particlesNode.particleScaleRange = 1

        print("speed: \(particlesNode.speed)")
        print("vertical acceleration: \(particlesNode.yAcceleration)")


//        particlesNode.particlePositionRange = CGVector(dx: 0, dy: 5)


        addChild(particlesNode)
    }

}
