import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mctcHomePage = URL(string:"https://www.minneapolis.edu")
        let myRequest = URLRequest(url: mctcHomePage!)
    //webView.load(URLRequest(url: mctcHomePage!))
        //webView.load(myRequest)
    }
}
