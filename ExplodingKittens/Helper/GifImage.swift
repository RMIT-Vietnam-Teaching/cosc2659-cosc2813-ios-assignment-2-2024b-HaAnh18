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

// A SwiftUI view that wraps a WKWebView to display a GIF.
struct GifImage: UIViewRepresentable {
    // The name of the GIF file (without the .gif extension).
    private var name: String
    
    // Initializer to set the GIF file name.
    init(name: String) {
        self.name = name
    }
    
    // Create the WKWebView instance and configure it.
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        
        // Disable scrolling and bouncing to keep the GIF static.
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        
        // Set the background of the webView to be transparent
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        
        // Load the GIF into the webView.
        loadGif(webView: webView)
        return webView
    }
    
    // Update the UIView, not needed for this static GIF display.
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Not needed for this simple implementation
    }
    
    // Helper function to load the GIF from the app bundle into the webView.
    private func loadGif(webView: WKWebView) {
        // Locate the GIF file in the app bundle.
        guard let url = Bundle.main.url(forResource: name, withExtension: "gif") else {
            print("GIF file not found: \(name)")
            return
        }
        
        // Try to load the GIF data and display it in the webView.
        do {
            let data = try Data(contentsOf: url)
            webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        } catch {
            print("Failed to load GIF data: \(error)")
        }
    }
}
