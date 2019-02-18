import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet {
            updateCelsiusLabel()
        }
    }
    
    //Keeping to show example of delegates/protocols
   /* protocol UITextFieldDelegate: NSObjectProtocol {
        optional func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
        optional func textFieldDidBeginEditing(_ textField: UITextField)
        optional func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
        optional func textFieldDidEndEditing(_ textField: UITextField)
        optional func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        optional func textFieldShouldClear(_ textField: UITextField) -> Bool
        optional func textFieldShouldReturn(_ textField: UITextField) -> Bool
    }*/
    
    
    //print current text and replacement string using UITextfieldDelegate protocol
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
    //Formats text so it doesn't show more than one decimal
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()
    
    //converts fahrenheit value to C
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    //updates celsius label with converted temp
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    //once user is done entering a temp this will check and if under 25 will show alert
    func textFieldDidEndEditing(_ textField: UITextField) {
        let temp = fahrenheitValue?.value
        if let t = temp, t < 25.0 {
            let alert = UIAlertController(title: "Brrr!", message: "\(t)F is cold", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //if text is changed the labels will update
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        celsiusLabel.text = textField.text
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    //dismisses keyboard if background is tapped
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
    }
}



