//
//  AddStudentViewController.swift
//  AT_TruongNN_Realm_Student
//
//  Created by Truong Nguyen on 7/26/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
import RealmSwift
class AddStudentViewController: BaseViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderSegmented: UISegmentedControl!

    var classes: Results<Class>!
    var students: Results<Student>!
    var selectedClass: Class!
    var selectedStudent: Student!
    var isUpdated: Bool?
    var isChangedImage = false
    var imageName: String = ""
    let realm = try! Realm()

    var indexPath = NSIndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.genderSegmented.backgroundColor = UIColor.clearColor()
        self.configUI()
        self.loadDataAndUpdateUI()

        // TextField
        nameTextField.delegate = self
        nameTextField.keyboardType = .Default
        nameTextField.clearButtonMode = .WhileEditing
        nameTextField.tag = 0
        ageTextField.delegate = self
        ageTextField.keyboardType = .NumberPad
        ageTextField.clearButtonMode = .WhileEditing
        ageTextField.tag = 1

        // Load detail
        if let student = selectedStudent {
            avatarImageView.image = FileManager.instance.loadFile(student.avatarImage, typeDirectory: .DocumentDirectory)
            nameTextField.text = student.name
            ageTextField.text = String(student.age)
            print("\(student.gender)")
            switch student.gender {
            case true: genderSegmented.selectedSegmentIndex = 0
            case false: genderSegmented.selectedSegmentIndex = 1
            }
        }

        // TapGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        self.avatarImageView.addGestureRecognizer(tapGesture)
        self.avatarImageView.userInteractionEnabled = true
    }

    func configUI() {
        // Title
        if isUpdated == true {
            self.title = "Edit Student"
        } else {
            self.title = "Add Student"
        }
        self.genderSegmented.clipsToBounds = true

        // Add button
        let addButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = addButton

        // Circle
        avatarImageView.CircleImage()
    }

    func save() {
        if isUpdated == true {
            do {
                let realm = try Realm()
                try realm.write({
                    selectedStudent.name = nameTextField.text ?? ""
                    selectedStudent.age = Int(ageTextField.text!) ?? 0
                    switch genderSegmented.selectedSegmentIndex {
                    case 0: selectedStudent.gender = true
                    default: selectedStudent.gender = false
                    }
                    if self.isChangedImage {
                        selectedStudent.avatarImage = imageName
                    } else {
                    }
                })
                // self.alertWithOkButton(Strings.Message, message: Strings.SaveSuccess)
                NSNotificationCenter.defaultCenter().postNotificationName("update", object: nil, userInfo: ["indexPath": indexPath])
            } catch {
                print("Realm Have Error!!")
            }
        } else {
            let newStudent = Student()
            newStudent.id = students.count + 1
            newStudent.idClass = selectedClass.id
            newStudent.name = nameTextField.text ?? ""
            newStudent.age = Int(ageTextField.text!) ?? 0
            newStudent.avatarImage = imageName
            switch genderSegmented.selectedSegmentIndex {
            case 0: newStudent.gender = true
            default: newStudent.gender = false
            }

            do {
                let realm = try Realm()
                try realm.write({
                    selectedClass.students.append(newStudent)
                })
                // self.alertWithOkButton(Strings.Message, message: Strings.SaveSuccess)
                NSNotificationCenter.defaultCenter().postNotificationName("addNew", object: self)
            } catch {
                print("Realm Have Error!!")
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }

    func loadDataAndUpdateUI() {
        classes = realm.objects(Class)
        students = realm.objects(Student)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddStudentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK:- Picker Image

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

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]?) {
        let pickedImage: UIImage

        if let info = editingInfo, let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            pickedImage = editedImage
        } else {
            pickedImage = image
        }
        self.isChangedImage = true
        avatarImageView.image = pickedImage
        imageName = randomStringWithLength(10) as String
        FileManager.instance.saveFile(pickedImage, name: imageName, typeDirectory: .DocumentDirectory)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    override func randomStringWithLength (len: Int) -> NSString {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString: NSMutableString = NSMutableString(capacity: len)
        for _ in 0...len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return randomString
    }
}
