import UIKit

public class LoadingOverlay {

    var overlayView : UIView!
    var activityIndicator : UIImageView!

    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    init() {
        self.overlayView = UIView()
        self.activityIndicator = UIImageView.init(image: .init(named: "default_image")) //UIActivityIndicatorView()
        self.activityIndicator.backgroundColor = .clear
        self.activityIndicator.contentMode = .scaleAspectFit
        overlayView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.05)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 160, height: 160)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        overlayView.addSubview(activityIndicator)
    }

    public func showOverlay(view: UIView) {
        DispatchQueue.main.async {
            self.overlayView.center = view.center
            view.addSubview(self.overlayView)
            //self.overlayView.alpha = 0.0
            self.activityIndicator.alpha = 0.0
            UIView.animate(withDuration: 0.18,animations: {
                self.activityIndicator.alpha = 1.0
                //self.overlayView.alpha = 1.0
            })
            //activityIndicator.startAnimating()
        }

    }

    public func hideOverlayView() {
        //activityIndicator.stopAnimating()
        
        self.activityIndicator.alpha = 1.0
    
        UIView.animate(withDuration: 0.2,animations: {
            self.activityIndicator.alpha = 0
            //self.overlayView.alpha = 0
            
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            self.overlayView.removeFromSuperview()
        })
        
    }
}

extension UIViewController {
    func showLoading(){
        LoadingOverlay.shared.showOverlay(view: self.getTopMostViewController()!.view)
    }
    func hideLoading(){
        LoadingOverlay.shared.hideOverlayView()
    }
}

