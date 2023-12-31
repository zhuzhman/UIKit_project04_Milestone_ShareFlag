//
//  FlagShareViewController.swift
//  UIKit_project04_Milestone_ShareFlag
//
//  Created by Mikhail Zhuzhman on 30.08.2023.
//

import UIKit
import AVFoundation

class FlagShareViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var shareButton: UIButton!
    
    var selectedFlag: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedFlag?.uppercased() ?? ""
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Do any additional setup after loading the view.
        if let flagToLoad = selectedFlag {
            if let image = UIImage(named: flagToLoad) {
                imageView.image = image
                let roundedImage = image.imageWithRounded(corners: [.allCorners], radius: 2.0)
                imageView.image = roundedImage
                imageView.layer.backgroundColor = CGColor(gray: CGFloat(0.0), alpha: 0.03)
                
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: [UIImage(named: selectedFlag!) ?? "No Image"], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UIImage {

    public func imageWithRounded(corners theCorners: UIRectCorner, radius: CGFloat) -> UIImage {
        let cornerRadius = CGSize(width: radius, height: radius)
        let rect = CGRect(origin: .zero, size: size)
        let renderer = UIGraphicsImageRenderer(size: size)
        let img = renderer.image { ctx in
            let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: theCorners, cornerRadii: cornerRadius)
            bezierPath.addClip()
            draw(in: rect)
        }
        return img
    }

}
