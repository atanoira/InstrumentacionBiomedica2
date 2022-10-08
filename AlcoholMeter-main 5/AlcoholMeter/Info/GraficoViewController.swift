//
//  GraficoViewController.swift
//  AlcoholMeter
//
//  Created by Lorenza Vecino on 03/12/2021.
//

import UIKit
import CoreData
import Charts

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

class GraficoViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var yAxisTitle: UILabel!
    
    var lineChart = LineChartView()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models=[AlcoholMeter]()
    
    var selectedNote: AlcoholMeter? = nil
    
    
    
    var entries1 = [ChartDataEntry]()
    var entries2 = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        
        yAxisTitle.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        
        
        // Do any additional setup after loading the view.
        
        // Data
        
        getAllItems()
        print("Número de datos:", models.count)

        let selectedDate = selectedNote?.fecha ?? Date()

        var contador = 0
        var restaMin = 0.0
        
        var x = [Double]()
        var y = [Double]()
        
//        print("Selected date:", selectedDate)
//
//        for model in models {
//
//            let date = model.fecha ?? Date()
//            let resta = date - selectedDate
//
//            print("Resta:", resta)
//
//            if abs(resta) < 12*60*60 {
//                contador = contador + 1
//
//                if contador == 1 {
//                    restaMin = resta
//                }
//
//                let t = (resta - restaMin) / (60*60)
//                let BAC = Double(model.bac ?? "0") ?? 0
//                print("Valor de t:", t)
//                x.append(t)
//                y.append(BAC)
//                entries1.append(ChartDataEntry(x: Double(t), y: Double(BAC)))
//
//            }
//
//        }
//        print("Restamin:", restaMin)
//        print("Número de entries:", x.count)
//
//        // Curva de desintoxicación - Línea de tendencia lineal y = mx + c
//        // n = numero de puntos, m = gradiente, c = ordenada, R2 = R^2
//        // m = (n*sum(x*y) - sum(x)*sum(y)) / (n*sum(x^2) - (sum(x))^2)
//        // c = (sum(y) - m*sum(x)) / n
//        // yt = m*x + c
//        // u = mean(y)
//        // R2 = 1 - sum((y-yt)^2) / sum((y-u)^2)
//
//        if x.count > 1 {
//
//            let n = Double(x.count)
//            let sumxy = zip(x, y).map(*).reduce(0, +)
//            let sumx = x.reduce(0, +)
//            let sumy = y.reduce(0, +)
//            let sumx2 = zip(x, x).map(*).reduce(0, +)
//            let m = (n*sumxy - sumx*sumy) / (n*sumx2 - pow(sumx, 2))
//            let c = (sumy - m*sumx) / n
//            let ct = Array(repeating: c, count: x.count)
//            let yt = zip(x.map {$0 * m}, ct).map(+)
//            let u = sumy / Double(y.count)
//            let ut = zip(x.map {$0 * u}, ct).map(+)
//            let sumy_yt = zip(zip(y, yt).map(+), zip(y, yt).map(+)).map(*).reduce(0, +)
//            let sumy_u = zip(zip(y, ut).map(+), zip(y, ut).map(+)).map(*).reduce(0, +)
//            let R2 = 1 - sumy_yt / sumy_u
//            print("R2:", R2)
//
//            for i in 0..<x.count {
//                entries2.append(ChartDataEntry(x: Double(x[i]), y: Double(yt[i])))
//            }
//        }
//
//    }
//
        

///CODIGO LOREN
    print("Selected date:", selectedDate)

    for model in models {

        let date = model.fecha ?? Date()
        let resta = date - selectedDate

        print("Resta:", resta)

        if abs(resta) < 12*60*60 {
            contador = contador + 1

            if contador == 1 {
                restaMin = resta
            }

            let t = (resta - restaMin) / (60*60)
            let BAC = Double(model.bac ?? "0") ?? 0
            print("Valor de t:", t)
            x.append(t)
            y.append(BAC)
            entries1.append(ChartDataEntry(x: Double(t), y: Double(BAC)))

        }

    }
    print("Restamin:", restaMin)
    print("Número de entries:", x.count)

    // Curva de desintoxicación - Línea de tendencia lineal y = mx + c
    // n = numero de puntos, m = gradiente, c = ordenada, R2 = R^2
    // m = (n*sum(x*y) - sum(x)*sum(y)) / (n*sum(x^2) - (sum(x))^2)
    // c = (sum(y) - m*sum(x)) / n
    // yt = m*x + c
    // u = mean(y)
    // R2 = 1 - sum((y-yt)^2) / sum((y-u)^2)

    if x.count > 1 {

        let n = Double(x.count)
        let sumxy = zip(x, y).map(*).reduce(0, +)
        let sumx = x.reduce(0, +)
        let sumy = y.reduce(0, +)
        let sumx2 = zip(x, x).map(*).reduce(0, +)
        let m = (n*sumxy - sumx*sumy) / (n*sumx2 - pow(sumx, 2))
        let c = (sumy - m*sumx) / n
        let ct = Array(repeating: c, count: x.count)
        let yt = zip(x.map {$0 * m}, ct).map(+)
        let u = sumy / Double(y.count)
        let ut = zip(x.map {$0 * u}, ct).map(+)
        let sumy_yt = zip(zip(y, yt).map(+), zip(y, yt).map(+)).map(*).reduce(0, +)
        let sumy_u = zip(zip(y, ut).map(+), zip(y, ut).map(+)).map(*).reduce(0, +)
        let R2 = 1 - sumy_yt / sumy_u
        print("R2:", R2)

        for i in 0..<x.count {
            entries2.append(ChartDataEntry(x: Double(x[i]), y: Double(yt[i])))
        }
    }

}


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 60, height: self.view.frame.width - 60)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        let set1 = LineChartDataSet(entries: entries1, label: "BAC")
        let set2 = LineChartDataSet(entries: entries2, label: "Línea de tendencia")

        set1.colors = ChartColorTemplates.material()
        // set.colors = ChartColorTemplates.pastel() // para variar los colores
        set1.mode = .cubicBezier         // suaviza las lineas
        set1.lineWidth = 3
        set1.setColor(.black)
        
        set2.drawCirclesEnabled = false
        set2.lineWidth = 2
        
        let data = LineChartData(dataSets: [set1, set2])
        data.setDrawValues(false)
        lineChart.data = data
        
        let yAxis = lineChart.leftAxis
        yAxis.labelPosition = .outsideChart     // .insideChart
        
        lineChart.rightAxis.enabled = false
        
        lineChart.xAxis.labelPosition = .bottom
        
        
        
    }
    
    func getAllItems(){
        do{
            models=try context.fetch(AlcoholMeter.fetchRequest())
            }
        catch{
            //error
        }
    }
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
        let hv = storyboard?.instantiateViewController(identifier: "historialView") as! HistorialViewController
        present(hv, animated: true)
    }
    
    @IBAction func botonPerfil(_ sender: Any) {
        let pv = storyboard?.instantiateViewController(identifier: "perfilView") as! PerfilViewController
        present(pv, animated: true)
    }
    
    

}
