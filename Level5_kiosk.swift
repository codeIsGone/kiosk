import Foundation

//공통으로 구현해야할 요구사항 프로토콜로 정의
protocol Menu {
    
    //사용자에게 보여지는 부분
    func display()
    
    //사용자의 입력을 처리하는 로직
    func inputProcess()
}

class EatOrOutMenu: Menu {
    var takeOutPlease = true
    
    func display() {
        print ("""
        
        어서오세요. Gon's kitchen입니다!
        
        1. 포장하기
        2. 먹고가기
        0. 종료하기
        
        """)
    }
    
    func inputProcess() {
        let input = readLine()!
        switch input {
        case "1":
            takeOutPlease = true
            userControll.changeMenu(changeTo: MainMenu())
        case "2":
            takeOutPlease = false
            userControll.changeMenu(changeTo: MainMenu())
        case "0":
            sleep(3)
            userControll.startOrder()
        default:
            print("올바른 번호를 입력해주세요")
            inputProcess()
        }
    }
}

class MainMenu: Menu {
    func display() {
        if cart.cartInFood.isEmpty {
            print ("""
            
            원하시는 메뉴를 선택해주세요.
            
            1. 버거
            2. 디저트
            3. 음료
            0. 종료하기
            
            """)
        }
        else {
            print ("""
            
            원하시는 메뉴를 선택해주세요.
            
            1. 버거
            2. 디저트
            3. 음료
            4. 주문하기
            0. 종료하기
            
            """)
        }
    }
    func inputProcess() {
        let input = readLine()!
        switch input {
        case "1":
            userControll.changeMenu(changeTo: BugerMenu())
        case "2":
            userControll.changeMenu(changeTo: DessertMenu())
        case "3":
            userControll.changeMenu(changeTo: BeverageMenu())
        case "4":
            if cart.cartInFood.isEmpty {
                fallthrough
            }
            else {
                userControll.changeMenu(changeTo: CheckOutMenu())
            }
        case "0":
            sleep(3)
            userControll.startOrder()
        default:
            print("올바른 번호를 입력해주세요")
        }
    }
}

class BugerMenu: Menu {
    func display() {
        print ("""
        
        원하시는 버거를 선택해주세요.
        
        [ 버거 메뉴 ]
        1. 곤스버거        | W 8.9 | 쫄깃한 빵 위에 특별한 소스가 더해진 곤스키친의 시그니처 버거
        2. 치즈버거        | W 6.9 | 네 가지 프랑스산 치즈가 토핑되어 부드러운 맛이 일품인 치즈 버거
        3. 치킨버거        | W 9.4 | 크리스피한 치킨 패티로 먹는 재미가 있는 치킨 버거
        0. 이전으로
        
        """)
    }
    func inputProcess() {
        let input = readLine()!
        switch input {
        case "1":
            cart.selectedFood = "곤스버거"
            userControll.changeMenu(changeTo: AddToCartMenu())
        case "2":
            cart.selectedFood = "치즈버거"
            userControll.changeMenu(changeTo: AddToCartMenu())
        case "3":
            cart.selectedFood = "치킨버거"
            userControll.changeMenu(changeTo: AddToCartMenu())
        case "0":
            userControll.changeMenu(changeTo: MainMenu())
        default:
            print("올바른 번호를 입력해주세요")
        }
    }
}

class DessertMenu: Menu {
    func display() {
        print ("""
        
        원하시는 디저트를 선택해주세요.
        
        [ 디저트 메뉴 ]
        1. 당근케이크    | W 5.0 | 맛있고 건강한 당근 케이크 (당근맛이 거의 안 나요)
        2. 마늘베이글    | W 4.5 | 마늘향이 물씬, 갈릭 버터의 풍미가 가득한 베이글
        3. 어니언스콘    | W 3.5 | 베이커리 근-본 안 먹기 아쉬운 어니언 스콘!
        0. 이전으로
        
        """)
    }
    func inputProcess() {
        let input = readLine()!
        switch input {
        case "1":
            cart.selectedFood = "당근케이크"
            userControll.changeMenu(changeTo: AddToCartMenu())
        case "2":
            cart.selectedFood = "마늘베이글"
            userControll.changeMenu(changeTo: AddToCartMenu())
        case "3":
            cart.selectedFood = "어니언스콘"
            userControll.changeMenu(changeTo: AddToCartMenu())
        case "0":
            userControll.changeMenu(changeTo: MainMenu())
        default:
            print("올바른 번호를 입력해주세요")
        }
    }
}

