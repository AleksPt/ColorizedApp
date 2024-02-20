import UIKit

final class SetColorViewController: UIViewController {

    @IBOutlet weak var colorizedView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    weak var delegate: SetColorViewControllerDelegate?
    
    override func viewDidLoad() {
        redSlider.value = Float.random(in: 0...1)
        greenSlider.value = Float.random(in: 0...1)
        blueSlider.value = Float.random(in: 0...1)
        
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
        
        setupColorView(
            red: redSlider.value,
            green: greenSlider.value,
            blue: blueSlider.value
        )
    }
    
    @IBAction private func sliderActions(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redValueLabel.text = string(from: sender)
            setupColorView(
                red: redSlider.value,
                green: greenSlider.value,
                blue: blueSlider.value
            )
        case 1:
            greenValueLabel.text = string(from: sender)
            setupColorView(
                red: redSlider.value,
                green: greenSlider.value,
                blue: blueSlider.value
            )
        default:
            blueValueLabel.text = string(from: sender)
            setupColorView(
                red: redSlider.value,
                green: greenSlider.value,
                blue: blueSlider.value
            )
        }
    }
    
    @IBAction func doneButton() {
        delegate?.setBackgroundColor(colorizedView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    
    private func setupColorView(red: Float, green: Float, blue: Float) {
        colorizedView.backgroundColor = UIColor(
            red: red.cgFloat(),
            green: green.cgFloat(),
            blue: blue.cgFloat(),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
}
