//
//  MainViewController.swift
//  IDK1.0
//
//  Created by Danny Walker on 11/8/20.
//

import UIKit

class MainViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var typeTxt: UITextField!
    @IBOutlet weak var appTxt: UITextField!
    @IBOutlet weak var din1Txt: UITextField!
    @IBOutlet weak var din2Txt: UITextField!
    @IBOutlet weak var din3Txt: UITextField!
    @IBOutlet weak var bevTxt: UITextField!    
    @IBOutlet weak var pickerView: UIPickerView!
        
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)        
    }
    
    //For these 'EditingDidBegin' actions, pass text field value to a commonly shared function for setting up the view picker.
    @IBAction func typTxtEditingDidBegin(_ sender: UITextField) {
        textFieldDidBeginEditing(typeTxt)
    }
    
    @IBAction func appTxtEditingDidBegin(_ sender: UITextField) {
        if appList.count > 0 {            
            textFieldDidBeginEditing(appTxt)
        }
        else {
            editNotAllowed()
        }
    }
    
    @IBAction func din1TxtEditingDidBegin(_ sender: UITextField) {
        if din1List.count > 0 {
            textFieldDidBeginEditing(din1Txt)
        }
        else {
            editNotAllowed()
        }
    }
    
    @IBAction func din2TxtEditingDidBegin(_ sender: UITextField) {
        if din2List.count > 0 {
            textFieldDidBeginEditing(din2Txt)
        }
        else {
            editNotAllowed()
        }
    }
    
    @IBAction func din3TxtEditingDidBegin(_ sender: UITextField) {
        if din3List.count > 0 {
            textFieldDidBeginEditing(din3Txt)
        }
        else {
            editNotAllowed()
        }
    }
    
    @IBAction func bevTxtEditingDidBegin(_ sender: UITextField) {
        if bevList.count > 0 {
            textFieldDidBeginEditing(bevTxt)
        }
        else {
            editNotAllowed()
        }
    }
       
    //Update content for appetizer, dinner, and beverage lists when food type changes (functions typeTxtValueChanged and typeTxtEditingDidEnd)
      
    @IBAction func typeTxtEditingDidEnd(_ sender: Any) {
        evaluateFromTypeInput()
    }
     
    @IBAction func chooseAllSpinBtn(_ sender: UIButton) {
        pickerView.isHidden = true
        randomSelect(textField: typeTxt, array: typeList)
        evaluateFromTypeInput()
        randomSelect(textField: appTxt, array: appList)
        randomSelect(textField: din1Txt, array: din1List)
        randomSelect(textField: din2Txt, array: din2List)
        randomSelect(textField: din3Txt, array: din3List)
        randomSelect(textField: bevTxt, array: bevList)
    }
    
    @IBAction func typeSpinBtn(_ sender: UIButton) {
        pickerView.isHidden = true
        randomSelect(textField: typeTxt, array: typeList)
        evaluateFromTypeInput()
    }
    
    @IBAction func appSpinBtn(_ sender: UIButton) {
        pickerView.isHidden = true
        randomSelect(textField: appTxt, array: appList)
    }
    
    @IBAction func din1SpinBtn(_ sender: UIButton) {
        pickerView.isHidden = true
        randomSelect(textField: din1Txt, array: din1List)
    }
   
    @IBAction func din2SpinBtn(_ sender: UIButton) {
        pickerView.isHidden = true
        randomSelect(textField: din2Txt, array: din2List)
    }
    
    @IBAction func din3SpinBtn(_ sender: UIButton) {
        pickerView.isHidden = true
        randomSelect(textField: din3Txt, array: din3List)
    }
    
    @IBAction func bevSpinBtn(_ sender: UIButton) {
        pickerView.isHidden = true
        randomSelect(textField: bevTxt, array: bevList)
    }
    
    //Declare arrays for lists of appetizers, dinners, beverages
    let appChn = ["Crab Rangoon", "Dumplings", "Egg Rolls", "Egg Drop Soup", "Pot Stickers"]
    let dinChn = ["Chow Mein", "Roast Duck", "Sichuan Pork", "Sweet Sour Pork", "Triple Wonder"]
    let bevChn = ["Green Tea", "Osmanthus Wine", "Red Wine", "Rice Wine", "White Tea"]
    let appItl = ["Antipasto", "Arugula Salad", "Bruschetta", "Chopped Salad", "Croquettes"]
    let dinItl = ["Calzones", "Chicken Marsala", "Chicken Parm", "Pasta Puttanesca", "Pizza"]
    let bevItl = ["Arneis", "Bellini", "Chianti", "Nerello Mascalese", "Prosecco"]
    let appJpn = ["Calamari", "Kani", "Miso Soup", "Scallops", "Sushi"]
    let dinJpn = ["Hibachi Steak", "Sea Bass", "Sesame Chicken", "Tilapia", "Tuna Steak"]
    let bevJpn = ["Agari (Tea)", "Matcha (Tea)", "Plum Wine", "Sake", "Soda"]
    let appMex = ["Chips n' Guac", "Nachos Supreme", "Quesadilla", "Taquitos", "Tostadas"]
    let dinMex = ["Burritos", "Enchiladas", "Fajitas", "Fish Tacos", "Tacos"]
    let bevMex = ["Cerveza", "Jarritos", "Margarita", "Paloma", "Sangria"]
    let appPub = ["Chips", "Fried Pickles", "Pretzels", "Sliders", "Wings"]
    let dinPub = ["Beef Sandwich", "Chili", "Fish n' Chips", "Steak", "Stew"]
    let bevPub = ["Beer", "Cocktail", "Cola", "Water", "Wine"]
    let appSfd = ["Crab Cakes", "Oysters", "Scallops", "Shrimp Cocktail", "Shrimp Salad", ]
    let dinSfd = ["Ahi Tuna", "Catfish", "Grilled Salmon", "Lobster Tail", "Mahi-mahi"]
    let bevSfd = ["Bloody Mary", "Chardonnay", "Margarita", "Pinot Grigio", "Riesling"]
    
    //The text field currently using the picker view.
    var currentTextField = UITextField()
    
    //Arrays to display food type, appetizers, dinners, beverages.  Content load will be decided in the viewDidLoad function.
    var typeList:[String] = []
    var appList:[String] = []
    var din1List:[String] = []
    var din2List:[String] = []
    var din3List:[String] = []
    var bevList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.isHidden = true

        // Do any additional setup after loading the view.
        //Determine content of lists in view picker based on text field.
        typeList = ["Chinese", "Italian", "Japanese", "Mexican", "Pub", "Seafood"]
    }
    
    //We just need one wheel in the picker view.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Determine number of rows depending on the text field currently selected and the list currently loaded into that field.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == typeTxt {
            return typeList.count
        }
        else if currentTextField == appTxt {
            return appList.count
        }
        else if currentTextField == din1Txt {
            return din1List.count
        }
        else if currentTextField == din2Txt {
            return din2List.count
        }
        else if currentTextField == din3Txt {
            return din3List.count
        }
        else if currentTextField == bevTxt {
            return bevList.count
        }
        else {
            return 0
        }
    }
    
    //Determine what lists appear in the picker.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == typeTxt {
            return typeList[row]
        }
        else if currentTextField == appTxt {
            return appList[row]
        }
        else if currentTextField == din1Txt {
            return din1List[row]
        }
        else if currentTextField == din2Txt {
            return din2List[row]
        }
        else if currentTextField == din3Txt {
            return din3List[row]
        }
        else if currentTextField == bevTxt {
            return bevList[row]
        }
        else {
            return ""
        }
    }
    
    //Determine what items fill the text field after a selection from a list.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == typeTxt {
            typeTxt.text = typeList[row]
            self.view.endEditing(true)
            pickerView.isHidden = true
        }
        else if currentTextField == appTxt {
            appTxt.text = appList[row]
            self.view.endEditing(true)
            pickerView.isHidden = true
        }
        else if currentTextField == din1Txt {
            din1Txt.text = din1List[row]
            self.view.endEditing(true)
            pickerView.isHidden = true
        }
        else if currentTextField == din2Txt {
            din2Txt.text = din2List[row]
            self.view.endEditing(true)
            pickerView.isHidden = true
        }
        else if currentTextField == din3Txt {
            din3Txt.text = din3List[row]
            self.view.endEditing(true)
            pickerView.isHidden = true
        }
        else if currentTextField == bevTxt {
            bevTxt.text = bevList[row]
            self.view.endEditing(true)
            pickerView.isHidden = true
        }
    }
    
    //We're using the same picker view for all the text fields.  So we need to assign that picker view to each text field.
    private func textFieldDidBeginEditing(_ textField: UITextField) {
        //We're not using the keyboard.  Hide the cursor.
        textField.tintColor = UIColor.clear
        //Make sure all contents for picker view are updated.
        pickerView.reloadAllComponents()
        //Reveal picker when a textfield is entered.
        pickerView.isHidden = false
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == typeTxt {
            currentTextField.inputView = pickerView
        }
        else if currentTextField == appTxt {
            currentTextField.inputView = pickerView
        }
        else if currentTextField == din1Txt {
            currentTextField.inputView = pickerView
        }
        else if currentTextField == din2Txt {
            currentTextField.inputView = pickerView
        }
        else if currentTextField == din3Txt {
            currentTextField.inputView = pickerView
        }
        else if currentTextField == bevTxt {
            currentTextField.inputView = pickerView
        }
    }
    
    private func evaluateFromTypeInput() {
        //Determine content of other lists based on what was selected for food type
        if typeTxt.text == "Chinese" {
            appList = appChn
            din1List = dinChn
            din2List = dinChn
            din3List = dinChn
            bevList = bevChn
        }
        else if typeTxt.text == "Italian" {
            appList = appItl
            din1List = dinItl
            din2List = dinItl
            din3List = dinItl
            bevList = bevItl
        }
        else if typeTxt.text == "Japanese" {
            appList = appJpn
            din1List = dinJpn
            din2List = dinJpn
            din3List = dinJpn
            bevList = bevJpn
        }
        else if typeTxt.text == "Mexican" {
            appList = appMex
            din1List = dinMex
            din2List = dinMex
            din3List = dinMex
            bevList = bevMex
        }
        else if typeTxt.text == "Pub" {
            appList = appPub
            din1List = dinPub
            din2List = dinPub
            din3List = dinPub
            bevList = bevPub
        }
        else if typeTxt.text == "Seafood" {
            appList = appSfd
            din1List = dinSfd
            din2List = dinSfd
            din3List = dinSfd
            bevList = bevSfd
        }
        //Clear text fields for appetizer, dinners, beverage.
        appTxt.text = ""
        din1Txt.text = ""
        din2Txt.text = ""
        din3Txt.text = ""
        bevTxt.text = ""
    }
    
    //Choices for appetizer, dinners, beverage are passed.  A choice is selected and displayed in the appropriate text field.
    private func randomSelect(textField:UITextField,array:[String]) {
        let randomType = array.randomElement()
        textField.text = randomType
    }
    
    private func editNotAllowed() {
        appTxt.endEditing(true)
        din1Txt.endEditing(true)
        din2Txt.endEditing(true)
        din3Txt.endEditing(true)
        bevTxt.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
