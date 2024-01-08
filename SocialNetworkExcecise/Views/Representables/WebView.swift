//
//  WebView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import SwiftUI
import WebKit


struct WebView : UIViewRepresentable {
    let request: URLRequest
    var webview: WKWebView

    init(web: WKWebView? = WKWebView(), req: URLRequest) {
        self.webview = web ?? WKWebView()
        self.request = req
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("debug:: \(webView.url?.absoluteString)")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
        uiView.load(request)
    }

    func goBack(){
        webview.goBack()
    }

    func goForward(){
        webview.goForward()
    }

    func reload(){
        webview.reload()
    }
}

#Preview {
    WebView(req: URLRequest(url: URL(string: "https://www.google.com")!))
}
