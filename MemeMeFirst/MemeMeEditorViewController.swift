//
//  ViewController.swift
//  MemeMeFirst
//
//  Created by osmanjan omar on 10/20/16.
//  Copyright © 2016 osmanjan omar. All rights reserved.
//

import UIKit



class MemeMeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate{
    
    // # MARK: adding and initializing outlets for UiViews
    
    
    // outlets and initializing
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var topTextFieldOutlet: UITextField! {
        didSet {
            topTextFieldOutlet.delegate = self
        }
    }
    
    @IBOutlet weak var buttomTextFieldOutlet: UITextField! {
        didSet {
            buttomTextFieldOutlet.delegate = self
        }
    }
    
    @IBOutlet weak var toolBarOutLet: UIToolbar!
    @IBOutlet weak var cemeraButtonOutlet: UIBarButtonItem!
    
    
    // creating text field atributes
    let textFieldAtributes = [
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSForegroundColorAttributeName : UIColor.white,
        NSStrokeColorAttributeName : UIColor.black,
        NSStrokeWidthAttributeName: -3.5
        ] as [String : Any]
    
    
    //#MARK: Cancel button action
    
    // dismiss view controller and go back to tabbar controller
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuerTextfields(textField: topTextFieldOutlet, enale: false)
        self.configuerTextfields(textField: buttomTextFieldOutlet, enale: false)
    }
    
    //#MARK: configure text fields
    func configuerTextfields(textField:UITextField, enale:Bool?){
        
        textField.defaultTextAttributes = textFieldAtributes
        textField.textAlignment = NSTextAlignment.center
        textField.isEnabled = enale!
        
        // textfield place holder colors
        topTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Top", attributes: [NSForegroundColorAttributeName: UIColor.white])
        buttomTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Buttom", attributes: [NSForegroundColorAttributeName:UIColor.white])
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // camera button disabled on the devices where caemras on available
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            cemeraButtonOutlet.isEnabled = false
            
        }
        self.subscribeToKeyBoardWillShowNotification()
        self.subscribeToKeyBoardWillHideNotification()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.unsubscribeFromKeyboardWillShowNotification()
        self.unsubscribeFromKeyBoardWillHideNotification()
        
    }
    
    
    // # MARK: choose photo, take photo, share button actions, save Meme to library
    
    
    @IBAction func avtivityButton(_ sender: AnyObject) {
        
        let sharedImage = self.makeMemedImage()
        let activityVC = UIActivityViewController(activityItems: [sharedImage], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
        activityVC.completionWithItemsHandler = {
            (activityType, completed, returnedItems, activityError) in
            if completed {
                self.saveMemeObject(memeImage: sharedImage)
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    
    // choosing photo from library
    @IBAction func addPhotoFromLibrary(_ sender: AnyObject) {
        
        self.pickImageFromSource(source:UIImagePickerControllerSourceType.photoLibrary)
        
    }
    
    // take pictures with camera
    @IBAction func takePhotoWithCamera(_ sender: AnyObject) {
        
        self.pickImageFromSource(source:UIImagePickerControllerSourceType.camera)
        
    }
    
    // # MARK: implementing pickImageFromSource
    
    func pickImageFromSource(source:UIImagePickerControllerSourceType){
        
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.sourceType = source
        self.present(imagePickerVC, animated: true, completion: nil)
        
        
        
    }
    
    // # MARK: UIImagePickerViewController delegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // enabling the textfields after user choose an image
        topTextFieldOutlet.isEnabled = true
        buttomTextFieldOutlet.isEnabled = true
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            picker.allowsEditing = true
            imageViewOutlet.contentMode = .scaleAspectFit
            imageViewOutlet.image = pickedImage
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    // creating alert method for reuse
    func alert(atitle:String, amessage:String, aactionTitle:String, aactionStyle:UIAlertActionStyle)->UIAlertController{
        
        let aAlert = UIAlertController(title: atitle, message: amessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancel = UIAlertAction(title:aactionTitle, style: aactionStyle, handler: { (UIAlertAction) in})
        aAlert.addAction(cancel)
        return aAlert
        
    }
    
    
    // # MARK: hide the keyborad on tapping the screen or with return key
    
    // tap anywhere on the screen to hide the keyboard
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    // hide keyboard when pressing return key "Done"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        
        return true
    }
    
    // # MARK: moving up the view when keyborad appear
    
    // getting the keyboard height
    
    func  theKeyBoardHeight(notification:NSNotification) -> CGFloat {
        
        let information = notification.userInfo
        let keyBoardHeight = information![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyBoardHeight.cgRectValue.height
    }
    
    
    
    // subscribing the keyboardWillShowUp method
    
    func subscribeToKeyBoardWillShowNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(theKeyboardWillShowUp), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    // unsubscribe from keyboard show notification
    func unsubscribeFromKeyboardWillShowNotification(){
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // move up the buttom textfield and pull down the top textfield when keyboard show up
    func theKeyboardWillShowUp(notification:NSNotification){
        
        if buttomTextFieldOutlet.isFirstResponder{
            view.frame.origin.y -= theKeyBoardHeight(notification: notification)
        }
        
    }
    
    // # MARK: moving down the view when keyborad hide
    
    // subscribe to the UIKeyboardWillHide notification
    
    func subscribeToKeyBoardWillHideNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownTheView), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    //unsubscribe from the notification
    func unsubscribeFromKeyBoardWillHideNotification(){
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    // set the y origin to original point
    func moveDownTheView(notification:NSNotification){
        
        if buttomTextFieldOutlet.isFirstResponder{
            view.frame.origin.y += theKeyBoardHeight(notification: notification)
        }
    }
    
    //#MARK: saving Meme object with photos and texts
    
    
    func saveMemeObject(memeImage:UIImage){
        
        let Meme = MeMeme(originalImage : imageViewOutlet.image,
                          memeImage : self.makeMemedImage(),
                          topText : topTextFieldOutlet.text,
                          buttonText : buttomTextFieldOutlet.text)
        
        let object = UIApplication.shared.delegate
        let appdelegate = object as! AppDelegate
        appdelegate.Memes.append(Meme)
        
    }
    
    //#MARK: capturing the screen as image after finish editing MeMe
    
    func makeMemedImage()->UIImage{
        
        
        toolBarOutLet.isHidden = true
        
        UIGraphicsBeginImageContext(imageViewOutlet.frame.size)
        view.drawHierarchy(in: imageViewOutlet.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBarOutLet.isHidden = false
        
        
        return memedImage!
        
    }
    
    
}

