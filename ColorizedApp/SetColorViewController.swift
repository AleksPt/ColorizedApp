import UIKit

final class SetColorViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var colorizedView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redColorTextField: UITextField!
    @IBOutlet weak var greenColorTextField: UITextField!
    @IBOutlet weak var blueColorTextField: UITextField!
    
    // MARK: - Public Properties
    weak var delegate: SetColorViewControllerDelegate?
    
    var colorViewController: UIColor?
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        
        redSlider.value = Float(colorViewController?.rgba.red ?? 1)
        greenSlider.value = Float(colorViewController?.rgba.green ?? 1)
        blueSlider.value = Float(colorViewController?.rgba.blue ?? 1)
        
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
        
        redColorTextField.text = redValueLabel.text
        greenColorTextField.text = greenValueLabel.text
        blueColorTextField.text = blueValueLabel.text
                
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
        
        createToolbar()
        setupColorView()
    }
    
    // MARK: - Overrides Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction private func sliderActions(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redColorTextField.text = string(from: sender)
            redValueLabel.text = string(from: sender)
            setupColorView()
        case 1:
            greenColorTextField.text = string(from: sender)
            greenValueLabel.text = string(from: sender)
            setupColorView()
        default:
            blueColorTextField.text = string(from: sender)
            blueValueLabel.text = string(from: sender)
            setupColorView()
        }
    }
    
    @IBAction func doneButton() {
        delegate?.setBackgroundColor(
            UIColor(
                red: redSlider.value.cgFloat(),
                green: greenSlider.value.cgFloat(),
                blue: blueSlider.value.cgFloat(),
                alpha: 1
            )
        )
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func setupColorView() {
        colorizedView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func string(from value: Float) -> String {
        String(format: "%.2f", value)
    }
    
}

// MARK: - Convert Float to CGFloat
extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
}

// MARK: - Create toolbar
extension SetColorViewController {
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(dismissKeyboard)
        )
                
        toolbar.setItems([flexButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        redColorTextField.inputAccessoryView = toolbar
        greenColorTextField.inputAccessoryView = toolbar
        blueColorTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension SetColorViewController: UISearchTextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldValue = Float(textField.text ?? ""), 
        0...1 ~= textFieldValue else {
            showAlert(withMessage: "Введите цифры от 0 до 1") {
                textField.text = ""
                textField.becomeFirstResponder()
            }
            return
        }
        
        switch textField {
        case redColorTextField:
            redValueLabel.text = string(from: textFieldValue)
            redSlider.value = textFieldValue
            setupColorView()
        case greenColorTextField:
            greenValueLabel.text = string(from: textFieldValue)
            greenSlider.value = textFieldValue
            setupColorView()
        case blueColorTextField:
            blueValueLabel.text = string(from: textFieldValue)
            blueSlider.value = textFieldValue
            setupColorView()
        default: break
        }
    }
}

// MARK: - Create Alert
extension SetColorViewController {
    func showAlert(withMessage: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: nil,
            message: withMessage,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default) { _ in
                completion?()
            }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Extract components from UIColor
extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
