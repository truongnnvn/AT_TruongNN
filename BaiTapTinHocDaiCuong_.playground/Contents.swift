//: Playground - noun: a place where people can play

import UIKit
////--------------Tinh toan cac bieu thuc--------
//1.
let pi = M_PI
let g = 9.18

func hinhcau(R: Double) -> (dientich: Double, thetich: Double) {
    let dientich = 4 * pi * R * R
    let thetich = (4 * pi * R * R * R) / 3
    return(dientich, thetich)
}
let s = hinhcau(2)
print("dien tich:= \(s.dientich), the tich = \(s.thetich)")


//2.
func hamF(x: Double, y: Double) -> (F1: Double, F2: Double) {
    let F1 = (log(abs(x * x - y * y))/log(5) + atan(x + y)) / (exp(x) + cos(x + y))
    let F2 = (pow(5, x) + log((abs(x - y)) / log(5))) / (1 + atan(x + y))
    return(F1, F2)
}
let f = hamF( 1, y: 2)
print("ham f1 = \(f.F1), ham f2 = \(f.F2)")

//4.
func chukydaodong(t: Double, l: Double) -> Double {
    return 2 * pi * sqrt(l / g)
}
var l = 1.0
if l < 0 {
    print("khong tinh duoc")
} else {
    print("chu ky con lac la: = \(chukydaodong(1, l: l))")
}

//5.
func dientichtamgiac(a: Double, b: Double, c: Double) -> Double {
    let p = (a + b + c) / 2
    let s = sqrt(p * (p - a) * (p - b) * (p - c))
    return s
}
print("Dien tich tam giac la: = \(dientichtamgiac(2, b: 3, c: 2))")

//6.
func F6(x: Double) -> Double {
    let s = (9 * x * x + 15) / (7 * sqrt(x * x))
    return s
}
print("Ket qua S: = \(2)")

//7. 
func Cos(x: Double) -> Double {
    let s = cos(x) * cos(x)
    return s
}
print("Ket qua la: = \(Cos(2))")

//8.
func F8(x: Double) -> Double {
    let s = x * x - sin(x)
    return s
}
print("Ket qua la: = \(F8(2))")

//9.
func F9(x: Double) -> Double {
    let s = 1 - log(x * x)
    return s
}
print("Ket qua la: = \(F9(2))")

//10.
func ch(x: Double) -> Double {
    let chx = (exp(x) + 1 / exp(x)) / 2
    return chx
}
print("Ket qua la: = \(ch(2))")

//11.

func sh(x: Double) -> Double {
    let shx = (exp(x) - 1 / exp(x)) / 2
    return shx
}
print("Ket qua la: = \(sh(2))")

//----Phan 2----Lenh dieu kien
//1.
func hephuongtrinh(a: Double, b: Double, c: Double, d: Double, e: Double, f: Double) {
    let dinhthuc = a * e - d * b
    let dx = c * e - f * b
    let dy = a * f - d * c
    
    if dinhthuc != 0 {
        print("x: = \(dx / dinhthuc); y: = \(dy / dinhthuc)")
    } else {
        if dx != 0 || dy != 0 {
            print("He phuong trinh vo nghiem")
        } else {
            print("He phuong trinh vo dinh")
        }
    }
}

//2.
func ptb2(a: Double, b: Double, c: Double) -> (x1: Double, x2: Double, message: String) {
    let delta = b * b - 4 * a * c
    var x1:Double = 0
    var x2:Double = 0
    var message:String = ""
    if delta < 0 {
        message = "phuong trinh vo nghiem"
    } else {
        if delta == 0 {
            message = "Phuong trinh co nghiem duy nhat x1 = x2 = \(-b / (2 * a))"
        } else {
            x1 = (-b + sqrt(delta)) / (2 * a)
            x2 = (-b - sqrt(delta)) / (2 * a)
            message = "phuong trinh co 2 nghiem x1 = \(x1), x2 = \(x2)"
        }
    }
    return(x1, x2: x2, message: message)
}
let pt = ptb2(1, b: 2, c: 1)
print("x1 = \(pt.x1), x2 = \(pt.x2), message = \(pt.message)")

