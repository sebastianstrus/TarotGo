//
//  PDFGenerationService.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import UIKit
import PDFKit
import SwiftUI

class PDFGenerationService {
    static let shared = PDFGenerationService()

    private init() {}

    // MARK: - App Icon

    private static func appIconImage() -> UIImage? {
        if let icons = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
           let lastIcon = iconFiles.last,
           let image = UIImage(named: lastIcon) {
            return image
        }
        return UIImage(named: "app_new_icon")
    }

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

            // App Icon (centered)
            if let appIcon = Self.appIconImage() {
                let iconSize: CGFloat = 60
                let iconX = (pageWidth - iconSize) / 2
                let iconRect = CGRect(x: iconX, y: yPosition, width: iconSize, height: iconSize)
                context.cgContext.saveGState()
                let iconPath = UIBezierPath(roundedRect: iconRect, cornerRadius: iconSize * 0.22)
                iconPath.addClip()
                appIcon.draw(in: iconRect)
                context.cgContext.restoreGState()
                yPosition += iconSize + 15
            }

            // Title (centered)
            let titleFont = UIFont.systemFont(ofSize: 32, weight: .bold)
            let titleSize = L10n.summaryYourTarotGoReading.size(withAttributes: [.font: titleFont])
            let titleX = (pageWidth - titleSize.width) / 2
            yPosition = drawText(
                L10n.summaryYourTarotGoReading,
                at: CGPoint(x: titleX, y: yPosition),
                width: titleSize.width + 1,
                font: titleFont,
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
                
                let positionText = drawnCard.position.name
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
                    let cornerRadius = cardImageWidth * 0.06 // Matches AppTheme.cardCornerRadius formula
                    
                    // We use cardSectionTopY so the image starts aligned with the badge/title
                    var imageRect = CGRect(x: cardX, y: cardSectionTopY + 10, width: cardImageWidth, height: cardImageHeight)
                    
                    context.cgContext.saveGState()
                    
                    // Draw white background
                    let cardBg = UIBezierPath(roundedRect: imageRect, cornerRadius: cornerRadius)
                    UIColor.white.setFill()
                    cardBg.fill()
                    
                    // Clip to rounded rect for the image
                    cardBg.addClip()
                    
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
                    
                    context.cgContext.restoreGState()
                    
                    // Draw 1px white border (after drawing the image)
                    context.cgContext.saveGState()
                    let originalRect = CGRect(x: cardX, y: cardSectionTopY + 10, width: cardImageWidth, height: cardImageHeight)
                    let borderPath = UIBezierPath(roundedRect: originalRect, cornerRadius: cornerRadius)
                    UIColor.gray.setStroke()
                    borderPath.lineWidth = 0.5
                    borderPath.stroke()
                    context.cgContext.restoreGState()
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

            // App Store Promo
            let appStorePromoHeight: CGFloat = 70
            if yPosition > pageHeight - appStorePromoHeight - 60 {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60
            }

            yPosition += 30
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 20

            yPosition = drawText(
                "Download TarotGo on the App Store:",
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .medium),
                color: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
            )
            yPosition += 5
            yPosition = drawText(
                "https://apps.apple.com/app/id6762875158",
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .light),
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )

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
    
    // MARK: - Destiny Matrix PDF

    @MainActor
    private func renderDestinyMatrixDiagramImage(matrix: DestinyMatrix, size: CGFloat) -> UIImage? {
        let view = DestinyMatrixDiagramView(
            matrix: matrix,
            selectedPosition: .constant(nil),
            selectedYear: .constant(nil),
            pdfMode: true
        )
        .frame(width: size, height: size)
        .padding(size * 0.06)
        .background(AppTheme.deepNavy)

        let renderer = ImageRenderer(content: view)
        renderer.scale = 3
        return renderer.uiImage
    }

    @MainActor
    func generateDestinyMatrixPDF(
        matrix: DestinyMatrix,
        notes: String?,
        savedDate: Date
    ) -> URL? {
        let pdfMetaData = [
            kCGPDFContextCreator: "TarotGo",
            kCGPDFContextAuthor: "TarotGo App",
            kCGPDFContextTitle: "Destiny Matrix - \(matrix.formattedBirthDate)"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

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

            // App Icon (centered)
            if let appIcon = Self.appIconImage() {
                let iconSize: CGFloat = 60
                let iconX = (pageWidth - iconSize) / 2
                let iconRect = CGRect(x: iconX, y: yPosition, width: iconSize, height: iconSize)
                context.cgContext.saveGState()
                let iconPath = UIBezierPath(roundedRect: iconRect, cornerRadius: iconSize * 0.22)
                iconPath.addClip()
                appIcon.draw(in: iconRect)
                context.cgContext.restoreGState()
                yPosition += iconSize + 15
            }

            // Title (centered)
            let titleFont = UIFont.systemFont(ofSize: 32, weight: .bold)
            let titleSize = L10n.pdfMatrixTitle.size(withAttributes: [.font: titleFont])
            let titleX = (pageWidth - titleSize.width) / 2
            yPosition = drawText(
                L10n.pdfMatrixTitle,
                at: CGPoint(x: titleX, y: yPosition),
                width: titleSize.width + 1,
                font: titleFont,
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )

            yPosition += 10
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25

            // Birth date
            drawCrescent(at: CGPoint(x: margin + 8, y: yPosition + 8), size: 5, context: context.cgContext)
            yPosition = drawText(
                "\(L10n.pdfMatrixBirthDate) \(matrix.formattedBirthDate)",
                at: CGPoint(x: margin + 25, y: yPosition),
                width: contentWidth - 25,
                font: .systemFont(ofSize: 14, weight: .medium),
                color: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
            )

            yPosition += 10
            let savedFormatter = DateFormatter()
            savedFormatter.dateStyle = .long
            savedFormatter.timeStyle = .short
            yPosition = drawText(
                "\(L10n.pdfMatrixSavedOn) \(savedFormatter.string(from: savedDate))",
                at: CGPoint(x: margin + 25, y: yPosition),
                width: contentWidth - 25,
                font: .systemFont(ofSize: 12, weight: .light),
                color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
            )

            yPosition += 25

            // Destiny Matrix diagram
            let diagramRenderSize: CGFloat = 800
            if let diagramImage = renderDestinyMatrixDiagramImage(matrix: matrix, size: diagramRenderSize) {
                let drawSize: CGFloat = min(contentWidth, 360)
                let diagramX = (pageWidth - drawSize) / 2
                let diagramRect = CGRect(x: diagramX, y: yPosition, width: drawSize, height: drawSize)
                let cornerRadius: CGFloat = 16

                context.cgContext.saveGState()
                let clipPath = UIBezierPath(roundedRect: diagramRect, cornerRadius: cornerRadius)
                clipPath.addClip()
                diagramImage.draw(in: diagramRect)
                context.cgContext.restoreGState()

                context.cgContext.saveGState()
                let borderPath = UIBezierPath(roundedRect: diagramRect, cornerRadius: cornerRadius)
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.5).setStroke()
                borderPath.lineWidth = 1
                borderPath.stroke()
                context.cgContext.restoreGState()

                yPosition += drawSize + 25
            }

            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25

            // Core Essence (center position) section
            if let center = matrix.centerPosition {
                // Keep the Core Essence section together: if it won't fit comfortably
                // on the remaining page, push it to the next page so the highlighted
                // box isn't sliced by the page break.
                if yPosition > pageHeight - 260 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition = drawSectionHeader(
                    title: L10n.pdfMatrixCoreEssence,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 5

                yPosition = drawMatrixPositionDetail(
                    position: center,
                    isHighlighted: true,
                    yPosition: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    pageWidth: pageWidth,
                    context: context
                )

                yPosition += 25
            }

            // Current Year Energy
            if let currentYear = matrix.currentYearEnergy {
                if yPosition > pageHeight - 280 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition = drawSectionHeader(
                    title: L10n.pdfMatrixCurrentYear,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 5

                yPosition = drawYearlyEnergyDetail(
                    yearEnergy: currentYear,
                    yPosition: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    pageWidth: pageWidth,
                    context: context
                )

                yPosition += 25
            }

            // Key positions section
            if yPosition > pageHeight - 200 {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60
            }

            yPosition = drawSectionHeader(
                title: L10n.pdfMatrixKeyPositions,
                at: yPosition,
                margin: margin,
                contentWidth: contentWidth,
                context: context.cgContext
            )
            yPosition += 10

            // Order positions (skip center since it was already shown)
            let priorityOrder: [MatrixPosition.PositionType] = [
                .personalPower, .socialRealization, .spiritualDevelopment, .planetaryInfluence,
                .purpose, .talents, .money, .relationships, .health, .karma,
                .male, .female, .sky, .earth, .comfort, .past, .present, .future
            ]
            let orderedPositions = priorityOrder.compactMap { type in
                matrix.positions.first { $0.position == type }
            }

            for (index, position) in orderedPositions.enumerated() {
                if yPosition > pageHeight - 240 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition = drawMatrixPositionDetail(
                    position: position,
                    isHighlighted: false,
                    yPosition: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    pageWidth: pageWidth,
                    context: context
                )

                if index < orderedPositions.count - 1 {
                    let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
                    goldColor.withAlphaComponent(0.3).setStroke()
                    let leftLine = UIBezierPath()
                    leftLine.move(to: CGPoint(x: margin, y: yPosition + 10))
                    leftLine.addLine(to: CGPoint(x: pageWidth / 2 - 20, y: yPosition + 10))
                    leftLine.lineWidth = 0.5
                    leftLine.stroke()
                    let rightLine = UIBezierPath()
                    rightLine.move(to: CGPoint(x: pageWidth / 2 + 20, y: yPosition + 10))
                    rightLine.addLine(to: CGPoint(x: pageWidth - margin, y: yPosition + 10))
                    rightLine.lineWidth = 0.5
                    rightLine.stroke()
                    goldColor.setFill()
                    drawStar(at: CGPoint(x: pageWidth / 2, y: yPosition + 10), size: 5, context: context.cgContext)
                    yPosition += 25
                }
            }

            // Life Timeline section (year analysis)
            if !matrix.yearlyEnergies.isEmpty {
                if yPosition > pageHeight - 260 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition += 10
                yPosition = drawSectionHeader(
                    title: L10n.pdfMatrixLifeTimeline,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 8

                if let currentYear = matrix.currentYearEnergy {
                    yPosition = drawCurrentYearTimelineCard(
                        yearEnergy: currentYear,
                        yPosition: yPosition,
                        margin: margin,
                        contentWidth: contentWidth,
                        context: context
                    )
                    yPosition += 18
                }

                for startAge in stride(from: 1, through: 71, by: 10) {
                    let decadeYears = matrix.yearlyEnergies.filter { $0.age >= startAge && $0.age <= startAge + 9 }
                    if decadeYears.isEmpty { continue }

                    if yPosition > pageHeight - 110 {
                        drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                        pageNumber += 1
                        context.beginPage()
                        drawMysticalBackground(in: pageRect, context: context.cgContext)
                        yPosition = 60
                    }

                    yPosition = drawDecadeRow(
                        decadeStart: startAge,
                        years: decadeYears,
                        yPosition: yPosition,
                        margin: margin,
                        contentWidth: contentWidth,
                        context: context
                    )
                    yPosition += 14
                }

                yPosition += 10
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

            // App Store Promo
            let appStorePromoHeight: CGFloat = 70
            if yPosition > pageHeight - appStorePromoHeight - 60 {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60
            }

            yPosition += 30
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 20

            yPosition = drawText(
                "Download TarotGo on the App Store:",
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .medium),
                color: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
            )
            yPosition += 5
            yPosition = drawText(
                "https://apps.apple.com/app/id6762875158",
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .light),
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )

            drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let filename = "DestinyMatrix_\(dateFormatter.string(from: matrix.birthDate)).pdf"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            return nil
        }
    }

    private func drawMatrixPositionDetail(
        position: MatrixPosition,
        isHighlighted: Bool,
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        pageWidth: CGFloat,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        var yPosition = initialY

        let sectionTopY = yPosition
        yPosition += 5

        // Draw circular number badge
        drawCardPositionBadge(position: position.number, at: CGPoint(x: margin, y: yPosition), context: context.cgContext)

        // Position title
        yPosition = drawText(
            position.position.displayName,
            at: CGPoint(x: margin + 50, y: yPosition + 5),
            width: contentWidth - 50 - 110,
            font: .systemFont(ofSize: 18, weight: .semibold),
            color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        )

        yPosition += 4

        // Position description
        yPosition = drawText(
            position.position.description,
            at: CGPoint(x: margin + 50, y: yPosition),
            width: contentWidth - 50 - 110,
            font: .italicSystemFont(ofSize: 12),
            color: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
        )

        yPosition += 10

        // Card image on the right
        if let card = position.tarotCard, let cardImage = UIImage(named: card.id) {
            let cardImageHeight: CGFloat = 110
            let cardImageWidth: CGFloat = cardImageHeight * (1108.0 / 1900.0)
            let cardX = pageWidth - margin - cardImageWidth
            let cornerRadius = cardImageWidth * 0.06

            let imageRect = CGRect(x: cardX, y: sectionTopY + 5, width: cardImageWidth, height: cardImageHeight)

            context.cgContext.saveGState()
            let cardBg = UIBezierPath(roundedRect: imageRect, cornerRadius: cornerRadius)
            UIColor.white.setFill()
            cardBg.fill()
            cardBg.addClip()
            cardImage.draw(in: imageRect)
            context.cgContext.restoreGState()

            context.cgContext.saveGState()
            let borderPath = UIBezierPath(roundedRect: imageRect, cornerRadius: cornerRadius)
            UIColor.gray.setStroke()
            borderPath.lineWidth = 0.5
            borderPath.stroke()
            context.cgContext.restoreGState()
        }

        // Energy number + card name
        if let card = position.tarotCard {
            let energyText = "\(L10n.pdfMatrixEnergy) \(position.number) • \(card.localizedName)"
            yPosition = drawText(
                energyText,
                at: CGPoint(x: margin + 50, y: yPosition),
                width: contentWidth - 50 - 110,
                font: .systemFont(ofSize: 13, weight: .medium),
                color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            )
        } else {
            yPosition = drawText(
                "\(L10n.pdfMatrixEnergy) \(position.number)",
                at: CGPoint(x: margin + 50, y: yPosition),
                width: contentWidth - 50 - 110,
                font: .systemFont(ofSize: 13, weight: .medium),
                color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            )
        }

        // Ensure image takes minimum space
        let imageBottomY = sectionTopY + 5 + 110
        if yPosition < imageBottomY {
            yPosition = imageBottomY
        }

        // Optional highlighted background
        if isHighlighted {
            context.cgContext.saveGState()
            let boxRect = CGRect(
                x: margin - 12,
                y: sectionTopY - 5,
                width: contentWidth + 24,
                height: yPosition - sectionTopY + 18
            )
            let highlightBox = UIBezierPath(roundedRect: boxRect, cornerRadius: 12)
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.08).setFill()
            highlightBox.fill()
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.4).setStroke()
            highlightBox.lineWidth = 1
            highlightBox.stroke()
            context.cgContext.restoreGState()
        }

        yPosition += 18

        return yPosition
    }

    private func drawYearlyEnergyDetail(
        yearEnergy: YearlyEnergy,
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        pageWidth: CGFloat,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        var yPosition = initialY
        let sectionTopY = yPosition
        yPosition += 5

        drawCardPositionBadge(position: yearEnergy.primaryEnergy, at: CGPoint(x: margin, y: yPosition), context: context.cgContext)

        let title = "\(L10n.pdfMatrixYear) \(yearEnergy.year) • \(L10n.pdfMatrixAge) \(yearEnergy.age)"
        yPosition = drawText(
            title,
            at: CGPoint(x: margin + 50, y: yPosition + 5),
            width: contentWidth - 50 - 110,
            font: .systemFont(ofSize: 18, weight: .semibold),
            color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        )

        yPosition += 8

        if let card = yearEnergy.primaryCard {
            yPosition = drawText(
                "\(L10n.pdfMatrixEnergy) \(yearEnergy.primaryEnergy) • \(card.localizedName)",
                at: CGPoint(x: margin + 50, y: yPosition),
                width: contentWidth - 50 - 110,
                font: .systemFont(ofSize: 13, weight: .medium),
                color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            )

            if let cardImage = UIImage(named: card.id) {
                let cardImageHeight: CGFloat = 110
                let cardImageWidth: CGFloat = cardImageHeight * (1108.0 / 1900.0)
                let cardX = pageWidth - margin - cardImageWidth
                let cornerRadius = cardImageWidth * 0.06

                let imageRect = CGRect(x: cardX, y: sectionTopY + 5, width: cardImageWidth, height: cardImageHeight)

                context.cgContext.saveGState()
                let cardBg = UIBezierPath(roundedRect: imageRect, cornerRadius: cornerRadius)
                UIColor.white.setFill()
                cardBg.fill()
                cardBg.addClip()
                cardImage.draw(in: imageRect)
                context.cgContext.restoreGState()

                context.cgContext.saveGState()
                let borderPath = UIBezierPath(roundedRect: imageRect, cornerRadius: cornerRadius)
                UIColor.gray.setStroke()
                borderPath.lineWidth = 0.5
                borderPath.stroke()
                context.cgContext.restoreGState()
            }
        }

        let imageBottomY = sectionTopY + 5 + 110
        if yPosition < imageBottomY {
            yPosition = imageBottomY
        }

        yPosition += 12
        return yPosition
    }

    // MARK: - Life Timeline Helpers

    private func drawCurrentYearTimelineCard(
        yearEnergy: YearlyEnergy,
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        let boxTopY = initialY
        let innerLeft = margin + 4
        let innerWidth = contentWidth - 8
        var yPosition = boxTopY + 14

        let labelText = L10n.pdfMatrixCurrentYear.uppercased()
        let labelFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        let labelAttrs: [NSAttributedString.Key: Any] = [
            .font: labelFont,
            .foregroundColor: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0),
            .kern: 1.2
        ]
        (labelText as NSString).draw(
            at: CGPoint(x: innerLeft, y: yPosition),
            withAttributes: labelAttrs
        )
        yPosition += labelFont.lineHeight + 4

        let title = "\(L10n.pdfMatrixYear) \(yearEnergy.year) • \(L10n.pdfMatrixAge) \(yearEnergy.age)"
        let titleFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        yPosition = drawText(
            title,
            at: CGPoint(x: innerLeft, y: yPosition),
            width: innerWidth - 70,
            font: titleFont,
            color: goldColor
        )

        // Energy badge on the right
        let badgeRadius: CGFloat = 22
        let badgeCenter = CGPoint(
            x: margin + contentWidth - badgeRadius - 6,
            y: boxTopY + 14 + badgeRadius + 4
        )

        goldColor.setFill()
        UIBezierPath(
            arcCenter: badgeCenter,
            radius: badgeRadius,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        ).fill()

        let energyText = "\(yearEnergy.primaryEnergy)" as NSString
        let energyFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let energyAttrs: [NSAttributedString.Key: Any] = [
            .font: energyFont,
            .foregroundColor: UIColor.black
        ]
        let energySize = energyText.size(withAttributes: energyAttrs)
        energyText.draw(
            at: CGPoint(
                x: badgeCenter.x - energySize.width / 2,
                y: badgeCenter.y - energySize.height / 2
            ),
            withAttributes: energyAttrs
        )

        yPosition += 10

        // Description sentence
        yPosition = drawText(
            L10n.pdfMatrixCurrentYearDesc,
            at: CGPoint(x: innerLeft, y: yPosition),
            width: innerWidth,
            font: .italicSystemFont(ofSize: 12),
            color: UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
        )

        if let card = yearEnergy.primaryCard {
            yPosition += 8
            let keywords = card.localizedKeywords.prefix(4).joined(separator: " • ")
            let cardLine = keywords.isEmpty
                ? card.localizedName
                : "\(card.localizedName) — \(keywords)"
            yPosition = drawText(
                cardLine,
                at: CGPoint(x: innerLeft, y: yPosition),
                width: innerWidth,
                font: .systemFont(ofSize: 13, weight: .medium),
                color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            )
        }

        yPosition += 12

        let boxRect = CGRect(
            x: margin - 8,
            y: boxTopY,
            width: contentWidth + 16,
            height: yPosition - boxTopY
        )
        context.cgContext.saveGState()
        let boxPath = UIBezierPath(roundedRect: boxRect, cornerRadius: 12)
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.08).setFill()
        boxPath.fill()
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.4).setStroke()
        boxPath.lineWidth = 1
        boxPath.stroke()
        context.cgContext.restoreGState()

        return yPosition
    }

    private func drawDecadeRow(
        decadeStart: Int,
        years: [YearlyEnergy],
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        var yPosition = initialY

        let labelText = "\(decadeStart)-\(decadeStart + 9) \(L10n.pdfMatrixYears)"
        yPosition = drawText(
            labelText,
            at: CGPoint(x: margin, y: yPosition),
            width: contentWidth,
            font: .systemFont(ofSize: 13, weight: .semibold),
            color: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
        )
        yPosition += 6

        let chipCount = max(years.count, 1)
        let chipSpacing: CGFloat = 6
        let totalSpacing = chipSpacing * CGFloat(chipCount - 1)
        let chipWidth = (contentWidth - totalSpacing) / CGFloat(chipCount)
        let circleSize: CGFloat = min(28, chipWidth - 4)
        let ageFontSize: CGFloat = 8
        let yearFontSize: CGFloat = 7
        let rowHeight = ageFontSize + 3 + circleSize + 2 + yearFontSize + 4

        let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        let mutedColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)

        for (index, year) in years.enumerated() {
            let chipX = margin + CGFloat(index) * (chipWidth + chipSpacing)
            let centerX = chipX + chipWidth / 2

            // Age label (top)
            let ageText = "\(year.age)" as NSString
            let ageFont = UIFont.systemFont(ofSize: ageFontSize, weight: .medium)
            let ageAttrs: [NSAttributedString.Key: Any] = [
                .font: ageFont,
                .foregroundColor: mutedColor
            ]
            let ageSize = ageText.size(withAttributes: ageAttrs)
            ageText.draw(
                at: CGPoint(x: centerX - ageSize.width / 2, y: yPosition),
                withAttributes: ageAttrs
            )

            // Circle
            let circleCenter = CGPoint(
                x: centerX,
                y: yPosition + ageFontSize + 3 + circleSize / 2
            )
            let circlePath = UIBezierPath(
                arcCenter: circleCenter,
                radius: circleSize / 2,
                startAngle: 0,
                endAngle: .pi * 2,
                clockwise: true
            )
            if year.isCurrentYear {
                goldColor.setFill()
            } else {
                UIColor(red: 0.95, green: 0.93, blue: 0.88, alpha: 1.0).setFill()
            }
            circlePath.fill()
            goldColor.withAlphaComponent(year.isCurrentYear ? 1.0 : 0.4).setStroke()
            circlePath.lineWidth = year.isCurrentYear ? 1.5 : 0.8
            circlePath.stroke()

            // Energy number
            let energyText = "\(year.primaryEnergy)" as NSString
            let energyFont = UIFont.systemFont(ofSize: 11, weight: .bold)
            let energyAttrs: [NSAttributedString.Key: Any] = [
                .font: energyFont,
                .foregroundColor: year.isCurrentYear
                    ? UIColor.black
                    : UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            ]
            let energySize = energyText.size(withAttributes: energyAttrs)
            energyText.draw(
                at: CGPoint(
                    x: circleCenter.x - energySize.width / 2,
                    y: circleCenter.y - energySize.height / 2
                ),
                withAttributes: energyAttrs
            )

            // Year (bottom)
            let yearText = "\(year.year)" as NSString
            let yearFont = UIFont.systemFont(ofSize: yearFontSize, weight: .regular)
            let yearAttrs: [NSAttributedString.Key: Any] = [
                .font: yearFont,
                .foregroundColor: mutedColor
            ]
            let yearSize = yearText.size(withAttributes: yearAttrs)
            yearText.draw(
                at: CGPoint(
                    x: centerX - yearSize.width / 2,
                    y: circleCenter.y + circleSize / 2 + 2
                ),
                withAttributes: yearAttrs
            )
        }

        return yPosition + rowHeight
    }

    // MARK: - Palm Reading PDF

    func generatePalmReadingPDF(
        reading: PalmReading,
        capturedImageData: Data?,
        notes: String?,
        savedDate: Date
    ) -> URL? {
        let pdfMetaData = [
            kCGPDFContextCreator: "TarotGo",
            kCGPDFContextAuthor: "TarotGo App",
            kCGPDFContextTitle: "Palm Reading"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

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

            // Header decorative star
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.2).setFill()
            drawStar(at: CGPoint(x: pageWidth / 2, y: 30), size: 12, context: context.cgContext)
            yPosition += 30

            // App Icon (centered)
            if let appIcon = Self.appIconImage() {
                let iconSize: CGFloat = 60
                let iconX = (pageWidth - iconSize) / 2
                let iconRect = CGRect(x: iconX, y: yPosition, width: iconSize, height: iconSize)
                context.cgContext.saveGState()
                let iconPath = UIBezierPath(roundedRect: iconRect, cornerRadius: iconSize * 0.22)
                iconPath.addClip()
                appIcon.draw(in: iconRect)
                context.cgContext.restoreGState()
                yPosition += iconSize + 15
            }

            // Title (centered)
            let titleFont = UIFont.systemFont(ofSize: 32, weight: .bold)
            let titleSize = L10n.pdfPalmTitle.size(withAttributes: [.font: titleFont])
            let titleX = (pageWidth - titleSize.width) / 2
            yPosition = drawText(
                L10n.pdfPalmTitle,
                at: CGPoint(x: titleX, y: yPosition),
                width: titleSize.width + 1,
                font: titleFont,
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )

            yPosition += 10
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25

            // Saved date
            drawCrescent(at: CGPoint(x: margin + 8, y: yPosition + 8), size: 5, context: context.cgContext)
            let savedFormatter = DateFormatter()
            savedFormatter.dateStyle = .long
            savedFormatter.timeStyle = .short
            yPosition = drawText(
                "\(L10n.pdfPalmSavedOn) \(savedFormatter.string(from: savedDate))",
                at: CGPoint(x: margin + 25, y: yPosition),
                width: contentWidth - 25,
                font: .systemFont(ofSize: 13, weight: .light),
                color: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
            )

            yPosition += 25
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25

            // Overall Reading section with image on the right
            if yPosition > pageHeight - 320 {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60
            }

            if let imageData = capturedImageData, let palmImage = UIImage(data: imageData) {
                let imageColumnWidth: CGFloat = 200
                let maxImageHeight: CGFloat = 280
                let aspect = palmImage.size.width / max(palmImage.size.height, 1)
                var imageWidth = imageColumnWidth
                var imageHeight = imageWidth / max(aspect, 0.01)
                if imageHeight > maxImageHeight {
                    imageHeight = maxImageHeight
                    imageWidth = imageHeight * aspect
                }

                let columnGap: CGFloat = 20
                let leftColumnWidth = contentWidth - imageColumnWidth - columnGap
                let imageX = margin + leftColumnWidth + columnGap + (imageColumnWidth - imageWidth) / 2

                var leftY = drawSectionHeader(
                    title: L10n.palmReadingOverall,
                    at: yPosition,
                    margin: margin,
                    contentWidth: leftColumnWidth,
                    context: context.cgContext
                )
                leftY += 5

                let overallBoxStartY = leftY
                leftY += 12
                leftY = drawText(
                    reading.overallInterpretation,
                    at: CGPoint(x: margin, y: leftY),
                    width: leftColumnWidth,
                    font: .systemFont(ofSize: 13, weight: .light),
                    color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
                )
                leftY += 18

                context.cgContext.saveGState()
                let overallBox = UIBezierPath(
                    roundedRect: CGRect(x: margin - 10, y: overallBoxStartY, width: leftColumnWidth + 20, height: leftY - overallBoxStartY),
                    cornerRadius: 10
                )
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.25).setStroke()
                overallBox.lineWidth = 1
                overallBox.stroke()
                context.cgContext.restoreGState()

                let imageRect = CGRect(x: imageX, y: overallBoxStartY, width: imageWidth, height: imageHeight)
                context.cgContext.saveGState()
                let bg = UIBezierPath(roundedRect: imageRect, cornerRadius: 12)
                UIColor.white.setFill()
                bg.fill()
                bg.addClip()
                palmImage.draw(in: imageRect)
                context.cgContext.restoreGState()

                context.cgContext.saveGState()
                let border = UIBezierPath(roundedRect: imageRect, cornerRadius: 12)
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.5).setStroke()
                border.lineWidth = 1
                border.stroke()
                context.cgContext.restoreGState()

                yPosition = max(leftY, overallBoxStartY + imageHeight)
            } else {
                yPosition = drawSectionHeader(
                    title: L10n.palmReadingOverall,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 5

                let overallBoxStartY = yPosition
                yPosition += 12
                yPosition = drawText(
                    reading.overallInterpretation,
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: .systemFont(ofSize: 13, weight: .light),
                    color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
                )
                yPosition += 18

                context.cgContext.saveGState()
                let overallBox = UIBezierPath(
                    roundedRect: CGRect(x: margin - 10, y: overallBoxStartY, width: contentWidth + 20, height: yPosition - overallBoxStartY),
                    cornerRadius: 10
                )
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.25).setStroke()
                overallBox.lineWidth = 1
                overallBox.stroke()
                context.cgContext.restoreGState()
            }

            yPosition += 25
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25

            // Hand shape
            if yPosition > pageHeight - 250 {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60
            }

            yPosition = drawSectionHeader(
                title: L10n.pdfPalmHandShape,
                at: yPosition,
                margin: margin,
                contentWidth: contentWidth,
                context: context.cgContext
            )
            yPosition += 5

            yPosition = drawText(
                reading.handShape.shapeType.description,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 16, weight: .semibold),
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )
            yPosition += 6

            let handMetaText = "\(L10n.pdfPalmFingerLength) \(reading.handShape.fingerLength.description)  •  \(L10n.pdfPalmShape) \(reading.handShape.palmRatio.description)"
            yPosition = drawText(
                handMetaText,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .italicSystemFont(ofSize: 12),
                color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
            )
            yPosition += 10

            yPosition = drawText(
                PalmInterpretations.handShapeInterpretation(for: reading.handShape),
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .light),
                color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            )

            yPosition += 25
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25

            // Palm lines
            if yPosition > pageHeight - 220 {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60
            }

            yPosition = drawSectionHeader(
                title: L10n.pdfPalmLines,
                at: yPosition,
                margin: margin,
                contentWidth: contentWidth,
                context: context.cgContext
            )
            yPosition += 10

            let lines: [(PalmLine, PalmLineCharacteristics?)] = [
                (.heart, reading.heartLine),
                (.head, reading.headLine),
                (.life, reading.lifeLine),
                (.fate, reading.fateLine)
            ]

            for (index, entry) in lines.enumerated() {
                if yPosition > pageHeight - 200 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition = drawPalmLineDetail(
                    line: entry.0,
                    characteristics: entry.1,
                    reading: reading,
                    yPosition: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context
                )

                if index < lines.count - 1 {
                    let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
                    goldColor.withAlphaComponent(0.3).setStroke()
                    let leftLine = UIBezierPath()
                    leftLine.move(to: CGPoint(x: margin, y: yPosition + 8))
                    leftLine.addLine(to: CGPoint(x: pageWidth / 2 - 20, y: yPosition + 8))
                    leftLine.lineWidth = 0.5
                    leftLine.stroke()
                    let rightLine = UIBezierPath()
                    rightLine.move(to: CGPoint(x: pageWidth / 2 + 20, y: yPosition + 8))
                    rightLine.addLine(to: CGPoint(x: pageWidth - margin, y: yPosition + 8))
                    rightLine.lineWidth = 0.5
                    rightLine.stroke()
                    goldColor.setFill()
                    drawStar(at: CGPoint(x: pageWidth / 2, y: yPosition + 8), size: 5, context: context.cgContext)
                    yPosition += 22
                }
            }

            // Palm mounts
            if !reading.mounts.isEmpty {
                if yPosition > pageHeight - 220 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition += 15
                yPosition = drawSectionHeader(
                    title: L10n.pdfPalmMounts,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 10

                for (index, mount) in reading.mounts.enumerated() {
                    if yPosition > pageHeight - 160 {
                        drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                        pageNumber += 1
                        context.beginPage()
                        drawMysticalBackground(in: pageRect, context: context.cgContext)
                        yPosition = 60
                    }

                    yPosition = drawPalmMountDetail(
                        mount: mount,
                        yPosition: yPosition,
                        margin: margin,
                        contentWidth: contentWidth,
                        context: context
                    )

                    if index < reading.mounts.count - 1 {
                        yPosition += 12
                    }
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

                yPosition += 20
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

            // App Store Promo
            let appStorePromoHeight: CGFloat = 70
            if yPosition > pageHeight - appStorePromoHeight - 60 {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60
            }

            yPosition += 30
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 20

            yPosition = drawText(
                "Download TarotGo on the App Store:",
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .medium),
                color: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
            )
            yPosition += 5
            yPosition = drawText(
                "https://apps.apple.com/app/id6762875158",
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 13, weight: .light),
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )

            drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let filename = "PalmReading_\(dateFormatter.string(from: savedDate)).pdf"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            return nil
        }
    }

    private func drawPalmLineDetail(
        line: PalmLine,
        characteristics: PalmLineCharacteristics?,
        reading: PalmReading,
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        var yPosition = initialY

        yPosition = drawText(
            line.localizedName,
            at: CGPoint(x: margin, y: yPosition),
            width: contentWidth,
            font: .systemFont(ofSize: 17, weight: .semibold),
            color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        )
        yPosition += 6

        if let characteristics = characteristics {
            let metaText = "\(L10n.pdfPalmLength) \(characteristics.length.description)  •  \(L10n.pdfPalmDepth) \(characteristics.depth.description)  •  \(L10n.pdfPalmContinuity) \(characteristics.continuity.description)"
            yPosition = drawText(
                metaText,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .italicSystemFont(ofSize: 12),
                color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
            )
            yPosition += 10
        }

        let interpretationText = reading.interpretation(for: line)
        let interpFont = UIFont.systemFont(ofSize: 13, weight: .light)
        let interpParagraph = NSMutableParagraphStyle()
        interpParagraph.lineSpacing = 3
        let interpAttributes: [NSAttributedString.Key: Any] = [
            .font: interpFont,
            .paragraphStyle: interpParagraph
        ]
        let interpString = NSAttributedString(string: interpretationText, attributes: interpAttributes)
        let interpRect = interpString.boundingRect(
            with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )

        let boxTopInset: CGFloat = 12
        let boxBottomInset: CGFloat = 16
        let boxStartY = yPosition
        let boxHeight = interpRect.height + boxTopInset + boxBottomInset

        context.cgContext.saveGState()
        let boxRect = CGRect(
            x: margin - 8,
            y: boxStartY,
            width: contentWidth + 16,
            height: boxHeight
        )
        UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.8).setFill()
        let interpBox = UIBezierPath(roundedRect: boxRect, cornerRadius: 8)
        interpBox.fill()
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.2).setStroke()
        interpBox.lineWidth = 1
        interpBox.stroke()
        context.cgContext.restoreGState()

        yPosition += boxTopInset
        yPosition = drawText(
            interpretationText,
            at: CGPoint(x: margin, y: yPosition),
            width: contentWidth,
            font: interpFont,
            color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        )

        yPosition = boxStartY + boxHeight + 12
        return yPosition
    }

    private func drawPalmMountDetail(
        mount: PalmMountCharacteristics,
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        var yPosition = initialY

        yPosition = drawText(
            mount.mount.localizedName,
            at: CGPoint(x: margin, y: yPosition),
            width: contentWidth,
            font: .systemFont(ofSize: 15, weight: .semibold),
            color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        )
        yPosition += 4

        yPosition = drawText(
            "\(L10n.pdfPalmProminence) \(mount.prominence.description)",
            at: CGPoint(x: margin, y: yPosition),
            width: contentWidth,
            font: .italicSystemFont(ofSize: 12),
            color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        )
        yPosition += 8

        let mountText = PalmInterpretations.mountInterpretation(for: mount)
        let mountFont = UIFont.systemFont(ofSize: 12, weight: .light)
        let mountParagraph = NSMutableParagraphStyle()
        mountParagraph.lineSpacing = 3
        let mountAttributes: [NSAttributedString.Key: Any] = [
            .font: mountFont,
            .paragraphStyle: mountParagraph
        ]
        let mountString = NSAttributedString(string: mountText, attributes: mountAttributes)
        let mountRect = mountString.boundingRect(
            with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )

        let boxTopInset: CGFloat = 12
        let boxBottomInset: CGFloat = 16
        let boxStartY = yPosition
        let boxHeight = mountRect.height + boxTopInset + boxBottomInset

        context.cgContext.saveGState()
        let boxRect = CGRect(
            x: margin - 8,
            y: boxStartY,
            width: contentWidth + 16,
            height: boxHeight
        )
        UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.8).setFill()
        let mountBox = UIBezierPath(roundedRect: boxRect, cornerRadius: 8)
        mountBox.fill()
        UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.2).setStroke()
        mountBox.lineWidth = 1
        mountBox.stroke()
        context.cgContext.restoreGState()

        yPosition += boxTopInset
        yPosition = drawText(
            mountText,
            at: CGPoint(x: margin, y: yPosition),
            width: contentWidth,
            font: mountFont,
            color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        )

        yPosition = boxStartY + boxHeight + 10
        return yPosition
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
