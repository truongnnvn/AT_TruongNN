//
//  SignupAndLoginVC.swift
//  AT-NNTApp
//
//  Created by AsianTech on 7/11/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

private extension Selector {
    static let keyboardWillShow = #selector(SignupAndLoginVC.keyboardWillShow(_:))
    static let keyboardWillHide = #selector(SignupAndLoginVC.keyboardWillHide(_:))
    static let selectImage = #selector(SignupAndLoginVC.selectImage)
}

class SignupAndLoginVC: BaseViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet private weak var topBackgroundImageView: UIImageView!
    @IBOutlet private weak var emailSigninTextField: UITextField!
    @IBOutlet private weak var passwordSigninTextField: UITextField!
    @IBOutlet private weak var signupView: UIView!
    @IBOutlet private weak var signUpSubView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var usernameSignupTextField: UITextField!
    @IBOutlet private weak var passwordSignupTextField: UITextField!
    @IBOutlet private weak var emailSignupTextField: UITextField!
    @IBOutlet private weak var enterLoginButton: UIButton!
    @IBOutlet private weak var enterSignupButton: UIButton!

    @IBOutlet private weak var topConstraintImageView: NSLayoutConstraint!
    @IBOutlet private weak var bottomConstraintOfTwitterButton: NSLayoutConstraint!
    
    private var isSignup = false
    private var activeTextField = UITextField()
    private var imageURL:NSURL?
    private var randomStringForAvatarImage = ""
    var notesArray:NSMutableArray!
    var plistPath:String!
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromPList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //If screen is iPhone 4
        if UIScreen.mainScreen().bounds.height == 480 {
            bottomConstraintOfTwitterButton.constant = 10
            topConstraintImageView.constant = -100
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func configurationUI() {
        
        // Textfield delegate
        emailSigninTextField.delegate = self
        passwordSigninTextField.delegate = self
        usernameSignupTextField.delegate = self
        passwordSignupTextField.delegate = self
        emailSignupTextField.delegate = self
        hideKeyboardWhenTappedAround()
        
        //Textfield properties
        //Signin
        emailSigninTextField.keyboardType = .EmailAddress
        emailSigninTextField.returnKeyType = .Next
        passwordSigninTextField.secureTextEntry = true
        passwordSigninTextField.returnKeyType = .Done
        //Signup
        usernameSignupTextField.keyboardType = .Default
        usernameSignupTextField.returnKeyType = .Next
        passwordSignupTextField.keyboardType = .Default
        passwordSignupTextField.returnKeyType = .Next
        passwordSignupTextField.secureTextEntry = true
        emailSignupTextField.keyboardType = .EmailAddress
        emailSignupTextField.returnKeyType = .Done
        
        
        // Keyboard Notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardWillShow, name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardWillHide, name:UIKeyboardWillHideNotification, object: self.view.window)
        
        //TapGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: .selectImage)
        avatarImageView.addGestureRecognizer(tapGesture)
        avatarImageView.userInteractionEnabled = true
        
        //Circle image
        avatarImageView.CircleImage()        
    }
    
    //MẢK:- Load Data
    override func loadData() {

    }
    
    //MARK:- IBAction
    
    @IBAction func actionChangeSignupView(sender: AnyObject) {
        topBackgroundImageView.image = UIImage(named: Strings.Signup)
        signupView.hidden = false
        isSignup = true
    }

    @IBAction func actionChangeLoginView(sender: AnyObject) {
        topBackgroundImageView.image = UIImage(named: Strings.Login)
        signupView.hidden = true
        isSignup = false
    }
    
    @IBAction func actionSignupButton(sender: AnyObject) {
        let username = usernameSignupTextField.text ?? ""
        let password = passwordSignupTextField.text ?? ""
        let email = emailSignupTextField.text ?? ""
        let image = String(imageURL)
        
        if validateSignupFlow(username, email: email, password: password) {
            if let user:User = User(username: username, password: password, email: email, imageURL: image) {
                saveDataIntoPList(user.getDictionary())
                self.alertWithOkButton(Strings.Message, message: Strings.SignupSuccessfully)
            } else {
                self.alertWithOkButton(Strings.Message, message: Strings.SignupFailed)
            }
        } else {
            alertWithOkButton(Strings.Message, message: Strings.SignupFailed)
        }
    }

    @IBAction func actionLogin(sender: AnyObject) {

//        let email = emailSigninTextField.text ?? ""
//        let password = passwordSigninTextField.text ?? ""

//        if validateLoginFlow(email, password: password) {
//            for user in users {
//                if email == user.email && password == user.password {
                              AppDelegate.sharedInstance.changeRootWhenLoginSuccess()
//                    alertWithOkButton(Strings.Message, message: Strings.LoginSuccessfully)
 //               } else {
//                    alertWithOkButton(Strings.Message, message: Strings.UsernamePasswordNotMatch)
//                }
//            }
//        }
    }
    
    //MARK:- Get, Save data Plist
    
    func getDataFromPList() {
        let path = NSBundle.mainBundle().pathForResource("Users", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)
        
        for user in dataArray! {
            
            let imageURL = user.objectForKey("imageURL") as! String
            let username = user.objectForKey("username") as! String
            let password = user.objectForKey("password") as! String
            let email = user.objectForKey("email") as! String
            
            let dataUser = User(username: username, password: password, email: email, imageURL: imageURL)
            users.append(dataUser)
        }
    }
  
    func saveDataIntoPList(user: Dictionary<String, String>) {
        let path = NSBundle.mainBundle().pathForResource("Users", ofType: "plist")
        let dataArray = NSMutableArray(contentsOfFile: path!)
        dataArray?.addObject(user)
        dataArray?.writeToFile(path!, atomically: false)
    }

    //MARK:- Picker Image
    
    @objc internal func selectImage() {
        hideKeyboardWhenTappedAround()
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cameraButton = UIAlertAction(title: Strings.TakeAPhoto, style: .Default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        let libraryButton = UIAlertAction(title: Strings.CameraRoll, style: .Default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                imagePicker.allowsEditing = true
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertVC.addAction(cameraButton)
        alertVC.addAction(libraryButton)
        alertVC.addAction(cancelButton)
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let pickedImage:UIImage
        
        if let info = editingInfo, let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            pickedImage = editedImage
        } else {
            pickedImage = image
        }
        avatarImageView.image = pickedImage
        randomStringForAvatarImage = randomStringWithLength(5) as String
        let fileManager = NSFileManager.defaultManager()
        let rootPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let filePath = "\(rootPath)/\(randomStringForAvatarImage).jpg"
        let savedImage = compressForUpload(pickedImage, withHeightLimit: 500, andWidthLimit: 500)
        let imageData = UIImageJPEGRepresentation(savedImage, 1.0)
        fileManager.createFileAtPath(filePath, contents: imageData, attributes: nil)
        
        if (fileManager.fileExistsAtPath(filePath)) {
            imageURL = NSURL.init(fileURLWithPath: filePath)
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK:- Show hide keyboard
    private func adjustingHeight(show: Bool,notification: NSNotification) {
        
        var userinfo = notification.userInfo!
        
        let keyboardFrame: CGRect = (userinfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let animationDuration = userinfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let screenFrame = UIScreen.mainScreen().bounds
        let ySubView = self.signUpSubView.frame.origin.y + self.signupView.frame.origin.y
        var value: CGFloat = 0
        
        if isSignup {
            value = screenFrame.height - ((activeTextField.superview!.frame.origin.y + activeTextField.frame.origin.y + activeTextField.bounds.size.height) + ySubView) - self.view.frame.origin.y
        } else {
            value = screenFrame.height - (activeTextField.superview!.frame.origin.y + activeTextField.frame.origin.y + activeTextField.bounds.size.height) - self.view.frame.origin.y
        }
        let changeInHeight = (CGRectGetHeight(keyboardFrame) - value) * (show ? -1 : 1)
        
        if value < CGRectGetHeight(keyboardFrame) && show  || self.view.frame.origin.y < 0 && !show {
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.view.frame.origin.y += changeInHeight
            })
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        adjustingHeight(true,notification: notification)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        adjustingHeight(false,notification: notification)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        //Remove notofication after user
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }

    //MARK:- Textfield should return
    @objc internal func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag
        // Try to find next responder
        if nextTag != 1 && nextTag != 4 {
            if let nextTextField = self.view.viewWithTag(nextTag + 1) as? UITextField {
                nextTextField.becomeFirstResponder()
            }
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            self.view.frame.origin.y = 0
        }
        return false // We do not want UITextField to insert line-breaks.
    }
    
    @objc internal func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        activeTextField = textField
        return true
    }
}


