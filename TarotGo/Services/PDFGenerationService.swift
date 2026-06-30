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
        
        for _ in 0..<20 {
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
                
                let interpretation = drawnCard.effectiveInterpretation
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
                L10n.pdfDownloadOnAppStore,
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
                if yPosition > pageHeight - 320 {
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
                    pageHeight: pageHeight,
                    pageRect: pageRect,
                    pageNumber: &pageNumber,
                    context: context
                )

                yPosition += 25
            }

            // Key positions section
            if yPosition > pageHeight - 320 {
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
                if index > 0 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition = drawMatrixPositionDetail(
                    position: position,
                    isHighlighted: true,
                    yPosition: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    pageWidth: pageWidth,
                    pageHeight: pageHeight,
                    pageRect: pageRect,
                    pageNumber: &pageNumber,
                    context: context
                )
            }

            // Life Timeline section (year analysis)
            if !matrix.yearlyEnergies.isEmpty {
                if yPosition > pageHeight - 320 {
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
                        pageWidth: pageWidth,
                        pageHeight: pageHeight,
                        pageRect: pageRect,
                        pageNumber: &pageNumber,
                        context: context
                    )
                    yPosition += 18
                }

                // Start the decade circles section on a fresh page
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60

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
                    yPosition += 10
                }

                yPosition += 10

                // Energy Legend page
                yPosition = drawEnergyLegendPage(
                    margin: margin,
                    contentWidth: contentWidth,
                    pageWidth: pageWidth,
                    pageHeight: pageHeight,
                    pageRect: pageRect,
                    pageNumber: &pageNumber,
                    context: context
                )
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
                L10n.pdfDownloadOnAppStore,
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

    // MARK: - Card Meanings

    private func drawCardMeanings(
        card: TarotCard,
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        pageWidth: CGFloat,
        pageHeight: CGFloat,
        pageRect: CGRect,
        pageNumber: inout Int,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        var yPosition = initialY

        let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        let textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        let categoryFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        let bodyFont = UIFont.systemFont(ofSize: 11, weight: .light)

        let categories: [(String, IntentionCategory)] = [
            (L10n.dictionaryGeneral, .general),
            (L10n.categoryLove, .love),
            (L10n.categoryCareer, .career),
            (L10n.categoryFinance, .finance),
            (L10n.categoryHealth, .health)
        ]

        let bodyParagraph = NSMutableParagraphStyle()
        bodyParagraph.lineSpacing = 3

        var meaningsHeaderDrawn = false

        for (categoryName, category) in categories {
            let interpretation = card.interpretation(for: category, reversed: false)

            let bodyAttrs: [NSAttributedString.Key: Any] = [
                .font: bodyFont,
                .paragraphStyle: bodyParagraph
            ]
            let interpString = NSAttributedString(string: interpretation, attributes: bodyAttrs)
            let interpRect = interpString.boundingRect(
                with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            let categorySectionHeight: CGFloat = 22 + interpRect.height + 10
            let meaningsHeaderHeight: CGFloat = meaningsHeaderDrawn ? 0 : 28
            let requiredHeight = categorySectionHeight + meaningsHeaderHeight

            if yPosition + requiredHeight > pageHeight - 60 {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60
                meaningsHeaderDrawn = false
            }

            if !meaningsHeaderDrawn {
                yPosition = drawText(
                    L10n.dictionaryMeanings,
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: .systemFont(ofSize: 13, weight: .semibold),
                    color: goldColor
                )
                yPosition += 6
                meaningsHeaderDrawn = true
            }

            yPosition = drawText(
                categoryName,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: categoryFont,
                color: goldColor
            )
            yPosition += 2

            yPosition = drawText(
                interpretation,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: bodyFont,
                color: textColor
            )
            yPosition += 8
        }

        return yPosition
    }

    private func drawMatrixPositionDetail(
        position: MatrixPosition,
        isHighlighted: Bool,
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        pageWidth: CGFloat,
        pageHeight: CGFloat,
        pageRect: CGRect,
        pageNumber: inout Int,
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

        yPosition += 30

        if let card = position.tarotCard {
            yPosition = drawCardMeanings(
                card: card,
                yPosition: yPosition,
                margin: margin,
                contentWidth: contentWidth,
                pageWidth: pageWidth,
                pageHeight: pageHeight,
                pageRect: pageRect,
                pageNumber: &pageNumber,
                context: context
            )
        }

        return yPosition
    }

    // MARK: - Life Timeline Helpers

    private func drawCurrentYearTimelineCard(
        yearEnergy: YearlyEnergy,
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        pageWidth: CGFloat,
        pageHeight: CGFloat,
        pageRect: CGRect,
        pageNumber: inout Int,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        var yPosition = initialY
        let sectionTopY = yPosition
        yPosition += 5

        // Number badge on the left
        drawCardPositionBadge(position: yearEnergy.primaryEnergy, at: CGPoint(x: margin, y: yPosition), context: context.cgContext)

        // "CURRENT YEAR" label
        let labelText = L10n.pdfMatrixCurrentYear.uppercased()
        let labelFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        let labelAttrs: [NSAttributedString.Key: Any] = [
            .font: labelFont,
            .foregroundColor: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0),
            .kern: 1.2
        ]
        (labelText as NSString).draw(
            at: CGPoint(x: margin + 50, y: yPosition + 2),
            withAttributes: labelAttrs
        )
        yPosition += labelFont.lineHeight + 6

        // Year • Age title
        let title = "\(L10n.pdfMatrixYear) \(yearEnergy.year) • \(L10n.pdfMatrixAge) \(yearEnergy.age)"
        yPosition = drawText(
            title,
            at: CGPoint(x: margin + 50, y: yPosition),
            width: contentWidth - 50 - 110,
            font: .systemFont(ofSize: 18, weight: .semibold),
            color: goldColor
        )

        yPosition += 4

        // Description
        yPosition = drawText(
            L10n.pdfMatrixCurrentYearDesc,
            at: CGPoint(x: margin + 50, y: yPosition),
            width: contentWidth - 50 - 110,
            font: .italicSystemFont(ofSize: 12),
            color: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
        )

        yPosition += 10

        // Card image on the right (inside the box)
        if let card = yearEnergy.primaryCard, let cardImage = UIImage(named: card.id) {
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
        if let card = yearEnergy.primaryCard {
            yPosition = drawText(
                "\(L10n.pdfMatrixEnergy) \(yearEnergy.primaryEnergy) • \(card.localizedName)",
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

        // Highlighted box around the whole section
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

        yPosition += 30

        if let card = yearEnergy.primaryCard {
            yPosition = drawCardMeanings(
                card: card,
                yPosition: yPosition,
                margin: margin,
                contentWidth: contentWidth,
                pageWidth: pageWidth,
                pageHeight: pageHeight,
                pageRect: pageRect,
                pageNumber: &pageNumber,
                context: context
            )
        }

        return yPosition
    }

    private func drawEnergyLegendPage(
        margin: CGFloat,
        contentWidth: CGFloat,
        pageWidth: CGFloat,
        pageHeight: CGFloat,
        pageRect: CGRect,
        pageNumber: inout Int,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        // Start on a fresh page
        drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
        pageNumber += 1
        context.beginPage()
        drawMysticalBackground(in: pageRect, context: context.cgContext)

        var yPosition: CGFloat = 60
        let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        let textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)

        // Section header
        yPosition = drawSectionHeader(
            title: L10n.pdfMatrixEnergyLegend,
            at: yPosition,
            margin: margin,
            contentWidth: contentWidth,
            context: context.cgContext
        )
        yPosition += 6

        // Intro paragraph
        yPosition = drawText(
            L10n.pdfMatrixEnergyLegendIntro,
            at: CGPoint(x: margin, y: yPosition),
            width: contentWidth,
            font: .italicSystemFont(ofSize: 12),
            color: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
        )
        yPosition += 14

        // Two-column grid of 22 energies
        let cards = TarotDeck.majorArcana
        let columnGap: CGFloat = 16
        let columnWidth = (contentWidth - columnGap) / 2
        let rowHeight: CGFloat = 26
        let badgeRadius: CGFloat = 11
        let leftColumnX = margin
        let rightColumnX = margin + columnWidth + columnGap

        let gridStartY = yPosition

        for i in 0..<22 {
            let energyNumber = i + 1
            guard i < cards.count else { break }
            let card = cards[i]

            let isLeftColumn = i < 11
            let columnX = isLeftColumn ? leftColumnX : rightColumnX
            let rowIndex = isLeftColumn ? i : i - 11
            let rowY = gridStartY + CGFloat(rowIndex) * rowHeight

            // Number badge circle
            let badgeCenter = CGPoint(x: columnX + badgeRadius, y: rowY + badgeRadius)
            goldColor.withAlphaComponent(0.9).setFill()
            UIBezierPath(
                arcCenter: badgeCenter,
                radius: badgeRadius,
                startAngle: 0,
                endAngle: .pi * 2,
                clockwise: true
            ).fill()

            UIColor(red: 0.95, green: 0.93, blue: 0.88, alpha: 1.0).setFill()
            UIBezierPath(
                arcCenter: badgeCenter,
                radius: badgeRadius - 2,
                startAngle: 0,
                endAngle: .pi * 2,
                clockwise: true
            ).fill()

            let numberText = "\(energyNumber)" as NSString
            let numberFont = UIFont.systemFont(ofSize: 10, weight: .bold)
            let numberAttrs: [NSAttributedString.Key: Any] = [
                .font: numberFont,
                .foregroundColor: goldColor
            ]
            let numberSize = numberText.size(withAttributes: numberAttrs)
            numberText.draw(
                at: CGPoint(
                    x: badgeCenter.x - numberSize.width / 2,
                    y: badgeCenter.y - numberSize.height / 2
                ),
                withAttributes: numberAttrs
            )

            // Card name + brief keyword
            let textX = columnX + badgeRadius * 2 + 8
            let textWidth = columnWidth - (badgeRadius * 2 + 8)

            let cardName = card.localizedName
            let nameFont = UIFont.systemFont(ofSize: 11, weight: .semibold)
            let nameAttrs: [NSAttributedString.Key: Any] = [
                .font: nameFont,
                .foregroundColor: textColor
            ]
            (cardName as NSString).draw(
                in: CGRect(x: textX, y: rowY + 1, width: textWidth, height: 14),
                withAttributes: nameAttrs
            )

            let keyword = card.localizedKeywords.first ?? ""
            if !keyword.isEmpty {
                let keywordFont = UIFont.italicSystemFont(ofSize: 9)
                let keywordAttrs: [NSAttributedString.Key: Any] = [
                    .font: keywordFont,
                    .foregroundColor: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
                ]
                (keyword as NSString).draw(
                    in: CGRect(x: textX, y: rowY + 13, width: textWidth, height: 12),
                    withAttributes: keywordAttrs
                )
            }
        }

        yPosition = gridStartY + 11 * rowHeight + 10
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

    // MARK: - Couple Matrix PDF

    @MainActor
    private func renderCoupleMatrixDiagramImage(matrix: CoupleMatrix, size: CGFloat) -> UIImage? {
        let view = CoupleMatrixDiagramView(
            matrix: matrix,
            selectedPosition: .constant(nil),
            selectedYear: .constant(nil),
            showsYearlyRing: true,
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
    func generateCoupleMatrixPDF(
        matrix: CoupleMatrix,
        notes: String?,
        savedDate: Date
    ) -> URL? {
        let pdfMetaData = [
            kCGPDFContextCreator: "TarotGo",
            kCGPDFContextAuthor: "TarotGo App",
            kCGPDFContextTitle: "Couple Matrix - \(matrix.formattedBirthDateA) & \(matrix.formattedBirthDateB)"
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
            let titleSize = L10n.pdfCoupleMatrixTitle.size(withAttributes: [.font: titleFont])
            let titleX = (pageWidth - titleSize.width) / 2
            yPosition = drawText(
                L10n.pdfCoupleMatrixTitle,
                at: CGPoint(x: titleX, y: yPosition),
                width: titleSize.width + 1,
                font: titleFont,
                color: UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
            )

            yPosition += 10
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25

            // Partner A birth date
            drawCrescent(at: CGPoint(x: margin + 8, y: yPosition + 8), size: 5, context: context.cgContext)
            yPosition = drawText(
                "\(L10n.coupleMatrixPartnerA): \(matrix.formattedBirthDateA)",
                at: CGPoint(x: margin + 25, y: yPosition),
                width: contentWidth - 25,
                font: .systemFont(ofSize: 14, weight: .medium),
                color: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
            )

            yPosition += 6

            // Partner B birth date
            drawCrescent(at: CGPoint(x: margin + 8, y: yPosition + 8), size: 5, context: context.cgContext, flipped: true)
            yPosition = drawText(
                "\(L10n.coupleMatrixPartnerB): \(matrix.formattedBirthDateB)",
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

            // Couple Matrix diagram
            let diagramRenderSize: CGFloat = 800
            if let diagramImage = renderCoupleMatrixDiagramImage(matrix: matrix, size: diagramRenderSize) {
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

            // Heart of Union section (the .union position highlighted)
            if let union = matrix.unionPosition {
                if yPosition > pageHeight - 320 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition = drawSectionHeader(
                    title: L10n.pdfCoupleMatrixHeartOfUnion,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 5

                yPosition = drawCouplePositionDetail(
                    position: union,
                    isHighlighted: true,
                    yPosition: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    pageWidth: pageWidth,
                    pageHeight: pageHeight,
                    pageRect: pageRect,
                    pageNumber: &pageNumber,
                    context: context
                )

                yPosition += 25
            }

            // Partner Energies section
            let partnerOrder: [CoupleMatrixPosition.CouplePositionType] = [.partnerA, .partnerB]
            let partnerPositions = partnerOrder.compactMap { type in
                matrix.positions.first { $0.position == type }
            }

            if !partnerPositions.isEmpty {
                if yPosition > pageHeight - 320 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition = drawSectionHeader(
                    title: L10n.pdfCoupleMatrixPartnerEnergies,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 10

                for (index, position) in partnerPositions.enumerated() {
                    if index > 0 {
                        drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                        pageNumber += 1
                        context.beginPage()
                        drawMysticalBackground(in: pageRect, context: context.cgContext)
                        yPosition = 60
                    }

                    yPosition = drawCouplePositionDetail(
                        position: position,
                        isHighlighted: true,
                        yPosition: yPosition,
                        margin: margin,
                        contentWidth: contentWidth,
                        pageWidth: pageWidth,
                        pageHeight: pageHeight,
                        pageRect: pageRect,
                        pageNumber: &pageNumber,
                        context: context
                    )
                }

                yPosition += 20
            }

            // Shared Aspects section
            let aspectOrder: [CoupleMatrixPosition.CouplePositionType] = [
                .love, .karma, .money, .sexuality, .children, .purpose, .health
            ]
            let aspectPositions = aspectOrder.compactMap { type in
                matrix.positions.first { $0.position == type }
            }

            if !aspectPositions.isEmpty {
                if yPosition > pageHeight - 320 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }

                yPosition = drawSectionHeader(
                    title: L10n.pdfCoupleMatrixSharedAspects,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 10

                for (index, position) in aspectPositions.enumerated() {
                    if index > 0 {
                        drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                        pageNumber += 1
                        context.beginPage()
                        drawMysticalBackground(in: pageRect, context: context.cgContext)
                        yPosition = 60
                    }

                    yPosition = drawCouplePositionDetail(
                        position: position,
                        isHighlighted: true,
                        yPosition: yPosition,
                        margin: margin,
                        contentWidth: contentWidth,
                        pageWidth: pageWidth,
                        pageHeight: pageHeight,
                        pageRect: pageRect,
                        pageNumber: &pageNumber,
                        context: context
                    )
                }
            }

            // Years Together Timeline
            if !matrix.yearlyEnergies.isEmpty {
                // Always start the Years Together Timeline on a fresh page
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60

                yPosition = drawSectionHeader(
                    title: L10n.pdfCoupleMatrixYearsTimeline,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 8

                if let currentYear = matrix.currentYearEnergy {
                    yPosition = drawCoupleCurrentYearTimelineCard(
                        yearEnergy: currentYear,
                        yPosition: yPosition,
                        margin: margin,
                        contentWidth: contentWidth,
                        context: context
                    )
                    yPosition += 30

                    if let card = currentYear.primaryCard {
                        yPosition = drawCardMeanings(
                            card: card,
                            yPosition: yPosition,
                            margin: margin,
                            contentWidth: contentWidth,
                            pageWidth: pageWidth,
                            pageHeight: pageHeight,
                            pageRect: pageRect,
                            pageNumber: &pageNumber,
                            context: context
                        )
                    }
                }

                // Always start the year circles on a fresh page
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60

                // Group years by decade (year-based, not age-based)
                let grouped = Dictionary(grouping: matrix.yearlyEnergies) { year in
                    (year.year - 1) / 10
                }
                let decadeGroups = grouped
                    .map { (key: $0.key, years: $0.value.sorted { $0.year < $1.year }) }
                    .sorted { $0.key < $1.key }

                for group in decadeGroups {
                    if yPosition > pageHeight - 110 {
                        drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                        pageNumber += 1
                        context.beginPage()
                        drawMysticalBackground(in: pageRect, context: context.cgContext)
                        yPosition = 60
                    }

                    yPosition = drawCoupleYearGroupRow(
                        years: group.years,
                        yPosition: yPosition,
                        margin: margin,
                        contentWidth: contentWidth,
                        context: context
                    )
                    yPosition += 14
                }

                yPosition += 10

                // Energy Legend page
                yPosition = drawEnergyLegendPage(
                    margin: margin,
                    contentWidth: contentWidth,
                    pageWidth: pageWidth,
                    pageHeight: pageHeight,
                    pageRect: pageRect,
                    pageNumber: &pageNumber,
                    context: context
                )
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
                L10n.pdfDownloadOnAppStore,
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
        let filename = "CoupleMatrix_\(dateFormatter.string(from: matrix.birthDateA))_\(dateFormatter.string(from: matrix.birthDateB)).pdf"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            return nil
        }
    }

    private func drawCouplePositionDetail(
        position: CoupleMatrixPosition,
        isHighlighted: Bool,
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        pageWidth: CGFloat,
        pageHeight: CGFloat,
        pageRect: CGRect,
        pageNumber: inout Int,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        var yPosition = initialY

        let sectionTopY = yPosition
        yPosition += 5

        // Number badge
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

        yPosition += 30

        if let card = position.tarotCard {
            yPosition = drawCardMeanings(
                card: card,
                yPosition: yPosition,
                margin: margin,
                contentWidth: contentWidth,
                pageWidth: pageWidth,
                pageHeight: pageHeight,
                pageRect: pageRect,
                pageNumber: &pageNumber,
                context: context
            )
        }

        return yPosition
    }

    private func drawCoupleCurrentYearTimelineCard(
        yearEnergy: CoupleYearlyEnergy,
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

        let title = "\(L10n.pdfMatrixYear) \(yearEnergy.year)"
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
            L10n.pdfCoupleMatrixCurrentYearDesc,
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

    private func drawCoupleYearGroupRow(
        years: [CoupleYearlyEnergy],
        yPosition initialY: CGFloat,
        margin: CGFloat,
        contentWidth: CGFloat,
        context: UIGraphicsPDFRendererContext
    ) -> CGFloat {
        var yPosition = initialY

        guard let first = years.first, let last = years.last else { return yPosition }
        let labelText = first.year == last.year ? "\(first.year)" : "\(first.year) – \(last.year)"
        yPosition = drawText(
            labelText,
            at: CGPoint(x: margin, y: yPosition),
            width: contentWidth,
            font: .systemFont(ofSize: 13, weight: .semibold),
            color: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
        )
        yPosition += 6

        let columnCount = 10
        let chipSpacing: CGFloat = 6
        let totalSpacing = chipSpacing * CGFloat(columnCount - 1)
        let chipWidth = (contentWidth - totalSpacing) / CGFloat(columnCount)
        let circleSize: CGFloat = min(28, chipWidth - 4)
        let yearFontSize: CGFloat = 8
        let rowHeight = circleSize + 2 + yearFontSize + 4

        let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        let mutedColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)

        for year in years {
            let columnIndex = (year.year - 1) % columnCount
            let chipX = margin + CGFloat(columnIndex) * (chipWidth + chipSpacing)
            let centerX = chipX + chipWidth / 2

            // Circle
            let circleCenter = CGPoint(
                x: centerX,
                y: yPosition + circleSize / 2
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

            if let handedness = reading.handedness {
                yPosition += 6
                let iconSize: CGFloat = 14
                let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
                let iconConfig = UIImage.SymbolConfiguration(pointSize: iconSize, weight: .regular)
                if let symbol = UIImage(systemName: "hand.raised.palm.facing.fill", withConfiguration: iconConfig) {
                    // PDF contexts render SF Symbols as vector glyphs that pick up
                    // the current fill color (which leaves us with a solid block).
                    // Rasterize into a bitmap UIImage first so the PDF receives a
                    // flat image with the tint baked in.
                    let symbolBox = CGSize(width: iconSize, height: iconSize)
                    let rasterized = UIGraphicsImageRenderer(size: symbolBox).image { _ in
                        symbol.withTintColor(goldColor, renderingMode: .alwaysOriginal)
                            .draw(in: CGRect(origin: .zero, size: symbolBox))
                    }
                    let iconRect = CGRect(x: margin + 6, y: yPosition + 1, width: iconSize, height: iconSize)
                    context.cgContext.saveGState()
                    if handedness == .left {
                        // SF Symbol hand.raised.fill renders as a left palm
                        // (thumb on icon's left); mirror it for the right hand.
                        context.cgContext.translateBy(x: iconRect.midX, y: iconRect.midY)
                        context.cgContext.scaleBy(x: -1, y: 1)
                        context.cgContext.translateBy(x: -iconRect.midX, y: -iconRect.midY)
                    }
                    rasterized.draw(in: iconRect)
                    context.cgContext.restoreGState()
                }
                yPosition = drawText(
                    handedness.localizedName,
                    at: CGPoint(x: margin + 25, y: yPosition),
                    width: contentWidth - 25,
                    font: .systemFont(ofSize: 13, weight: .light),
                    color: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
                )
            }

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
                let imageColumnWidth: CGFloat = 160
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
                let imageX = margin + contentWidth - imageWidth

                var leftY = drawSectionHeader(
                    title: L10n.palmReadingOverall,
                    at: yPosition,
                    margin: margin,
                    contentWidth: leftColumnWidth,
                    context: context.cgContext
                )
                leftY += 5

                let overallFont = UIFont.systemFont(ofSize: 11, weight: .light)
                let overallParagraph = NSMutableParagraphStyle()
                overallParagraph.lineSpacing = 3
                let overallAttributes: [NSAttributedString.Key: Any] = [.font: overallFont, .paragraphStyle: overallParagraph]
                let overallString = NSAttributedString(string: reading.overallInterpretation, attributes: overallAttributes)
                let overallRect = overallString.boundingRect(
                    with: CGSize(width: leftColumnWidth, height: .greatestFiniteMagnitude),
                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                    context: nil
                )

                let overallBoxStartY = leftY
                let overallBoxHeight = overallRect.height + 12 + 18

                context.cgContext.saveGState()
                let overallBox = UIBezierPath(
                    roundedRect: CGRect(x: margin - 10, y: overallBoxStartY, width: leftColumnWidth + 20, height: overallBoxHeight),
                    cornerRadius: 10
                )
                UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.8).setFill()
                overallBox.fill()
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.2).setStroke()
                overallBox.lineWidth = 1
                overallBox.stroke()
                context.cgContext.restoreGState()

                leftY += 12
                leftY = drawText(
                    reading.overallInterpretation,
                    at: CGPoint(x: margin, y: leftY),
                    width: leftColumnWidth,
                    font: overallFont,
                    color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
                )
                leftY = overallBoxStartY + overallBoxHeight

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

                let overallFont = UIFont.systemFont(ofSize: 11, weight: .light)
                let overallParagraph = NSMutableParagraphStyle()
                overallParagraph.lineSpacing = 3
                let overallAttributes: [NSAttributedString.Key: Any] = [.font: overallFont, .paragraphStyle: overallParagraph]
                let overallString = NSAttributedString(string: reading.overallInterpretation, attributes: overallAttributes)
                let overallRect = overallString.boundingRect(
                    with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude),
                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                    context: nil
                )

                let overallBoxStartY = yPosition
                let overallBoxHeight = overallRect.height + 12 + 18

                context.cgContext.saveGState()
                let overallBox = UIBezierPath(
                    roundedRect: CGRect(x: margin - 10, y: overallBoxStartY, width: contentWidth + 20, height: overallBoxHeight),
                    cornerRadius: 10
                )
                UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.8).setFill()
                overallBox.fill()
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.2).setStroke()
                overallBox.lineWidth = 1
                overallBox.stroke()
                context.cgContext.restoreGState()

                yPosition += 12
                yPosition = drawText(
                    reading.overallInterpretation,
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: overallFont,
                    color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
                )
                yPosition = overallBoxStartY + overallBoxHeight
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

            let handShapeText = PalmInterpretations.handShapeInterpretation(for: reading.handShape)
            let handShapeFont = UIFont.systemFont(ofSize: 11, weight: .light)
            let handShapeParagraph = NSMutableParagraphStyle()
            handShapeParagraph.lineSpacing = 3
            let handShapeAttributes: [NSAttributedString.Key: Any] = [.font: handShapeFont, .paragraphStyle: handShapeParagraph]
            let handShapeString = NSAttributedString(string: handShapeText, attributes: handShapeAttributes)
            let handShapeRect = handShapeString.boundingRect(
                with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )

            let handShapeBoxTopInset: CGFloat = 12
            let handShapeBoxBottomInset: CGFloat = 16
            let handShapeBoxStartY = yPosition
            let handShapeBoxHeight = handShapeRect.height + handShapeBoxTopInset + handShapeBoxBottomInset

            context.cgContext.saveGState()
            let handShapeBoxRect = CGRect(
                x: margin - 8,
                y: handShapeBoxStartY,
                width: contentWidth + 16,
                height: handShapeBoxHeight
            )
            UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.8).setFill()
            let handShapeBox = UIBezierPath(roundedRect: handShapeBoxRect, cornerRadius: 8)
            handShapeBox.fill()
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.2).setStroke()
            handShapeBox.lineWidth = 1
            handShapeBox.stroke()
            context.cgContext.restoreGState()

            yPosition += handShapeBoxTopInset
            yPosition = drawText(
                handShapeText,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: handShapeFont,
                color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            )
            yPosition = handShapeBoxStartY + handShapeBoxHeight

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
                if index == 1 {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                } else if yPosition > pageHeight - 200 {
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
                    leftLine.move(to: CGPoint(x: margin, y: yPosition + 5))
                    leftLine.addLine(to: CGPoint(x: pageWidth / 2 - 20, y: yPosition + 5))
                    leftLine.lineWidth = 0.5
                    leftLine.stroke()
                    let rightLine = UIBezierPath()
                    rightLine.move(to: CGPoint(x: pageWidth / 2 + 20, y: yPosition + 5))
                    rightLine.addLine(to: CGPoint(x: pageWidth - margin, y: yPosition + 5))
                    rightLine.lineWidth = 0.5
                    rightLine.stroke()
                    goldColor.setFill()
                    drawStar(at: CGPoint(x: pageWidth / 2, y: yPosition + 5), size: 5, context: context.cgContext)
                    yPosition += 14
                }
            }

            // Palm mounts (always start on a new page)
            if !reading.mounts.isEmpty {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60

                yPosition = drawSectionHeader(
                    title: L10n.pdfPalmMounts,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 10

                let mountsPerPage = 3
                for (index, mount) in reading.mounts.enumerated() {
                    if index > 0 && index % mountsPerPage == 0 {
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

                    let isLastMount = index == reading.mounts.count - 1
                    let isLastOnPage = (index + 1) % mountsPerPage == 0
                    if !isLastMount && !isLastOnPage {
                        yPosition += 12
                    }
                }
            }

            // Notes (always start on a new page)
            if let notes = notes, !notes.isEmpty {
                drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                pageNumber += 1
                context.beginPage()
                drawMysticalBackground(in: pageRect, context: context.cgContext)
                yPosition = 60

                yPosition = drawSectionHeader(title: L10n.summaryReflections, at: yPosition, margin: margin, contentWidth: contentWidth, context: context.cgContext)
                yPosition += 5

                let notesFont = UIFont.systemFont(ofSize: 12, weight: .regular)
                let notesAttributes: [NSAttributedString.Key: Any] = [.font: notesFont]
                let notesString = NSAttributedString(string: notes, attributes: notesAttributes)
                let notesRect = notesString.boundingRect(with: CGSize(width: contentWidth - 20, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)

                context.cgContext.saveGState()
                UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.8).setFill()
                let notesBox = UIBezierPath(roundedRect: CGRect(x: margin - 10, y: yPosition - 10, width: contentWidth + 20, height: notesRect.height + 30), cornerRadius: 8)
                notesBox.fill()
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.2).setStroke()
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
                L10n.pdfDownloadOnAppStore,
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
            yPosition += 6
        }

        let interpretationText = reading.interpretation(for: line)
        let interpFont = UIFont.systemFont(ofSize: 11, weight: .light)
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

        let boxTopInset: CGFloat = 10
        let boxBottomInset: CGFloat = 12
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

        yPosition = boxStartY + boxHeight + 6
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
        let mountFont = UIFont.systemFont(ofSize: 10, weight: .light)
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

        let boxTopInset: CGFloat = 10
        let boxBottomInset: CGFloat = 12
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

        yPosition = boxStartY + boxHeight + 6
        return yPosition
    }

    // MARK: - Compatibility PDF

    struct MercuryRetrogradePDFContext {
        let phaseTitle: String
        let signSymbol: String
        let signName: String
        let yourImpact: String
        let partnerImpact: String
        let coupleGuidance: String
    }

    func generateCompatibilityPDF(
        yourSign: ZodiacSign,
        partnerSign: ZodiacSign,
        score: Double,
        rating: String,
        yourElement: String,
        partnerElement: String,
        elementDescription: String,
        overall: String,
        strengths: String,
        challenges: String,
        advice: String,
        date: Date,
        mercury: MercuryRetrogradePDFContext? = nil
    ) -> URL? {
        let title = NSLocalizedString(
            "pdf.compatibility.title",
            value: "Cosmic Compatibility",
            comment: "Cosmic Compatibility PDF title"
        )
        let heartLabel = NSLocalizedString(
            "pdf.compatibility.heartSeparator",
            value: "♥",
            comment: "Separator between two zodiac signs in the PDF"
        )

        let pdfMetaData = [
            kCGPDFContextCreator: "TarotGo",
            kCGPDFContextAuthor: "TarotGo App",
            kCGPDFContextTitle: "Cosmic Compatibility - \(yourSign.name) & \(partnerSign.name)"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let pageWidth = 8.5 * 72.0
        let pageHeight = 11.0 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        let goldColor = UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 1.0)
        let textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        let mutedColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)

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
            let titleSize = title.size(withAttributes: [.font: titleFont])
            let titleX = (pageWidth - titleSize.width) / 2
            yPosition = drawText(
                title,
                at: CGPoint(x: titleX, y: yPosition),
                width: titleSize.width + 1,
                font: titleFont,
                color: goldColor
            )

            yPosition += 10
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25

            // Date
            drawCrescent(at: CGPoint(x: margin + 8, y: yPosition + 8), size: 5, context: context.cgContext)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            yPosition = drawText(
                dateFormatter.string(from: date),
                at: CGPoint(x: margin + 25, y: yPosition),
                width: contentWidth - 25,
                font: .systemFont(ofSize: 13, weight: .light),
                color: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
            )
            yPosition += 25

            // Signs row (symbols + names with heart between)
            let signCardHeight: CGFloat = 110
            let signCardWidth: CGFloat = (contentWidth - 60) / 2
            let signCardY = yPosition

            drawSignCard(
                title: L10n.compatibilityYourSign,
                sign: yourSign,
                rect: CGRect(x: margin, y: signCardY, width: signCardWidth, height: signCardHeight),
                goldColor: goldColor,
                textColor: textColor,
                context: context.cgContext
            )

            let centerX = pageWidth / 2
            let centerY = signCardY + signCardHeight / 2
            let heartFont = UIFont.systemFont(ofSize: 26, weight: .regular)
            let heartAttrs: [NSAttributedString.Key: Any] = [
                .font: heartFont,
                .foregroundColor: goldColor
            ]
            let heartSize = heartLabel.size(withAttributes: heartAttrs)
            (heartLabel as NSString).draw(
                at: CGPoint(x: centerX - heartSize.width / 2, y: centerY - heartSize.height / 2),
                withAttributes: heartAttrs
            )

            drawSignCard(
                title: L10n.compatibilityPartnerSign,
                sign: partnerSign,
                rect: CGRect(x: margin + signCardWidth + 60, y: signCardY, width: signCardWidth, height: signCardHeight),
                goldColor: goldColor,
                textColor: textColor,
                context: context.cgContext
            )

            yPosition = signCardY + signCardHeight + 25
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 25

            // Compatibility Score
            yPosition = drawSectionHeader(
                title: L10n.compatibilityScore,
                at: yPosition,
                margin: margin,
                contentWidth: contentWidth,
                context: context.cgContext
            )
            yPosition += 10

            let scoreBoxStartY = yPosition
            let scoreBoxHeight: CGFloat = 110

            // Draw progress ring on the left
            let ringCenterX = margin + 50
            let ringCenterY = scoreBoxStartY + scoreBoxHeight / 2
            let ringRadius: CGFloat = 36
            let ringLineWidth: CGFloat = 8
            let ringTrackPath = UIBezierPath(
                arcCenter: CGPoint(x: ringCenterX, y: ringCenterY),
                radius: ringRadius,
                startAngle: 0,
                endAngle: .pi * 2,
                clockwise: true
            )
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.15).setStroke()
            ringTrackPath.lineWidth = ringLineWidth
            ringTrackPath.stroke()

            let progressEnd = -.pi / 2 + (.pi * 2 * CGFloat(score / 100))
            let ringProgressPath = UIBezierPath(
                arcCenter: CGPoint(x: ringCenterX, y: ringCenterY),
                radius: ringRadius,
                startAngle: -.pi / 2,
                endAngle: progressEnd,
                clockwise: true
            )
            goldColor.setStroke()
            ringProgressPath.lineWidth = ringLineWidth
            ringProgressPath.lineCapStyle = .round
            ringProgressPath.stroke()

            let scoreText = "\(Int(score))%"
            let scoreFont = UIFont.systemFont(ofSize: 20, weight: .bold)
            let scoreAttrs: [NSAttributedString.Key: Any] = [
                .font: scoreFont,
                .foregroundColor: goldColor
            ]
            let scoreSize = scoreText.size(withAttributes: scoreAttrs)
            (scoreText as NSString).draw(
                at: CGPoint(x: ringCenterX - scoreSize.width / 2, y: ringCenterY - scoreSize.height / 2),
                withAttributes: scoreAttrs
            )

            // Rating text to the right of the ring
            let ratingFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
            let ratingX = ringCenterX + ringRadius + 28
            var ratingY = ringCenterY - 18
            ratingY = drawText(
                rating,
                at: CGPoint(x: ratingX, y: ratingY),
                width: pageWidth - margin - ratingX,
                font: ratingFont,
                color: goldColor
            )
            ratingY += 4
            _ = drawText(
                "\(yourSign.name) \(heartLabel) \(partnerSign.name)",
                at: CGPoint(x: ratingX, y: ratingY),
                width: pageWidth - margin - ratingX,
                font: .systemFont(ofSize: 13, weight: .light),
                color: mutedColor
            )

            // Score box border
            context.cgContext.saveGState()
            let scoreBoxRect = CGRect(
                x: margin - 10,
                y: scoreBoxStartY,
                width: contentWidth + 20,
                height: scoreBoxHeight
            )
            let scoreBox = UIBezierPath(roundedRect: scoreBoxRect, cornerRadius: 10)
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.25).setStroke()
            scoreBox.lineWidth = 1
            scoreBox.stroke()
            context.cgContext.restoreGState()

            yPosition = scoreBoxStartY + scoreBoxHeight + 25

            // Page break: Elemental Match always starts on a new page.
            drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
            pageNumber += 1
            context.beginPage()
            drawMysticalBackground(in: pageRect, context: context.cgContext)
            yPosition = 60

            let bodyFont = UIFont.systemFont(ofSize: 13, weight: .light)
            let bodyParagraph = NSMutableParagraphStyle()
            bodyParagraph.lineSpacing = 3
            let bodyAttrs: [NSAttributedString.Key: Any] = [
                .font: bodyFont,
                .paragraphStyle: bodyParagraph
            ]

            // Estimate text block height for a given body string
            func bodyHeight(for text: String) -> CGFloat {
                let attr = NSAttributedString(string: text, attributes: bodyAttrs)
                return attr.boundingRect(
                    with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude),
                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                    context: nil
                ).height
            }

            // Section header (~40pt) + box top padding (12) + body + box bottom padding (18) + trailing gap (20)
            let sectionHeaderHeight: CGFloat = 40
            let boxTopPadding: CGFloat = 12
            let boxBottomPadding: CGFloat = 18
            let sectionTrailingGap: CGFloat = 20
            let pageBottomLimit = pageHeight - 80

            func ensureRoom(for height: CGFloat) {
                if yPosition + height > pageBottomLimit {
                    drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
                    pageNumber += 1
                    context.beginPage()
                    drawMysticalBackground(in: pageRect, context: context.cgContext)
                    yPosition = 60
                }
            }

            // Elemental Match
            let elementsLine = "\(yourElement)   ↔   \(partnerElement)"
            let elementsLineHeight = bodyHeight(for: elementsLine)
            let elementDescHeight = bodyHeight(for: elementDescription)
            let elementSectionHeight = sectionHeaderHeight + boxTopPadding + elementsLineHeight + 6 + elementDescHeight + boxBottomPadding + sectionTrailingGap
            ensureRoom(for: elementSectionHeight)

            yPosition = drawSectionHeader(
                title: L10n.compatibilityElementalMatch,
                at: yPosition,
                margin: margin,
                contentWidth: contentWidth,
                context: context.cgContext
            )
            yPosition += 10

            let elementBoxStartY = yPosition
            yPosition += boxTopPadding
            yPosition = drawText(
                elementsLine,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: .systemFont(ofSize: 16, weight: .semibold),
                color: goldColor
            )
            yPosition += 6
            yPosition = drawText(
                elementDescription,
                at: CGPoint(x: margin, y: yPosition),
                width: contentWidth,
                font: bodyFont,
                color: textColor
            )
            yPosition += boxBottomPadding

            context.cgContext.saveGState()
            let elementBoxRect = CGRect(
                x: margin - 10,
                y: elementBoxStartY,
                width: contentWidth + 20,
                height: yPosition - elementBoxStartY
            )
            let elementBox = UIBezierPath(roundedRect: elementBoxRect, cornerRadius: 10)
            UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.25).setStroke()
            elementBox.lineWidth = 1
            elementBox.stroke()
            context.cgContext.restoreGState()

            yPosition += sectionTrailingGap

            // Mercury Retrograde × Couple — only rendered when an active period exists.
            if let mercury {
                let badgeText = "\(mercury.phaseTitle) — \(L10n.mercuryInSign) \(mercury.signSymbol) \(mercury.signName)"
                let badgeHeight: CGFloat = 30
                let columnGap: CGFloat = 14
                let columnPadding: CGFloat = 12
                let columnHeaderHeight: CGFloat = 18
                let columnSignHeight: CGFloat = 22
                let columnInnerWidth = (contentWidth - columnGap) / 2 - columnPadding * 2

                func columnHeight(impact: String) -> CGFloat {
                    let attr = NSAttributedString(string: impact, attributes: bodyAttrs)
                    let textH = attr.boundingRect(
                        with: CGSize(width: columnInnerWidth, height: .greatestFiniteMagnitude),
                        options: [.usesLineFragmentOrigin, .usesFontLeading],
                        context: nil
                    ).height
                    return columnPadding + columnHeaderHeight + 4 + columnSignHeight + 6 + textH + columnPadding
                }

                let columnsHeight = max(
                    columnHeight(impact: mercury.yourImpact),
                    columnHeight(impact: mercury.partnerImpact)
                )

                var coupleGuidanceHeight: CGFloat = 0
                if !mercury.coupleGuidance.isEmpty {
                    coupleGuidanceHeight = 24 // header gap
                    coupleGuidanceHeight += bodyHeight(for: mercury.coupleGuidance) + 6
                }

                let subtitleFont = UIFont.systemFont(ofSize: 12, weight: .light)
                let subtitleAttrs: [NSAttributedString.Key: Any] = [
                    .font: subtitleFont,
                    .foregroundColor: mutedColor
                ]
                let subtitleHeight = (L10n.mercuryCoupleSubtitle as NSString).boundingRect(
                    with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude),
                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                    attributes: subtitleAttrs,
                    context: nil
                ).height
                let subtitleSpacing: CGFloat = 4

                let mercurySectionHeight =
                    sectionHeaderHeight + subtitleHeight + subtitleSpacing +
                    boxTopPadding + badgeHeight + 12 +
                    columnsHeight + coupleGuidanceHeight + boxBottomPadding + sectionTrailingGap

                ensureRoom(for: mercurySectionHeight)

                yPosition = drawSectionHeader(
                    title: L10n.mercuryCoupleTitle,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )

                yPosition = drawText(
                    L10n.mercuryCoupleSubtitle,
                    at: CGPoint(x: margin, y: yPosition),
                    width: contentWidth,
                    font: subtitleFont,
                    color: mutedColor
                )
                yPosition += 10

                let mercuryBoxStartY = yPosition
                yPosition += boxTopPadding

                // Phase + sign badge
                let badgeFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
                let badgeAttrs: [NSAttributedString.Key: Any] = [
                    .font: badgeFont,
                    .foregroundColor: goldColor
                ]
                let badgeSize = (badgeText as NSString).size(withAttributes: badgeAttrs)
                let badgePillRect = CGRect(
                    x: margin,
                    y: yPosition,
                    width: badgeSize.width + 24,
                    height: badgeHeight
                )
                let badgePill = UIBezierPath(roundedRect: badgePillRect, cornerRadius: badgeHeight / 2)
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.12).setFill()
                badgePill.fill()
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.4).setStroke()
                badgePill.lineWidth = 1
                badgePill.stroke()
                (badgeText as NSString).draw(
                    at: CGPoint(x: margin + 12, y: yPosition + (badgeHeight - badgeSize.height) / 2),
                    withAttributes: badgeAttrs
                )
                yPosition += badgeHeight + 12

                // Side-by-side impact columns
                let columnWidth = (contentWidth - columnGap) / 2

                func drawImpactColumn(
                    rect: CGRect,
                    label: String,
                    sign: (symbol: String, name: String),
                    impact: String
                ) {
                    context.cgContext.saveGState()
                    let columnPath = UIBezierPath(roundedRect: rect, cornerRadius: 8)
                    UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.85).setFill()
                    columnPath.fill()
                    UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.25).setStroke()
                    columnPath.lineWidth = 1
                    columnPath.stroke()
                    context.cgContext.restoreGState()

                    var localY = rect.minY + columnPadding

                    let labelAttrs: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 9, weight: .semibold),
                        .foregroundColor: mutedColor,
                        .kern: 1.0
                    ]
                    (label.uppercased() as NSString).draw(
                        at: CGPoint(x: rect.minX + columnPadding, y: localY),
                        withAttributes: labelAttrs
                    )
                    localY += columnHeaderHeight

                    let signLine = "\(sign.symbol)  \(sign.name)"
                    let signAttrs: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                        .foregroundColor: goldColor
                    ]
                    (signLine as NSString).draw(
                        at: CGPoint(x: rect.minX + columnPadding, y: localY),
                        withAttributes: signAttrs
                    )
                    localY += columnSignHeight + 6

                    _ = drawText(
                        impact,
                        at: CGPoint(x: rect.minX + columnPadding, y: localY),
                        width: rect.width - columnPadding * 2,
                        font: bodyFont,
                        color: textColor
                    )
                }

                let columnRectLeft = CGRect(
                    x: margin,
                    y: yPosition,
                    width: columnWidth,
                    height: columnsHeight
                )
                let columnRectRight = CGRect(
                    x: margin + columnWidth + columnGap,
                    y: yPosition,
                    width: columnWidth,
                    height: columnsHeight
                )

                drawImpactColumn(
                    rect: columnRectLeft,
                    label: L10n.mercuryCoupleImpactYou,
                    sign: (yourSign.symbol, yourSign.name),
                    impact: mercury.yourImpact
                )
                drawImpactColumn(
                    rect: columnRectRight,
                    label: L10n.mercuryCoupleImpactPartner,
                    sign: (partnerSign.symbol, partnerSign.name),
                    impact: mercury.partnerImpact
                )

                yPosition += columnsHeight

                // Couple guidance (pair-specific)
                if !mercury.coupleGuidance.isEmpty {
                    yPosition += 12
                    yPosition = drawText(
                        L10n.mercuryCoupleAdvice,
                        at: CGPoint(x: margin, y: yPosition),
                        width: contentWidth,
                        font: .systemFont(ofSize: 13, weight: .semibold),
                        color: goldColor
                    )
                    yPosition += 6
                    yPosition = drawText(
                        mercury.coupleGuidance,
                        at: CGPoint(x: margin + 4, y: yPosition),
                        width: contentWidth - 4,
                        font: bodyFont,
                        color: textColor
                    )
                    yPosition += 4
                }

                yPosition += boxBottomPadding

                context.cgContext.saveGState()
                let mercuryBoxRect = CGRect(
                    x: margin - 10,
                    y: mercuryBoxStartY,
                    width: contentWidth + 20,
                    height: yPosition - mercuryBoxStartY
                )
                let mercuryBox = UIBezierPath(roundedRect: mercuryBoxRect, cornerRadius: 10)
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.35).setStroke()
                mercuryBox.lineWidth = 1
                mercuryBox.stroke()
                context.cgContext.restoreGState()

                yPosition += sectionTrailingGap
            }

            // Analysis sections — draw filled box first, then text on top (one draw pass).
            let sections: [(String, String)] = [
                (L10n.compatibilityOverall, overall),
                (L10n.compatibilityStrengths, strengths),
                (L10n.compatibilityChallenges, challenges),
                (L10n.compatibilityAdvice, advice)
            ]

            for (sectionTitle, sectionBody) in sections {
                let bodyH = bodyHeight(for: sectionBody)
                let requiredHeight = sectionHeaderHeight + boxTopPadding + bodyH + boxBottomPadding + sectionTrailingGap
                ensureRoom(for: requiredHeight)

                yPosition = drawSectionHeader(
                    title: sectionTitle,
                    at: yPosition,
                    margin: margin,
                    contentWidth: contentWidth,
                    context: context.cgContext
                )
                yPosition += 10

                let boxStartY = yPosition
                let boxHeight = boxTopPadding + bodyH + boxBottomPadding

                context.cgContext.saveGState()
                let sectionBoxRect = CGRect(
                    x: margin - 10,
                    y: boxStartY,
                    width: contentWidth + 20,
                    height: boxHeight
                )
                let sectionBox = UIBezierPath(roundedRect: sectionBoxRect, cornerRadius: 10)
                UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.8).setFill()
                sectionBox.fill()
                UIColor(red: 0.72, green: 0.55, blue: 0.26, alpha: 0.25).setStroke()
                sectionBox.lineWidth = 1
                sectionBox.stroke()
                context.cgContext.restoreGState()

                _ = drawText(
                    sectionBody,
                    at: CGPoint(x: margin, y: boxStartY + boxTopPadding),
                    width: contentWidth,
                    font: bodyFont,
                    color: textColor
                )

                yPosition = boxStartY + boxHeight + sectionTrailingGap
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

            yPosition += 10
            drawDecorativeBorder(at: yPosition, width: pageWidth, margin: margin, context: context.cgContext)
            yPosition += 20

            yPosition = drawText(
                L10n.pdfDownloadOnAppStore,
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
                color: goldColor
            )

            drawFooter(at: pageHeight - 40, width: pageWidth, margin: margin, pageNumber: pageNumber, context: context.cgContext)
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let filename = "Compatibility_\(yourSign.name)_\(partnerSign.name)_\(dateFormatter.string(from: date)).pdf"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            return nil
        }
    }

    private func drawSignCard(
        title: String,
        sign: ZodiacSign,
        rect: CGRect,
        goldColor: UIColor,
        textColor: UIColor,
        context: CGContext
    ) {
        context.saveGState()
        let cardBackground = UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 0.9)
        cardBackground.setFill()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 14)
        path.fill()
        goldColor.withAlphaComponent(0.4).setStroke()
        path.lineWidth = 1
        path.stroke()
        context.restoreGState()

        // Title at top
        let titleFont = UIFont.systemFont(ofSize: 11, weight: .semibold)
        let titleAttrs: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0),
            .kern: 1.2
        ]
        let titleText = title.uppercased() as NSString
        let titleSize = titleText.size(withAttributes: titleAttrs)
        titleText.draw(
            at: CGPoint(x: rect.midX - titleSize.width / 2, y: rect.minY + 14),
            withAttributes: titleAttrs
        )

        // Symbol in the middle
        let symbolFont = UIFont.systemFont(ofSize: 36, weight: .regular)
        let symbolAttrs: [NSAttributedString.Key: Any] = [.font: symbolFont]
        let symbolText = sign.symbol as NSString
        let symbolSize = symbolText.size(withAttributes: symbolAttrs)
        symbolText.draw(
            at: CGPoint(x: rect.midX - symbolSize.width / 2, y: rect.minY + 34),
            withAttributes: symbolAttrs
        )

        // Name at the bottom
        let nameFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        let nameAttrs: [NSAttributedString.Key: Any] = [
            .font: nameFont,
            .foregroundColor: goldColor
        ]
        let nameText = sign.name as NSString
        let nameSize = nameText.size(withAttributes: nameAttrs)
        nameText.draw(
            at: CGPoint(x: rect.midX - nameSize.width / 2, y: rect.maxY - 26),
            withAttributes: nameAttrs
        )
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
