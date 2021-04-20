//
//  ContentView.swift
//  Precision Finding
//
//  Created by Jordan Singer on 4/20/21.
//

import SwiftUI

enum Mode {
    case ahead, right
}

struct ContentView: View {
    @State var mode = Mode.ahead
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    Circle()
                        .fill(Color(mode == .ahead ? UIColor.label : UIColor.secondaryLabel))
                        .frame(width: 16, height: 16)
                        .offset(y: mode == .ahead ? -4 : -8)
                        .scaleEffect(mode == .ahead ? 2 : 1)
                    
                    Spacer()
                }
                
                Circle()
                    .trim(from: 0.025, to: mode == .ahead ? 0.0 : 0.225)
                    .rotation(Angle(degrees: -90))
                    .stroke(Color(UIColor.label), style: StrokeStyle(lineWidth: 16, lineCap: .round))
                    .opacity(mode == .ahead ? 0 : 1)
            }
            .frame(width: 312, height: 312)
            
            ZStack {
                
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 16, height: 16)
                        .offset(x: 8)
                        .opacity(mode == .ahead ? 0 : 1)
                }
            }
            .frame(width: 312, height: 312)
            .rotationEffect(Angle(degrees: mode == .ahead ? -90 : 0))
            
            Image(systemName: "arrow.up")
                .font(.system(size: 192, weight: .bold))
                .rotationEffect(Angle(degrees: mode == .ahead ? 0 : 90))
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("FINDING")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        
                        Text("Alan's Keys")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("20")
                        Text("ft")
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        
                        Spacer()
                    }
                    
                    HStack {
                        if mode == .right {
                            Text("to your")
                            Text("right")
                                .foregroundColor(Color(UIColor.secondaryLabel))
                        } else {
                            Text("ahead")
                        }
                        
                        Spacer()
                    }
                }
                .font(.system(size: 48, design: .rounded))
                .padding(.bottom)
                
                HStack {
                    Button(action: { }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .semibold))
                            .padding(20)
                            .background(
                                Circle()
                                    .fill(Color(UIColor.tertiaryLabel))
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button(action: { }) {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.system(size: 24, weight: .semibold))
                            .padding(20)
                            .background(
                                Circle()
                                    .fill(Color(UIColor.tertiaryLabel))
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .onReceive(timer) { time in
            toggleMode()
        }
        .background((mode == .ahead ? Color.green : Color(UIColor.systemBackground)).edgesIgnoringSafeArea(.all))
    }
    
    func toggleMode() {
        if mode == .ahead {
            withAnimation(.easeInOut(duration: 1)) {
                mode = .right
            }
        } else {
            withAnimation(.easeInOut(duration: 1)) {
                mode = .ahead
            }
        }
    }
}