//3.
func bptb2(a: Double, b: Double, c: Double) -> (x1: Double, x2: Double, message: String) {
    let delta = b * b - 4 * a * c
    var x1:Double = 0
    var x2:Double = 0
    var message:String = ""
    if a == 0 && b == 0 && c == 0 {
        message = "Xin loi ban nhap lai cac he so a, b, c nhe"
    } else {
        if a == 0 {
            if b == 0 {
                message = "khong phai bat phuong trinh, nhap lai"
            } else {
                if b != 0 {
                    message = "nghiem cua bat phuong trinh: \(-c / b)"
                }
            }
        } else {
            if a > 0 {
                if delta <= 0 {
                    message = "Bat phuong trinh dung voi moi x"
                } else {
                    x1 = (-b + sqrt(delta)) / (2 * a)
                    x2 = (-b - sqrt(delta)) / (2 * a)
                    message = "nghiem cua bat phuong trinh x < \(x1)or x > \(x2)"
                }
            } else {
                if delta <= 0 {
                    message = "bat phuong trinh vo nghiem"
                } else {
                    x1 = (-b + sqrt(delta)) / (2 * a)
                    x2 = (-b - sqrt(delta)) / (2 * a)
                    message = "nghiem cua bat phuong trinh \(x1) < x < \(x2)"
                }
            }
        }
    }
    return(x1, x2, message)
}
let bpt = bptb2(1, b: 2, c: 1)
print("x1 = \(bpt.x1), x2 = \(bpt.x2), message = \(bpt.message)")

//4.
func an(a: Double, n: Double) -> (ketqua: Double, message: String) {
    var message:String = ""
    var ketqua:Double = 0
    if a < 0 {
        message = "khong tinh duoc"
    } else {
        ketqua = exp(n * log(a))
        message = "Ket qua la: = \(ketqua)"
    }
    return (ketqua, message)
}
let ann = an(2, n: 2)

//5.
func max(a: Double, b: Double, c: Double, d: Double) -> Double {
    var max = a
    if b > max {
        max = b
    } else {
        if c > max {
            max = c
        } else {
            if d > max {
                max = d
            }
        }
    }
    return max
}

//6.
func tamgiac(a: Double, b: Double, c: Double) -> String {
    var message:String = ""
    if (a + b > c) && (a + c > b) && (c + b > a) && (a > 0) && (b > 0) && (c > 0) {
        message = "a,b,c la ba canh cua tam giac"
        if (a == b) && (b == c) && (c == a) {
            message = "Tam giac deu"
        } else {
            if (a == b) || (b == c) || (a == c) {
                message = "Tam giac can"
            } else {
                if (a * a + b * b == c * c) && (a == b) || (a * a + c * c == b * b) && (a == c) || (b * b + c * c == a * a) && (c == b) {
                    message = "Tam giac vuong can"
                } else {
                    if (a * a == b * b + c * c) || (b * b == a * a + c * c) || (c * c == a * a + b  * b) {
                        message = "Tam giac vuong"
                    }
                }
            }
        }
    } else {
        message = "Tam giac ko hop le"
    }
    return message
}

//7.
func goctoado(xa: Double, ya: Double, xo: Double, yo:Double, xb: Double, yb: Double) -> Double {
    let oa = (xa - xo) * (xa - xo) + (ya - yo) * (ya - xo)
    let ob = (xb - xo) * (xb - xo) + (yb - yo) * (yb - xo)
    let cos = ((xa - xo) * (xb - xo) + (ya - yo) * (yb - yo)) / (sqrt(oa) * sqrt(ob))
    var goc:Double = 0
    if cos == 1 {
        goc = 0
    } else {
        if cos == -1 {
            goc = M_PI
        } else {
            if cos == 0 {
                goc = M_PI / 2
            } else {
                let tg = sqrt(1 - cos * cos) / cos
                goc = atan(tg)
                if goc < 0 {
                    goc = M_PI / (2 - goc)
                }
            }
        }
    }
    return goc
}

//8.
func giaitamgiac(a: Double, b: Double, c: Double) -> (goca: Double, gocb: Double, gocc: Double, goctheodo: Double) {
    var cos = (b * b + c * c - a * a) / (2 * b * c)
    var goc:Double = 0
    var tg:Double = 0
    if cos == 0 {
        goc = M_PI / 2
    } else {
        if cos == -1 {
            goc = M_PI
        } else {
            tg = sqrt(1 - cos * cos) / cos
            goc = atan(tg)
        }
    }
}









































