//
//  WelcomeView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-07.
//  101401017

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                
                Image("pointseven")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    
                    VStack(spacing: 6) {
                        
                        Text("LIFESTYLE & CAFE")
                            .font(.caption)
                            .foregroundColor(.white)
                            .opacity(0.85)
                        
                        Text("POINT SEVEN")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        
                        HStack {
                            Text("EST")
                                .foregroundColor(.white.opacity(0.8))
                            Text("2020")
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .font(.headline)
                    }
                    .padding(.bottom, 30)
                    
                    Spacer()
                    
                    
                    HStack(spacing: 20) {
                        
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 12)
                                .background(Color.black.opacity(0.5))
                                .clipShape(Capsule())
                        }
                        
                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 12)
                                .background(Color.black.opacity(0.5))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        
    }
}

#Preview {
    WelcomeView()
}
