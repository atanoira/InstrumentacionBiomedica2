//
//  ResultadosViewController.swift
//  AlcoholMeter
//
//  Created by Natalia De Biasio on 16/11/2021.
//

import Foundation
import UIKit
import SwiftUI
import CoreData

class ResultadosViewController: UIViewController {
    
    let userDefaults=UserDefaults()
    private var models=[AlcoholMeter]()
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var valorbrac: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var fechamedicion: UILabel!
    @IBOutlet weak var valorbac: UILabel!
    @IBOutlet weak var memoria: UILabel!
    
    

    
    
    
    @IBAction func botonInicio(_ sender: Any) {
        let iv = storyboard?.instantiateViewController(identifier: "inicioView") as! InicioViewController
        present(iv, animated: true)
    }
    
    @IBAction func botonNuevoEstudio(_ sender: Any) {
        let nev = storyboard?.instantiateViewController(identifier: "nuevoEstudioView") as! NuevoEstudioViewController
        present(nev, animated: true)
    }
    
    @IBAction func botonHistorial(_ sender: Any) {
        let hv = storyboard?.instantiateViewController(identifier: "historialView") as! HistorialViewController
        present(hv, animated: true)
    }
    
    @IBAction func botonPerfil(_ sender: Any) {
        let pv = storyboard?.instantiateViewController(identifier: "perfilView") as! PerfilViewController
        present(pv, animated: true)
    }
    func createItem(bac:String,brac:String,des:String,title:String,memoria:String,date:Date,nombre:String,nacimiento:Date,altura:String,peso:String,memoria2:String,score:String){
            let newItem=AlcoholMeter(context: context)
            newItem.bac=bac
            newItem.brac=brac
            newItem.title=title
            newItem.memoria=memoria
            newItem.des=des
            newItem.id=1
            newItem.fecha=date
        newItem.nombre=nombre
      
        newItem.nacimiento=date
        newItem.altura=altura
        newItem.peso=peso
        newItem.memoria2=memoria2
        newItem.score=score
       
            do{
                try context.save()
    
            }
            catch{
    
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let value=userDefaults.value(forKey: "memoria") as? String{
            memoria.text = value}
        if let value=userDefaults.value(forKey:"brac") as? String{
            valorbrac.text = value}
        if let value=userDefaults.value(forKey:"bac") as? String{
            valorbac.text = value}
        if let value=userDefaults.value(forKey:"des") as? String{
            des.text = value}
        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
        let vbrac = userDefaults.string(forKey: "brac") ?? "0"
        let vbac = userDefaults.string(forKey: "bac") ?? "0"
        let vmemoria = userDefaults.string(forKey: "memoria") ?? "0"
        let vdes = userDefaults.string(forKey: "des") ?? "0"
        let dates  = userDefaults.object(forKey:"fechamedicion") as? Date ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY, HH:mm:ss"
        fechamedicion.text=dateFormatter.string(from:dates ?? Date())
        let nacimiento  = userDefaults.object(forKey:"fecha") as? Date ?? Date()
        let nombre = userDefaults.string(forKey: "name") ?? "0"
        let altura = userDefaults.string(forKey: "altura") ?? "0"
        let peso = userDefaults.string(forKey: "peso") ?? "0"
        //TENGO QUE CAMBIAR ESTO
        let memoria2 = userDefaults.string(forKey: "memoria") ?? "0"
        let score = userDefaults.string(forKey: "memoria") ?? "0"

        
//        let vdes = userDefaults.string(forKey: "des"
        
        
        
        createItem(bac:vbac,brac:vbrac,des:vdes,title:"Medición",memoria:vmemoria,date:dates,nombre:nombre,nacimiento:nacimiento,altura:altura,peso:peso,memoria2:memoria2,score:score)
        
        
        
        
        
        
    }
    

    
}


