//: Playground - noun: a place where people can play

import UIKit

//--------------PHAN 1-----------------------
//--------Tinh toan cac bieu thuc------------
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

 
//----------------PHAN 2---------------
//------------Lenh dieu kien-----------
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
func giaitamgiac(a: Double, b: Double, c: Double) -> (goca: Double, gocb: Double, gocc: Double) {
    var cos:Double = 0
    var goc:Double = 0
    var goca:Double = 0
    var gocb:Double = 0
    var gocc:Double = 0
    cos = (b * b + c * c - a * a) / (2 * b * c)
    if cos == 0 {
        goc = M_PI / 2
    } else {
        if cos == -1 {
            goc = M_PI
        } else {
            let tg = sqrt(1 - cos * cos) / cos
            goc = atan(tg)
            if goc < 0 {
                goc = M_PI / 2 - goc
                goca = goc
            }
        }
    }
    cos = (a * a + c * c - b * b) / (2 * a * c)
    if cos == 0 {
        goc = M_PI / 2
    } else {
        if cos == -1 {
            goc = M_PI
        } else {
            let tg = sqrt(1 - cos * cos) / cos
            goc = atan(tg)
            if goc < 0 {
                goc = M_PI / 2 - goc
                gocb = goc
            }
        }
    }
    cos = (a * a + b * b - c * c) / (2 * a * b)
    if cos == 0 {
        goc = M_PI / 2
    } else {
        if cos == -1 {
            goc = M_PI
        } else {
            let tg = sqrt(1 - cos * cos) / cos
            goc = atan(tg)
            if goc < 0 {
                goc = M_PI / 2 - goc
                gocc = goc
            }
        }
    }
    return(goca, gocb, gocc)
}
let t = giaitamgiac(2, b: 2, c: 3)
print("\(t.goca), \(t.gocb), \(t.gocc)")

//9.

func tienganh(n: Int) -> String {
    var message:String = ""
    switch n {
    case 1: message = "One"
    case 2: message = "Two"
    case 3: message = "Three"
    case 4: message = "Four"
    case 5: message = "Five"
    case 6: message = "Six"
    case 7: message = "Seven"
    case 8: message = "Eight"
    case 9: message = "Nine"
    case 10: message = "Ten"
    default:
        break
    }
    return message
}

//10.
func tinhtiendien(socu: Double, somoi: Double, loaiho: String) -> Double {
    let danhsach:[String:Double] = ["ho dan": 60, "ho can bo": 90, "ho kinh doanh": 200, "ho san xuat": 450]
    var tiendm:Double = 0
    var tienvuot:Double = 0
    var tongtien:Double = 0
    let DGDM:Double = 1000
    let GNDM:Double = 2000
    let kwhdm:Double = 0
    let kwhtt = somoi - socu
    if (kwhtt < danhsach[loaiho]) {
        tiendm = kwhtt * DGDM
        tienvuot = 0
    } else {
        tiendm = kwhdm * DGDM
        tienvuot = (kwhtt - kwhdm) * GNDM
    }
    tongtien = tiendm + tienvuot
    return tongtien
}
print( tinhtiendien(100, somoi: 350, loaiho: "ho can bo"))


//11. in mua
func inmua(mua: Int) -> String {
    let dicmua:[Int:String] = [1: "xuan", 2: "ha", 3: "thu", 4: "dong"]
    return dicmua[mua]!
}
inmua(3)

//12.

func hinhchunhat(dai: Double, rong: Double) -> Double {
    return dai * rong
}

func hinhtamgiac(day:Double, cao: Double) -> Double {
    return day * cao / 2
}

func hinhvuong(canh: Double) -> Double {
    return canh * canh
}

func hinhtron(radius: Double) -> Double {
    return radius * radius * M_PI
}

func hinhthang(daylon: Double, daybe: Double, cao:Double) -> Double {
    return ((daylon + daybe) * cao) / 2
}

func tinhdientich(hinh: String) -> Double {
    var dientich:Double = 0
    switch hinh {
    case "n":
        dientich = hinhchunhat(1, rong: 2)
    case "g":
        dientich = hinhtamgiac(1, cao: 2)
    case "v":
        dientich = hinhvuong(3)
    case "t":
        dientich = hinhtron(3)
    case "h":
        dientich = hinhthang(3, daybe: 2, cao: 3)
    default:
        break
    }
    return dientich
}
let dt = tinhdientich("v")

//----------------PHAN 3---------------
//------------Lenh Vong Lap-----------

