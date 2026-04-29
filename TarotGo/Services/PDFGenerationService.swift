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
    
    // MARK: - Decorative Elements
    
    private func drawMysticalBackground(in rect: CGRect, context: CGContext) {
        // Subtle gradient background
        let colors = [
            UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 1.0).cgColor, // Cream
            UIColor(red: 0.95, green: 0.93, blue: 0.88, alpha: 1.0).cgColor  // Slightly darker cream
        ]
        
        if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                     colors: colors as CFArray,
                                     locations: [0.0, 1.0]) {
            context.drawLinearGradient(gradient,
                                      start: CGPoint(x: 0, y: 0),
                                      end: CGPoint(x: 0, y: rect.height),
                                      options: [])
        }
        
        // Add subtle mystical pattern (stars and dots)
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.03).setFill()
        
        for i in 0..<20 {
            let x = CGFloat.random(in: 0...rect.width)
            let y = CGFloat.random(in: 0...rect.height)
            let size = CGFloat.random(in: 3...8)
            
            // Draw small stars
            drawStar(at: CGPoint(x: x, y: y), size: size, context: context)
        }
    }
    
    private func drawStar(at center: CGPoint, size: CGFloat, context: CGContext) {
        context.saveGState()
        
        let path = UIBezierPath()
        let points = 5
        let outerRadius = size
        let innerRadius = size * 0.4
        
        for i in 0..<points * 2 {
            let angle = CGFloat(i) * .pi / CGFloat(points) - .pi / 2
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.close()
        path.fill()
        
        context.restoreGState()
    }
    
    private func drawDecorativeBorder(at y: CGFloat, width: CGFloat, margin: CGFloat, context: CGContext) {
        context.saveGState()
        
        // Draw ornamental line with center decoration
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.6).setStroke()
        
        // Left line
        let leftLine = UIBezierPath()
        leftLine.move(to: CGPoint(x: margin, y: y))
        leftLine.addLine(to: CGPoint(x: width / 2 - 40, y: y))
        leftLine.lineWidth = 1.5
        leftLine.stroke()
        
        // Right line
        let rightLine = UIBezierPath()
        rightLine.move(to: CGPoint(x: width / 2 + 40, y: y))
        rightLine.addLine(to: CGPoint(x: width - margin, y: y))
        rightLine.lineWidth = 1.5
        rightLine.stroke()
        
        // Center ornament (small star)
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.8).setFill()
        drawStar(at: CGPoint(x: width / 2, y: y), size: 8, context: context)
        
        // Small moons on sides
        drawCrescent(at: CGPoint(x: width / 2 - 25, y: y), size: 6, context: context)
        drawCrescent(at: CGPoint(x: width / 2 + 25, y: y), size: 6, context: context, flipped: true)
        
        context.restoreGState()
    }
    
    private func drawCrescent(at center: CGPoint, size: CGFloat, context: CGContext, flipped: Bool = false) {
        context.saveGState()
        
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.8).setFill()
        
        let outerCircle = UIBezierPath(arcCenter: center,
                                       radius: size,
                                       startAngle: 0,
                                       endAngle: .pi * 2,
                                       clockwise: true)
        
        let innerCenter = CGPoint(x: center.x + (flipped ? size * 0.4 : -size * 0.4), y: center.y)
        let innerCircle = UIBezierPath(arcCenter: innerCenter,
                                       radius: size,
                                       startAngle: 0,
                                       endAngle: .pi * 2,
                                       clockwise: true)
        
        outerCircle.append(innerCircle.reversing())
        outerCircle.fill()
        
        context.restoreGState()
    }
    
    private func drawCardPositionBadge(position: Int, at point: CGPoint, context: CGContext) {
        context.saveGState()
        
        // Draw circular badge with mystical styling
        let badgeRadius: CGFloat = 18
        let badgeCenter = CGPoint(x: point.x + badgeRadius, y: point.y + badgeRadius)
        
        // Outer circle with gradient effect
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.9).setFill()
        let outerCircle = UIBezierPath(arcCenter: badgeCenter,
                                       radius: badgeRadius,
                                       startAngle: 0,
                                       endAngle: .pi * 2,
                                       clockwise: true)
        outerCircle.fill()
        
        // Inner circle
        UIColor(red: 0.95, green: 0.93, blue: 0.88, alpha: 1.0).setFill()
        let innerCircle = UIBezierPath(arcCenter: badgeCenter,
                                       radius: badgeRadius - 3,
                                       startAngle: 0,
                                       endAngle: .pi * 2,
                                       clockwise: true)
        innerCircle.fill()
        
        // Position number
        let numberText = "\(position)"
        let font = UIFont.systemFont(ofSize: 14, weight: .bold)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        ]
        
        let textSize = numberText.size(withAttributes: attributes)
        let textPoint = CGPoint(
            x: badgeCenter.x - textSize.width / 2,
            y: badgeCenter.y - textSize.height / 2
        )
        
        numberText.draw(at: textPoint, withAttributes: attributes)
        
        context.restoreGState()
    }
    
    private func drawFooter(at y: CGFloat, width: CGFloat, margin: CGFloat, pageNumber: Int, context: CGContext) {
        context.saveGState()
        
        // Draw decorative footer line
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.3).setStroke()
        let footerLine = UIBezierPath()
        footerLine.move(to: CGPoint(x: margin, y: y))
        footerLine.addLine(to: CGPoint(x: width - margin, y: y))
        footerLine.lineWidth = 0.5
        footerLine.stroke()
        
        // Small stars decoration
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.4).setFill()
        drawStar(at: CGPoint(x: width / 2 - 15, y: y + 15), size: 4, context: context)
        drawStar(at: CGPoint(x: width / 2 + 15, y: y + 15), size: 4, context: context)
        
        // Page number with mystical font
        let pageText = "\(pageNumber)"
        let font = UIFont.systemFont(ofSize: 10, weight: .light)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.6)
        ]
        
        let textSize = pageText.size(withAttributes: attributes)
        let textPoint = CGPoint(
            x: width / 2 - textSize.width / 2,
            y: y + 10
        )
        
        pageText.draw(at: textPoint, withAttributes: attributes)
        
        context.restoreGState()
    }
    
    private func drawSectionHeader(title: String, at y: CGFloat, margin: CGFloat, contentWidth: CGFloat, context: CGContext) -> CGFloat {
        context.saveGState()
        
        var currentY = y
        
        // Draw decorative elements before title
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.5).setFill()
        drawStar(at: CGPoint(x: margin - 15, y: currentY + 10), size: 6, context: context)
        
        // Draw title with enhanced styling
        currentY = drawText(
            title,
            at: CGPoint(x: margin, y: currentY),
            width: contentWidth,
            font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        )
        
        // Draw small decorative line under title
        currentY += 5
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.4).setStroke()
        let underline = UIBezierPath()
        underline.move(to: CGPoint(x: margin, y: currentY))
        underline.addLine(to: CGPoint(x: margin + 80, y: currentY))
        underline.lineWidth = 2
        underline.stroke()
        
        context.restoreGState()
        
        return currentY + 15
    }
    
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
            var pageNumber = 1
            context.beginPage()
            
            drawMysticalBackground(in: pageRect, context: context.cgContext)
            
            var yPosition: CGFloat = 50
            let margin: CGFloat = 60
            let contentWidth = pageWidth - (2 * margin)
            
            // Header
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.2).setFill()
            drawStar(at: CGPoint(x: pageWidth / 2, y: 30), size: 12, context: context.cgContext)
            yPosition += 30
            
            // Title
            yPosition = drawText(
                L10n.summaryYourReading,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 32, weight: .bold),
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )
            
            yPosition += 10
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25
            
            // Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            drawCrescent(at: CGPoint(x: margin + 8, y: yPosition + 8), size: 5, context: context.cgContext)
            
            yPosition = drawText(
                dateFormatter.string(from: date),
                at: CGPoint(x: margin + 25, y: yPosition),
                width: contentWidth - 25,
                font: .systemFont(ofSize: 13, weight: .light),
                color: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
            )
            
            yPosition += 35
            
            if let question = customQuestion {
                yPosition = drawText(
                    "\"\(question)\"",
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: .italicSystemFont(ofSize: 16),
                    color: UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
                )
                yPosition += 20
            }
            
            yPosition = drawText(
                spreadType.displayName,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 18, weight: .medium),
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )
            
            yPosition += 30
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25
            
            // Overall Insight
            yPosition = drawSectionHeader(
                title: L10n.summaryOverallInsight,
                at: yPosition,
                margin: margin,
                contentWidth: contentWidth,
                context: context.cgContext
            )
            
            yPosition += 5
            let summary = TarotInterpretations.spreadSummary(for: drawnCards, category: category, spreadType: spreadType)
            
            let boxTopPadding: CGFloat = 12
            let boxBottomPadding: CGFloat = 18
            let summaryStartY = yPosition
            yPosition += boxTopPadding

            yPosition = drawText(
                summary,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .light),
                color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            )

            yPosition += boxBottomPadding
            context.cgContext.saveGState()
            let actualBoxHeight = yPosition - summaryStartY
            let summaryBox = UIBezierPath(roundedRect: CGRect(x: margin - 10, y: summaryStartY, width: contentWidth + 20, height: actualBoxHeight), cornerRadius: 10)
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.25).setStroke()
            summaryBox.lineWidth = 1
            summaryBox.stroke()
            context.cgContext.restoreGState()

            yPosition += 55 // Space before card section
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 20
            
            // Draw Cards
            for (index, drawnCard) in drawnCards.enumerated() {
                if yPosition > pageHeight - 250 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }
                
                // 1. CAPTURE the starting Y position for this card section
                let cardSectionTopY = yPosition + 40
                
                yPosition += 40
                drawCardPositionBadge(position: index + 1, at: CGPoint(x: margin, y: yPosition), context: context.cgContext)
                
                let positionText = "\(index + 1). \(drawnCard.position.name)"
                yPosition = drawText(
                    positionText,
                    at: CGPoint(x: margin + 45, y: yPosition + 5),
                    width: contentWidth - 45,
                    font: .systemFont(ofSize: 18, weight: .medium),
                    color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
                )
                
                yPosition += 8
                var cardNameText = drawnCard.card.localizedName
                if drawnCard.isReversed {
                    let reversedText = NSLocalizedString("(Reversed)", comment: "A label indicating that the card is reversed.")
                    cardNameText += " \(reversedText)"
                }
                
                yPosition = drawText(
                    cardNameText,
                    at: CGPoint(x: margin + 45, y: yPosition),
                    width: contentWidth - 45,
                    font: .systemFont(ofSize: 16, weight: .semibold),
                    color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
                )
                
                yPosition += 25
                
                // 2. DRAW IMAGE using the relative cardSectionTopY
                if let cardImage = UIImage(named: drawnCard.card.id) {
                    let cardImageHeight: CGFloat = 140
                    let cardImageWidth: CGFloat = cardImageHeight * (1108.0 / 1900.0)
                    let cardX = pageWidth - margin - cardImageWidth
                    
                    // We use cardSectionTopY so the image starts aligned with the badge/title
                    var imageRect = CGRect(x: cardX, y: cardSectionTopY + 10, width: cardImageWidth, height: cardImageHeight)
                    
                    context.cgContext.saveGState()
                    context.cgContext.setShadow(offset: CGSize(width: 0, height: 4), blur: 10, color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.35).cgColor)
                    let cardBg = UIBezierPath(roundedRect: imageRect, cornerRadius: cardImageWidth * 0.06)
                    UIColor.white.setFill()
                    cardBg.fill()
                    context.cgContext.restoreGState()
                    
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
                }
                
                let interpretation = drawnCard.card.interpretation(for: drawnCard.category, reversed: drawnCard.isReversed)
                let interpWidth = contentWidth - 100
                
                // Calculate height
                let interpFont = UIFont.systemFont(ofSize: 13, weight: .light)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 3 // Added slight line spacing for readability
                let interpAttributes: [NSAttributedString.Key: Any] = [
                    .font: interpFont,
                    .paragraphStyle: paragraphStyle
                ]
                let interpString = NSAttributedString(string: interpretation, attributes: interpAttributes)
                let interpRect = interpString.boundingRect(with: CGSize(width: interpWidth, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
                
                let boxTopInset: CGFloat = 15
                let boxBottomInset: CGFloat = 20
                let interpBoxStartY = yPosition
                
                // Draw Box
                context.cgContext.saveGState()
                let boxRect = CGRect(
                    x: margin - 8,
                    y: interpBoxStartY - boxTopInset,
                    width: interpWidth + 16,
                    height: interpRect.height + boxTopInset + boxBottomInset
                )
                UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.8).setFill()
                let interpBox = UIBezierPath(roundedRect: boxRect, cornerRadius: 8)
                interpBox.fill()
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.2).setStroke()
                interpBox.lineWidth = 1
                interpBox.stroke()
                context.cgContext.restoreGState()
                
                // Draw interpretation text inside box area
                interpString.draw(in: CGRect(x: margin, y: yPosition, width: interpWidth, height: interpRect.height))
                
                // Increment yPosition based on box height plus separator space
                yPosition += interpRect.height + boxBottomInset + 45
                
                if index < drawnCards.count - 1 {
                    let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
                        
                        // Set stroke for the lines (using a lower alpha for the lines to keep them subtle)
                        goldColor.withAlphaComponent(0.3).setStroke()
                    
                    let leftLine = UIBezierPath()
                    leftLine.move(to: CGPoint(x: margin, y: yPosition))
                    leftLine.addLine(to: CGPoint(x: pageWidth / 2 - 20, y: yPosition))
                    leftLine.lineWidth = 0.5
                    leftLine.stroke()
                    
                    let rightLine = UIBezierPath()
                    rightLine.move(to: CGPoint(x: pageWidth / 2 + 20, y: yPosition))
                    rightLine.addLine(to: CGPoint(x: pageWidth - margin, y: yPosition))
                    rightLine.lineWidth = 0.5
                    rightLine.stroke()
                    
                    goldColor.setFill()
                    drawStar(at: CGPoint(x: pageWidth / 2, y: yPosition), size: 5, context: context.cgContext)
                    yPosition += 20
                }
            }
            
            // Notes
            if let notes = notes, !notes.isEmpty {
                if yPosition > pageHeight - 200 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }
                
                yPosition += 15
                yPosition = drawSectionHeader(title: L10n.summaryReflections, at: yPosition, margin: margin, contentWidth: contentWidth, context: context.cgContext)
                yPosition += 5
                
                let notesFont = UIFont.systemFont(ofSize: 12, weight: .regular)
                let notesAttributes: [NSAttributedString.Key: Any] = [.font: notesFont]
                let notesString = NSAttributedString(string: notes, attributes: notesAttributes)
                let notesRect = notesString.boundingRect(with: CGSize(width: contentWidth - 20, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
                
                context.cgContext.saveGState()
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.05).setFill()
                let notesBox = UIBezierPath(roundedRect: CGRect(x: margin - 10, y: yPosition - 10, width: contentWidth + 20, height: notesRect.height + 30), cornerRadius: 8)
                notesBox.fill()
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.3).setStroke()
                notesBox.lineWidth = 1
                notesBox.stroke()
                drawStar(at: CGPoint(x: margin - 5, y: yPosition - 5), size: 4, context: context.cgContext)
                drawStar(at: CGPoint(x: pageWidth - margin + 5, y: yPosition - 5), size: 4, context: context.cgContext)
                context.cgContext.restoreGState()
                
                yPosition = drawText(notes, at: CGPoint(x: margin, y: yPosition), width: contentWidth, font: notesFont, color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0))
            }
            
            drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let filename = "TarotReading_\(dateFormatter.string(from: date))_\(category.displayName.replacingOccurrences(of: " ", with: "")).pdf"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
        
        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
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
        // ADDITION: Polish diacritics need more vertical breathing room
        paragraphStyle.lineSpacing = 3
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        
        // Use a constraint size for calculation
        let constraintSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingRect = attributedString.boundingRect(
            with: constraintSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        
        // FIX: Shift y by +2 or +3 to prevent the top of Polish characters
        // (like the 'kreska' in 'ś' or 'ć') from being clipped at the top of the rect.
        let textRect = CGRect(
            x: point.x,
            y: point.y + 2,
            width: width, 
            height: boundingRect.height + 10 // Extra height safety
        )
        
        attributedString.draw(in: textRect)
        
        // Return the position for the next element, accounting for the shift
        return point.y + boundingRect.height + 2
    }
}
