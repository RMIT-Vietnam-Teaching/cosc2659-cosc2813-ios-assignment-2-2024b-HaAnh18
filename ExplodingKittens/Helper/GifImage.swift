//
//  GifImage.swift
//  ExplodingKittens
//
//  Created by Nana on 19/8/24.
//
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2024B
  Assessment: Assignment 2
  Author: Nguyen Tran Ha Anh
  ID: s3938490
  Created  date: 06/08/2024
  Last modified: 03/09/2024
  Acknowledgement:
*/

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false // Disable scrolling
        webView.scrollView.bounces = false
        loadGif(webView: webView)
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    private func loadGif(webView: WKWebView) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "gif") else {
            print("GIF file not found: \(name)")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        } catch {
            print("Failed to load GIF data: \(error)")
        }
    }
}