//1. Bang cuu chuong
func bangcuuchuong() {
    for j in 1...10 {
        for i in 2...9 {
            print("\(j) x \(i) = \(j * i)" )
        }
    }
}
bangcuuchuong()

//2. bai toan co
func baitoanco() -> (dung: Int, nam: Int, gia: Int) {
    var dung:Int = 0
    var nam:Int = 0
    var gia:Int = 0
    for x in 0...20 {
        for y in 0...33 {
            for z in 0...300 {
                if ((15 * x + 9 * y + z == 300) && (x + y + z == 100)) {
                    dung = x; nam = y; gia = z
                }
            }
        }
    }
    return (dung, nam, gia)
}
let baitoan = baitoanco()
print("dung: =\(baitoan.dung) nam: = \(baitoan.nam) gia: =\(baitoan.gia)")

//3. vua ga vua cho
func vuagavuacho() -> (soga: Int, socho: Int) {
    var soga:Int = 0
    var socho:Int = 0
    for x in 0...36 {
        for y in 0...36 {
            if ((2 * x + 4 * y == 100) && (x + y == 36)) {
                soga = x; socho = y
            }
        }
    }
    return (soga, socho)
}
let vuagacho = vuagavuacho()
print("so ga: = \(vuagacho.soga), so cho: = \(vuagacho.socho)")

//4. tao bang so
func taobangso() {
    for i in 0..<100 {
        if (i % 10 == 0) {
            print("\n\(i)")
        } else {
            print(i)
        }
    }
}
taobangso()

//5. in hinh
func inhinha(heigh: Int) {
    var chuoi:String = ""
    for i in 1...heigh {
       chuoi = ""
        for _ in 1...i {
            chuoi += "*"
        }
    print(chuoi)
    }
}
inhinha(3)

func inhinhb(heigh: Int) {
    var chuoi:String = ""
    for i in 1...heigh {
        chuoi = ""
        for _ in i...heigh {
            chuoi += "$"
        }
        print(chuoi)
    }
}
inhinhb(3)

func inhinhc(heigh: Int) {
    var chuoi:String = ""
    //var j:Int = heigh - 1
    for i in 1...heigh {
        chuoi = ""
        for _ in 0..<heigh - i {
            chuoi += " "
        }
        for _ in 1...(i * 2 - 1) {
            chuoi += "*"
        }
        print(chuoi)
    }
}
inhinhc(10)

//6. tao cay chu so
func taocay(heigh:Int) {
    var chuoi:String = ""
    for i in 1...heigh {
        chuoi = ""
        for _ in 0..<heigh - i {
            chuoi += " "
        }
        for j in 1...(2 * i - 1) {
            if (j < i) {
                chuoi += "\((j + i - 1) % 10)"
            } else {
                chuoi += "\((3 * i - 1 - j) % 10)"
            }
        }
        print(chuoi)
    }
}
taocay(6)

//13. trung binh cong, trung binh nhan

func average(arr: [Int]) -> (tbc: Double, tbn: Double) {
    var tbc:Double = 0
    var tbn:Double = 1
    for i in 0...arr.count {
        tbc = tbc + Double(i)
        tbn = tbn * Double(i)
    }
    return (tbc / Double(arr.count), sqrt(tbn))
}
let arr123 = [1, 2, 3, 4, 5]
let fff = average(arr123)
print(fff.tbc, fff.tbn)

//17. sum of n

func sumofn(n: Int) -> Int {
    var s = 0
    var t = n
    while (t > 0) {
        s = s + t % 10
        t = t / 10
    }
    return s
}
sumofn(12)

//22. tim uoc so cua n

func uocso(n: Int) -> [Int] {
    var arr = [Int]()
    for i in 1...n {
        if (n % i) == 0 {
            arr.append(i)
        }
    }
    return arr
}
uocso(100)

//23. dung while tinh so pi

func calculatepi() -> Double {
    var a:Double = 1
    var b:Double = 1
    var repeatStep = 0
    var n:Double = 3
    let epsilon = 0.001
    while (fabs(b) > epsilon) {
        b = -b * (n - 2) / n
        a = a + b
        n = n + 2
        repeatStep += 1
    }
    return (a * 4)
}
print(calculatepi())
print(M_PI)

//30. Tao day Fibonacy
func fibonacy(n: Int) -> [Int] {
    var fib1 = 0
    var fib2 = 1
    var fib = 0
    var arr = [Int]()
    while (fib1 + fib2 < n) {
        fib = fib1 + fib2
        arr.append(fib)
        fib2 = fib1
        fib1 = fib
    }
    return arr
}
print(fibonacy(100))

//------------Phan 4------------------
//-----------Chuong Trinh Con--------

