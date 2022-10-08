//
//  HistorialViewController.swift
//  AlcoholMeter
//
//  Created by Lorenza Vecino on 27/10/2021.
//

import UIKit
import CoreData

class HistorialViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    var selectedNote: AlcoholMeter? = nil
    let userDefaults=UserDefaults()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        print(indexPath.row)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY, HH:mm:ss"
        let date=model.fecha
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text=dateFormatter.string(from:date ?? Date())
        
        return cell
    }
//    func tableView(_tableView:UITableView,didSelectRowAt indexPath: IndexPath){
////        tableView.deselectRow(at: indexPath, animated: true)
////        let item=models[indexPath.row]
////        print(item)
////        print(indexPath.row)
////        userDefaults.set(item,forKey:"item")
////        userDefaults.set(indexPath.row,forKey:"indice")
//        self.performSegue(withIdentifier: "mostrar", sender: self)
//
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier=="mostrar")
//        {
//            let indexPath = tableView.indexPathForSelectedRow!
//            let noteDetail = segue.destination as? NoteViewController
//            let selectedNote : AlcoholMeter!
//            selectedNote = models[indexPath.row]
//            noteDetail!.selectedNote = selectedNote
//            tableView.deselectRow(at: indexPath, animated: true)
//
//        }
//    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            self.performSegue(withIdentifier: "mostrar", sender: self)
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if(segue.identifier == "mostrar")
            {
                let indexPath = tableView.indexPathForSelectedRow!
                
                let noteDetail = segue.destination as? NoteViewController
                let selectedNote : AlcoholMeter!
                selectedNote = models[indexPath.row]
                noteDetail!.selectedNote = selectedNote
                
                tableView.deselectRow(at: indexPath, animated: true)
                
                
            }
            
        }
    
    private var models=[AlcoholMeter]()
    
//
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            // Do any additional setup after loading the view, typically from a nib.
//        }
//
//        override func didReceiveMemoryWarning() {
//            super.didReceiveMemoryWarning()
//            // Dispose of any resources that can be recreated.
//        }
//
//        func tableView(tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
//        {
//            return 20
//        }
//
//        func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
//        {
//            let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
//            cell.textLabel.text="row#\(indexPath.row)"
//            cell.detailTextLabel.text="subtitle#\(indexPath.row)"
//
//            return cell
//        }
//
//    @IBOutlet weak var tableView: UITableView!
    
//    func setupTableView() {
//            tableview.delegate = self
//            tableview.dataSource = self
//        }
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return 0 // your number of cells here
//        }
//
//        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//            // your cell coding
//            return UITableViewCell()
//        }
//
//        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//            // cell selected code here
//        }
//
//    let tableView:UITableView={
//        let table=UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
    
    
    @IBAction func generateCSV(_ sender: Any) {
        
        print("hola")
        
        let sFileName="test.csv"
        
        //let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("todos.txt")
        
        
      // print(path.absoluteString)


        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        print(documentDirectoryPath)

        let documentURL  = URL(fileURLWithPath: documentDirectoryPath).appendingPathComponent(sFileName)

//
//        let file = "test.csv"
//        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURL = dir.appendingPathComponent(file)
        
    
        
        let output = OutputStream.toMemory()
        
        let csvWriter=CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: ",".utf16.first!)
        
       
        
        //Encabezado
        
        csvWriter?.writeField("Nombre")
        csvWriter?.writeField("Fecha_de_Nacimiento")
        csvWriter?.writeField("Altura")
        csvWriter?.writeField("Peso")
        csvWriter?.writeField("Fecha_de_medicion")
        csvWriter?.writeField("Alcohol_en_aliento_BrAC(mg/L)")
        csvWriter?.writeField("Alcohol_en_sangre_BAC(g/L)")
        csvWriter?.writeField("Tiempo_estimado_de_desintoxicación")
        csvWriter?.writeField("Resultado_de_memoria_1")
        csvWriter?.writeField("Resultado_de_memoria_2")
        csvWriter?.writeField("Score")
        csvWriter?.finishLine()
      
        _=0

        var i=0
        for _ in 0...(models.count-1) {
            
         let modelo=models[i]
            
            
                        csvWriter?.writeField(modelo.nombre)
                        
            let nacimiento = modelo.nacimiento
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "dd/MM/YY"
                        csvWriter?.writeField(dateFormatter2.string(from:nacimiento ?? Date()))
                        csvWriter?.writeField(modelo.altura)
                        csvWriter?.writeField(modelo.peso)
            let dates  = modelo.fecha
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY, HH:mm:ss"
                        csvWriter?.writeField(dateFormatter.string(from:dates ?? Date()))
            csvWriter?.writeField(modelo.brac)
                        csvWriter?.writeField(modelo.bac)
                        csvWriter?.writeField(modelo.des)
                        csvWriter?.writeField(modelo.memoria)
                        csvWriter?.writeField(modelo.memoria2)
            csvWriter?.writeField(modelo.score)
            csvWriter?.finishLine()
            
            i=i+1
        }
            
            
    
