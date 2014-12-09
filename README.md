FormValidationKit
=================

FormValidationKit
A form validation framework.

Apart from the built in validation rules you can create your own validation rules by implementing the FieldValidator protocol. 

Before you could use it you need to build for either an iOS device or simulator. You can read about a detailed tutorial on how to build frameworks here: http://locomoviles.com/ios-tutorials/create-ios-cocoa-touch-framework-using-xcode/

You can download the demo project here: http://locomoviles.com/download/formvalidationkit-demo/

Example implementation:
```swift
import UIKit
import FormValidationKit

class ViewController: UIViewController, FormValidationDelegate, FieldValidatorDelegate {
    
    var formValidator: FormValidator?
    var usernameValidator : FieldValidator?
    var emailValidator : FieldValidator?
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!

    @IBAction func didTapButton(sender: AnyObject) {
        
        formValidator?.submit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize the form validator
        formValidator = FormValidator()
        
        //Create field validators
        //Set nil to first field validator
        usernameValidator = FieldValidator(rules: [Required(validationError: ValidationError(hint: "Field is required"))], addValidator: nil, form: formValidator!, inputValue: { () -> AnyObject in
            return self.usernameTf.text
        })
        usernameValidator!.delegate = self
        
        emailValidator = FieldValidator(rules: [Email(validationError: ValidationError(hint: "Proper email format")), Required(validationError: ValidationError(hint: "Field is required"))], addValidator: usernameValidator!, form: formValidator!, inputValue: { () -> AnyObject in
            return self.emailTf.text
        })
        emailValidator!.delegate = self
        
        formValidator?.initialValidator = emailValidator!
        formValidator?.delegate = self
    }

    //per field error delegate method
    func didEvaluateField(field: FieldValidator, errors: Array<String>, form: FormValidator) {
        switch field {
        case usernameValidator!:
            if errors.count > 0 {
                println("Username field error")
                errorString += "Username field error \n"
            }
            break;
        case emailValidator!:
            if errors.count > 0 {
                println("Email field error")
                errorString += "Email field error \n"
            }
        default:
            println("Field error")
        }
    }
    
    //form delegate methods
    func didPassFormValidation(form: FormValidation) {
        println(__FUNCTION__)
        errorLabel.text = ""
    }
    
    func didFailFormValidation(form: FormValidation) {
        errorLabel.text = errorString
    }
}
```
