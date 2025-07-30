import UIKit

class RangeSliderView: UIControl {

    // Public values
    var minValue: Float = 0
    var maxValue: Float = 100
    var lowerValue: Float = 20
    var upperValue: Float = 80

    private let trackLayer = CALayer()
    private let rangeLayer = CALayer()
    private let lowerThumb = UIView()
    private let upperThumb = UIView()

    private let thumbSize: CGFloat = 30
    private let trackHeight: CGFloat = 4

    private var isLowerThumbBeingDragged = false
    private var isUpperThumbBeingDragged = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        trackLayer.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(trackLayer)

        rangeLayer.backgroundColor = UIColor.black.cgColor
        layer.addSublayer(rangeLayer)

        for thumb in [lowerThumb, upperThumb] {
            thumb.backgroundColor = .white
            thumb.layer.cornerRadius = thumbSize / 2
            thumb.layer.borderColor = UIColor.black.cgColor
            thumb.layer.borderWidth = 2
            thumb.isUserInteractionEnabled = true
            addSubview(thumb)
        }

        // Gestures
        lowerThumb.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleLowerPan)))
        upperThumb.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleUpperPan)))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        trackLayer.frame = CGRect(x: thumbSize / 2, y: bounds.height / 2 - trackHeight / 2, width: bounds.width - thumbSize, height: trackHeight)
        updateThumbPositions()
    }

    private func positionForValue(_ value: Float) -> CGFloat {
        let width = bounds.width - thumbSize
        return CGFloat((value - minValue) / (maxValue - minValue)) * width + thumbSize / 2
    }

    private func updateThumbPositions() {
        let lowerX = positionForValue(lowerValue)
        let upperX = positionForValue(upperValue)

        lowerThumb.frame = CGRect(x: lowerX - thumbSize / 2, y: bounds.midY - thumbSize / 2, width: thumbSize, height: thumbSize)
        upperThumb.frame = CGRect(x: upperX - thumbSize / 2, y: bounds.midY - thumbSize / 2, width: thumbSize, height: thumbSize)

        let rangeX = lowerThumb.center.x
        let rangeWidth = upperThumb.center.x - lowerThumb.center.x
        rangeLayer.frame = CGRect(x: rangeX, y: bounds.midY - trackHeight / 2, width: rangeWidth, height: trackHeight)
    }

    @objc private func handleLowerPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        gesture.setTranslation(.zero, in: self)

        let width = bounds.width - thumbSize
        let deltaValue = Float(translation.x / width) * (maxValue - minValue)
        let newValue = lowerValue + deltaValue

        if newValue < minValue { return }
        if newValue > upperValue { return } // ⛔ prevent passing upper

        lowerValue = min(max(minValue, newValue), upperValue)
        updateThumbPositions()
        sendActions(for: .valueChanged)
    }

    @objc private func handleUpperPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        gesture.setTranslation(.zero, in: self)

        let width = bounds.width - thumbSize
        let deltaValue = Float(translation.x / width) * (maxValue - minValue)
        let newValue = upperValue + deltaValue

        if newValue > maxValue { return }
        if newValue < lowerValue { return } // ⛔ prevent passing lower

        upperValue = max(min(maxValue, newValue), lowerValue)
        updateThumbPositions()
        sendActions(for: .valueChanged)
    }
}