//1.
func giaithua(n: Int) -> Int {
    var s = 1
    for i in 1...n {
        s = s * i
    }
    return s
}

func tinh(n: Double) -> Double {
    var a:Double = n
    var i:Double = 3
    var s:Double = 0
    let epsilon = 0.001
    while (fabs(a) >= epsilon) {
        s += a
        a = a * (-(n * n / (i * (i - 1))))
        i = i + 2
    }
    return s
}
print(tinh(3))

//5. kiem tra so chinh phuong

func CheckSquareNumber(n: Int) -> Bool {
    for i in 1...Int((sqrt(Double(n)))) {
        if (i * i == n) {
            return true
        }
    }
    return false
}
print(CheckSquareNumber(9))

//6. Pitago
func pitago(x: Int, y: Int, z: Int) -> Bool {
    if (x * x + y * y == z * z) || (x * x + z * z == y * y) || (y * y + z * z == x * x) {
        return true
    }
    return false
}

//8. tong lap phuong
func tonglapphuong(n: Int) -> Int {
    var i = 0
    var sum = 0
    var temp = 0
    var t = n
    while (t > 0) {
        i += 1
        temp = t % 10
        sum = sum + temp * temp * temp
        t = t / 10
    }
    return sum
}
print(tonglapphuong(123))


//9. To hop chap k cua n
func tohop(k: Int, n: Int) -> Double {
    return (Double(giaithua(n) / giaithua(k) * giaithua(n - k)))
}
print(tohop(2, n: 3))


//10. Ham de quy tinh tong S
func dequy(x: Double, n: Int) -> Double {
    var dq:Double = 0
    if (n == 0) {
        dq = 1
    } else {
        dq = x * dequy(x, n: n - 1)
    }
    return dq
}
print(dequy(2, n: 4))

func tinhs(n: Int, x: Double) -> Double {
    var s:Double = 1
    for i in 1...n {
        s = s + 1 / dequy(x, n: i)
    }
    return s
}
print(tinhs(1, x: 3))

//15. uoc chung lon nhat va boi chung nho nhat

func ucln(a: Int, b: Int) -> Double {
    var a = abs(a)
    var b = abs(b)
    while (a != 0 && b != 0) {
        if (a > b) {
            a -= b
        } else {
            b -= a
        }
    }
    if a == 0 {
        return Double(b)
    } else  {
        return Double(a)
    }
}

func bcnn(a: Int, b: Int) -> Double {
    return (Double(a * b) / (ucln(a, b: b)))
}
print(bcnn(3, b: 8))

//22. kiem tra so nguyen co bang tong giai thua cua no
func checkgt(n: Int) -> Bool {
    var s = 0
    let m = n
    var t = 0
    var k = n
    while (k > 0) {
        t = k % 10
        s += giaithua(t)
        k = k / 10
    }
    if s == m {
        return true
    } else {
        return false
    }
}
print(checkgt(145))

//--------------PHAN 5-----------------
//------------Mang 1 Chieu----------------

//1.

func printfibonacy(n: Int) -> [Int] {
    var arr1 = fibonacy(100)
    var arr2 = [Int]()
    for i in 0..<n {
        arr2.append(arr1[i])
    }
    return arr2
}
print(printfibonacy(5))

//3.
func sortArray(arr1: [Int]) {
    var arr = arr1
    var i = 0
    var j = arr.count - 1
    while (i < j) {
        if (arr[i] % 5 == 0 && arr[i] % 2 == 1) {
            i += 1
        }
        if (arr[j] % 5 != 0 && arr[j] % 2 == 0) {
            j -=  1
        }
        swap(&arr[i], &arr[j])
    }
}

let aaa = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
sortArray(aaa)
var arr = [Int]()// khởi tạo 1 mảng rỗng có kiểu dữ liệu là Int
var arr1: [Int] = []// Gán 1 mảng rỗng cho một mảng kiểu Int
var a = 10// Nếu khai báo a = 10 thì mặc định a sẽ có kiểu Int. Nên để mặc định vì os nó sẽ linh động cấp phát bộ nhớ khi có sự nâng cấp sau này
var b = 5.5 // Mặc định sẽ nhận kiểu Double

var str = "Hello" //Tự động nhận kiểu String

func hamA(a a: Int) {
} // Tường minh hơn khi gọi hàm

func hamA(a a: Int, b:Int = 10) {
} // Nếu hàm có 1 parameter được gán trước giá trị thì ta sẽ có 2 cách gọi hàm. Hàm sẽ chứa hoặc không chứa parameter đó

