class BeverageMenu: Menu {
    func display() {
        print ("""
        
        원하시는 음료를 선택해주세요.
        
        [ 음료 메뉴 ]
        1. 콜라    | W 4.0 | 콜라는 역시, 펩시? 아니, 코카콜라다!
        2. 소다    | W 5.0 | 상큼한 레몬으로 입안을 깔끔하게. 수제청이 들어간 소다
        3. 커피    | W 6.0 | 산미가 풍부한 브라질산 원두로 직접 추출한 스페셜티 커피
        0. 이전으로
        
        """)
    }
    func inputProcess() {
        let input = readLine()!
        switch input {
        case "1":
            cart.selectedFood = "콜라"
            userControll.changeMenu(changeTo: AddToCartMenu())
        case "2":
            cart.selectedFood = "소다"
            userControll.changeMenu(changeTo: AddToCartMenu())
        case "3":
            cart.selectedFood = "커피"
            userControll.changeMenu(changeTo: AddToCartMenu())
        case "0":
            userControll.changeMenu(changeTo: MainMenu())
        default:
            print("올바른 번호를 입력해주세요")
        }
    }
}

class AddToCartMenu: Menu {
    var selectedFood = ""
    var cartInFood: [String] = []
    func display() {
        print ("""
        
        \(cart.selectedFood)를 장바구니에 담으시겠습니까?
        
        1. 예
        2. 아니요
        
        """)
    }
    func inputProcess() {
        let input = readLine()!
        switch input {
        case "1":
            print ("\(cart.selectedFood)를 장바구니에 추가하였습니다.")
            cart.cartInFood.append(cart.selectedFood)
            cart.selectedFood = ""
            userControll.changeMenu(changeTo: MainMenu())
        case "2":
            cart.selectedFood = ""
            userControll.changeMenu(changeTo: MainMenu())
        default:
            print("올바른 번호를 입력해주세요")
        }
    }
}

class CheckOutMenu: Menu {
    
    func timeCheck() {
        let hour = DateFormatter()
        let minuate = DateFormatter()
        hour.dateFormat = "HH"
        minuate.dateFormat = "mm"
        let whatHour = hour.string(from: Date())
        let whatMinuate = minuate.string(from: Date())
        let hourAndMinuate = Double(whatHour)! + (Double(whatMinuate)! / 100)
        if hourAndMinuate > 11.30 && hourAndMinuate < 11.50 {
            print ("""
            현재 시각은 \(whatHour)시 \(whatMinuate)분입니다.
            은행 점검시간은 11시 30분 ~ 11시 50분으로 결제가 불가능합니다.
            """)
            print ("다음 주문 접수를 준비 중입니다.")
            sleep(3)
            userControll.startOrder()
        }
    }
    
    func display() {
        
        //총 금액 계산
        for i in cart.cartInFood{
            if let price = priceOfMenu[i] {
                totalPrice += Int(price * 1000)
            }
        }
        
        print("""
        
        장바구니 메뉴
        \(cart.cartInFood)
        
        총 금액 \(totalPrice)원
        
        주문하시겠습니까?"
        
        1. 주문하기
        2. 메뉴판으로 돌아가기
        
        """
        )
    }
    func inputProcess() {
        let input = readLine()!
        switch input {
        case "1":
            //은행 점검 시간 확인
            timeCheck()
            
            //잔액 확인
            if totalPrice > myCash {
                print("\(totalPrice - myCash)원 부족하여 주문할 수 없습니다.")
                print ("다음 주문 접수를 준비 중입니다.")
                sleep(3)
                userControll.startOrder()
            }
            else {
                orderCount += 1
                print("주문이 접수되었습니다.")
                print ("다음 주문 접수를 준비 중입니다.")
                sleep(3)
                userControll.startOrder()
            }
        case "2":
            userControll.changeMenu(changeTo: MainMenu())
        default:
            print("올바른 번호를 입력해주세요")
        }
    }
}


class Controller {
    var finish = false
    var currentMenu: Menu = EatOrOutMenu()
    func changeMenu (changeTo: Menu) {
        currentMenu = changeTo
    }
    func startOrder () {
        self.changeMenu(changeTo: EatOrOutMenu())
        cart.cartInFood = []
        totalPrice = 0
        self.finish = false
        while self.finish == false {
            self.currentMenu.display()
            self.currentMenu.inputProcess()
        }
    }
}



//메뉴 가격 데이터를 담은 딕셔너리 생성
var priceOfMenu: Dictionary<String, Double> = [
    "곤스버거": 8.9, "치즈버거": 6.9, "치킨버거": 9.4, "당근케이크": 5.0, "마늘베이글": 4.5, "어니언스콘": 3.5, "콜라": 4.0, "소다": 5.0, "커피": 6.0
]

//잔액, 총 금액, 현재 시간 선언
var myCash = 15000
var totalPrice = 0
var orderCount = 0

//인스턴스 생성
var userControll = Controller()
var cart = AddToCartMenu()

//글로벌Queue에서 대기 주문수를 출력하는 로직
//비동기 방식을 사용하여, 메인 스레드에서의 업무 처리 동시성을 확보
DispatchQueue.global().async {
    while true {
        sleep(5)
        print ("""
        
        (현재 대기 주문수 \(orderCount)개)
        
        """)
    }
}

//실행문 메서드화
userControll.startOrder()
