//
//  PDFViewController.swift
//  ProjektManager
//
//  Created by Jacqueline Schmitz on 19.01.23.
//

import Foundation
import PDFKit

class PDFViewController: UIViewController {
    
    
    @IBOutlet weak var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let url = Bundle.main.url(forResource: "document", withExtension: "pdf") else {return}
//        guard let document = PDFDocument(url: url) else {return}
        
        let document = PDFDocument()
        guard let imageOne = UIImage(named: "BadBildKitzbühel") else {return}
        guard let imageTwo = UIImage(named: "BadBildKöln") else {return}
        guard let pageOne = PDFPage(image: imageOne)  else {return}
        guard let pageTwo = PDFPage(image: imageTwo)  else {return}
        document.insert(pageOne, at: 0)
        document.insert(pageTwo, at: 1)
        pdfView.document = document
        pdfView.autoScales = true
    }
}
