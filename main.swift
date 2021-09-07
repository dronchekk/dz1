//
//  main.swift
//  Rachitskiy A.D. DZ1
//
//  Created by Andrey rachitsky on 07.09.2021.
//попытка сделать пулл реквест

import Foundation

//Задача нумеро уно

let firstParametr:Double = 1
let secondParametr:Double = 0
let thirdParametr:Double = -6
let discriminant = secondParametr*secondParametr - 4*firstParametr*thirdParametr
let korenPartFirst = pow(discriminant,0.5) - secondParametr
let korenPartSecond = 0 - secondParametr - pow(discriminant,0.5)
let korenPartThird = 2*firstParametr
let korenFirst = korenPartFirst/korenPartThird
let korenSecond = korenPartSecond/korenPartThird
if discriminant > 0 {
    print("V yravnenii 2 kornya")
    print("Perviy koren \(korenFirst)")
    print("Vtoroi koren \(korenSecond)")
} else if discriminant == 0 {
    print("V yravnenii 1 koren")
    print("koren \(korenFirst)")
   // print("koren \(korenSecond)") проверка на вшивость
} else {
    print("No solutions")
}

//Задача нумеро дос

let firstKatet:Double = 6
let secondKatet:Double = 8
let triangleSquare = (firstKatet*secondKatet)/2
let triangleHypotenuse = pow((firstKatet*firstKatet + secondKatet*secondKatet),0.5)
let trianglePerimeter = triangleHypotenuse + firstKatet + secondKatet
print("Ploshad treygolnika = \(triangleSquare)")
print("Gipotenuza treygolnika = \(triangleHypotenuse)")
print("Perimetr treygolnika = \(trianglePerimeter)")


//Задача нумеро трез

let summaVklada: Double = 1000
let godovoiProcent: Double = 6/100/12
let kolichestvoMecyacev: Array<Int> = [1,2,3,4,5]
var doxod = summaVklada
for _ in kolichestvoMecyacev {
    doxod = doxod + doxod * godovoiProcent
}
print("Vash doxod pocle vklada v bank na 5 let sostavit \(doxod-summaVklada)")
