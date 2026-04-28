//
//  PDFGenerationService.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import UIKit
import PDFKit

class PDFGenerationService {
    static let shared = PDFGenerationService()
    
    private init() {}
    
    func generateReadingPDF(
        drawnCards: [DrawnCard],
        category: IntentionCategory,
        customQuestion: String?,
        spreadType: SpreadType,
        notes: String?,
        date: Date
    ) -> URL? {
        let pdfMetaData = [
            kCGPDFContextCreator: "TarotGo",
            kCGPDFContextAuthor: "TarotGo App",
            kCGPDFContextTitle: "Tarot Reading - \(category.displayName)"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // A4 size
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11.0 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            var yPosition: CGFloat = 60
            let margin: CGFloat = 60
            let contentWidth = pageWidth - (2 * margin)
            
            // Title
            yPosition = drawText(
                L10n.pdfTitle,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 28, weight: .bold),
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0) // Gold color
            )
            
            yPosition += 20
            
            // Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            yPosition = drawText(
                dateFormatter.string(from: date),
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 12, weight: .light),
                color: .darkGray
            )
            
            yPosition += 30
            
            // Question if exists
            if let question = customQuestion {
                yPosition = drawText(
                    L10n.pdfQuestion,
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: .systemFont(ofSize: 14, weight: .semibold),
                    color: .black
                )
                yPosition += 5
                yPosition = drawText(
                    "\"\(question)\"",
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: .italicSystemFont(ofSize: 13),
                    color: .darkGray
                )
                yPosition += 25
            }
            
            // Category and Spread
            yPosition = drawText(
                "\(L10n.pdfCategory) \(category.displayName)",
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .regular),
                color: .black
            )
            yPosition += 5
            yPosition = drawText(
                "\(L10n.pdfSpread) \(spreadType.displayName)",
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .regular),
                color: .black
            )
            
            yPosition += 30
            
            // Divider
            let dividerPath = UIBezierPath()
            dividerPath.move(to: CGPoint(x: margin, y: yPosition))
            dividerPath.addLine(to: CGPoint(x: pageWidth - margin, y: yPosition))
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.5).setStroke()
            dividerPath.lineWidth = 1
            dividerPath.stroke()
            
            yPosition += 30
            
            // Overall Summary
            yPosition = drawText(
                L10n.pdfOverallInsight,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 18, weight: .semibold),
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )
            yPosition += 10
            let summary = TarotInterpretations.spreadSummary(for: drawnCards, category: category, spreadType: spreadType)
            yPosition = drawText(
                summary,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 12, weight: .light),
                color: .black
            )
            
            yPosition += 30
            
            // Cards section
            yPosition = drawText(
                L10n.pdfCards,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 18, weight: .semibold),
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )
            yPosition += 20
            
            // Draw each card
            for (index, drawnCard) in drawnCards.enumerated() {
                // Check if we need a new page
                if yPosition > pageHeight - 200 {
                    context.beginPage()
                    yPosition = 60
                }
                
                // Card position and name
                let cardTitle = "\(index + 1). \(drawnCard.position.name): \(drawnCard.card.localizedName)"
                yPosition = drawText(
                    cardTitle,
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: .systemFont(ofSize: 14, weight: .semibold),
                    color: .black
                )
                
                if drawnCard.isReversed {
                    yPosition += 2
                    yPosition = drawText(
                        L10n.interpretationReversed,
                        at: CGPoint(x: margin, y: yPosition),
                        width: contentWidth,
                        font: .systemFont(ofSize: 11, weight: .light),
                        color: .darkGray
                    )
                }
                
                yPosition += 10
                
                // Card image (if available)
                if let cardImage = UIImage(named: drawnCard.card.id) {
                    let cardImageHeight: CGFloat = 120
                    let cardImageWidth: CGFloat = cardImageHeight * (1108.0 / 1900.0)
                    var imageRect = CGRect(x: margin, y: yPosition, width: cardImageWidth, height: cardImageHeight)
                    
                    // Rotate context if reversed
                    if drawnCard.isReversed {
                        context.cgContext.saveGState()
                        context.cgContext.translateBy(x: imageRect.midX, y: imageRect.midY)
                        context.cgContext.rotate(by: .pi)
                        imageRect = CGRect(x: -cardImageWidth/2, y: -cardImageHeight/2, width: cardImageWidth, height: cardImageHeight)
                        cardImage.draw(in: imageRect)
                        context.cgContext.restoreGState()
                    } else {
                        cardImage.draw(in: imageRect)
                    }
                    
                    // Draw interpretation next to the image
                    let interpretationX = margin + cardImageWidth + 15
                    let interpretationWidth = contentWidth - cardImageWidth - 15
                    let interpretation = drawnCard.card.interpretation(for: drawnCard.category, reversed: drawnCard.isReversed)
                    
                    _ = drawText(
                        interpretation,
                        at: CGPoint(x: interpretationX, y: yPosition),
                        width: interpretationWidth,
                        font: .systemFont(ofSize: 11, weight: .light),
                        color: .darkGray
                    )
                    
                    yPosition += cardImageHeight + 20
                } else {
                    // No image, just interpretation
                    let interpretation = drawnCard.card.interpretation(for: drawnCard.category, reversed: drawnCard.isReversed)
                    yPosition = drawText(
                        interpretation,
                        at: CGPoint(x: margin, y: yPosition),
                        width: contentWidth,
                        font: .systemFont(ofSize: 11, weight: .light),
                        color: .darkGray
                    )
                    yPosition += 20
                }
            }
            
            // Notes section
            if let notes = notes, !notes.isEmpty {
                // Check if we need a new page
                if yPosition > pageHeight - 150 {
                    context.beginPage()
                    yPosition = 60
                }
                
                yPosition += 10
                yPosition = drawText(
                    L10n.pdfPersonalReflections,
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: .systemFont(ofSize: 18, weight: .semibold),
                    color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
                )
                yPosition += 15
                yPosition = drawText(
                    notes,
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: .systemFont(ofSize: 12, weight: .light),
                    color: .black
                )
            }
        }
        
        // Save to temporary file
        let tempURL = FileManager.default.temporaryDirectory
            .appendingPathComponent("TarotReading_\(UUID().uuidString).pdf")
        
        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            print("Failed to save PDF: \(error)")
            return nil
        }
    }
    
    @discardableResult
    private func drawText(
        _ text: String,
        at point: CGPoint,
        width: CGFloat,
        font: UIFont,
        color: UIColor
    ) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        let textRect = CGRect(x: point.x, y: point.y, width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = attributedString.boundingRect(with: textRect.size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        attributedString.draw(in: textRect)
        
        return point.y + boundingRect.height
    }
}