//        for(element) in models{
//
//            csvWriter?.writeField("Juana")
//            csvWriter?.writeField("martinez")
//            csvWriter?.writeField("Fecha de Nacimiento")
//            csvWriter?.writeField("Altura")
//            csvWriter?.writeField("Peso")
//            csvWriter?.writeField("Apellido")
//            csvWriter?.writeField("Fecha de medicion")
//            csvWriter?.writeField("Alcohol en aliento BrAC(mg/L")
//            csvWriter?.writeField("Alcohol en sangre BAC(g/L)")
//            csvWriter?.writeField("Tiempo estimado de desintoxicación")
//            csvWriter?.writeField("Resultado de memoria")
//            csvWriter?.finishLine()
//
//        }
        
        csvWriter?.closeStream()
        
        let buffer = (output.property(forKey: .dataWrittenToMemoryStreamKey) as? Data)!
        
        do{
            try buffer.write(to: documentURL)
//            try buffer.write(to: fileURL)
            
            print("chau")
        }
        catch{
            
        }



    }
    
    
    
    
    

    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getAllItems(){
        do{
            models=try context.fetch(AlcoholMeter.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            //error
        }
    }

//    func createItem(bac:String,brac:String){
//        let newItem=AlcoholMeter(context: context)
//        newItem.bac=bac
//        newItem.brac=brac
//        newItem.fecha=Date()
//        do{
//            try context.save()
//
//        }
//        catch{
//
//        }
//    }

    func deleteItem(item:AlcoholMeter){
        context.delete(item)
        do{
            try context.save()
            

        }
        catch{

        }

    }

//
//    @IBOutlet weak var Medicion: UILabel!
//
//
    @IBAction func botonInicio(_ sender: Any) {
        let iv = storyboard?.instantiateViewController(identifier: "inicioView") as! InicioViewController
        present(iv, animated: true)
    }
    
    @IBAction func botonNuevoEstudio(_ sender: Any) {
        let nev = storyboard?.instantiateViewController(identifier: "nuevoEstudioView") as! NuevoEstudioViewController
        present(nev, animated: true)
    }
    
    @IBAction func botonHistorial(_ sender: Any) {
    }
    
    @IBAction func botonPerfil(_ sender: Any) {
        let pv = storyboard?.instantiateViewController(identifier: "perfilView") as! PerfilViewController
        present(pv, animated: true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        getAllItems()
        tableView.delegate=self
        tableView.dataSource=self
        tableView.frame=view.bounds
        

        // Do any additional setup after loading the view.
    }
    

 

}

//extension HistorialViewController:UITableViewDelegate{
//    tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
//    print("hoal")
//    }
//}
//extension HistorialViewController:UITableViewDataSource{
//
//
//}
