//
//  ViewController.swift
//  UIKit_project04_Challenge_ShareFlag
//
//  Created by Mikhail Zhuzhman on 28.08.2023.
//

import UIKit

class ViewController: UITableViewController {
    var flags = [String]()
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Share Flag"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        for item in items {
            if item.hasSuffix("@3x.png") {
                flags.append(String(item.dropLast(7)))
            }
        }
        flags = flags.sorted()
        print(flags)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        let name = flags.sorted()[indexPath.row]
        cell.textLabel?.text = name.uppercased()
        cell.imageView?.image = UIImage(named: name)?.with(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        cell.imageView?.layer.borderWidth = 0.2
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageView?.layer.cornerRadius = 4
        cell.imageView?.layer.masksToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? FlagShareViewController {
            vc.selectedFlag = flags[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension UIImage {
    
    func with(_ insets: UIEdgeInsets) -> UIImage {
        let targetWidth = size.width + insets.left + insets.right
        let targetHeight = size.height + insets.top + insets.bottom
        let targetSize = CGSize(width: targetWidth, height: targetHeight)
        let targetOrigin = CGPoint(x: insets.left, y: insets.top)
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        return renderer.image { _ in
            draw(in: CGRect(origin: targetOrigin, size: size))
        }.withRenderingMode(renderingMode)
    }
    
}
