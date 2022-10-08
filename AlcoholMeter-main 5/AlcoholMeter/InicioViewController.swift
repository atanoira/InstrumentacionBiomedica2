//
//  InicioViewController.swift
//  AlcoholMeter
//
//  Created by Lorenza Vecino on 13/10/2021.
//

import UIKit
import SwiftUI
import UserNotifications

class InicioViewController: UIViewController {
    
    


    @IBAction func botonInicio(_ sender: Any) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Notificación de AlcoholMeter"
        content.body = "Es hora de realizar la mediciones de alcohol y memoria!"
        
        let date = Date().addingTimeInterval(10)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) {(error) in}
        
        
    }

    
}





