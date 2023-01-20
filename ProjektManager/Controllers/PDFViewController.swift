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
    
    let pdf = PDFData(
        title: "Meine erste PDF",
        body: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
        imageName: "BadBildKitzbühel",
        spacing: 100.00
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView.document = PDFDocument(data: createDocumentData())
        pdfView.autoScales = true

    }
 
        
    func createDocumentData() -> Data {
        return pdf.renderer.pdfData { (context) in
            context.beginPage()
            let titleBottom = addTitle()
            let imageButtom = addImage(top: titleBottom + pdf.spacing)
            addBodyText(top: imageButtom + pdf.spacing)
        }
    }

    func addTitle() -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        let titleAttributes = [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: pdf.title, attributes: titleAttributes)
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(x: (pdf.pageRect.width - titleStringSize.width) / 2.0, y: 36, width: titleStringSize.width, height: titleStringSize.height)
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }

    func addBodyText(top: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle,NSAttributedString.Key.font: textFont]
        let attributedText = NSAttributedString(string: pdf.body, attributes: textAttributes)
      let textRect = CGRect(x: 10, y: top, width: pdf.pageRect.width - 20, height: pdf.pageRect.height - top - pdf.pageRect.height / 5.0)
      attributedText.draw(in: textRect)
    }
    
    func addImage(top: CGFloat) -> CGFloat {
        let maxHeight = pdf.pageRect.height * 0.2
        let maxWidth = pdf.pageRect.width * 0.8
        let aspectWidth = maxWidth / pdf.image.size.width
        let aspectHeight = maxHeight / pdf.image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        let scaledWidth = pdf.image.size.width * aspectRatio
        let scaledHeight = pdf.image.size.height * aspectRatio
        let imageX = (pdf.pageRect.width - scaledWidth) / 2.0
        let imageRect = CGRect(x: imageX, y: top, width: scaledWidth, height: scaledHeight)
        pdf.image.draw(in: imageRect)
        return imageRect.origin.y + imageRect.size.height
    }

}
