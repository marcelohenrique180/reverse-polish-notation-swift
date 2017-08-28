import Foundation

system("clear") // limpa o console

var expressao = "A+B*(C-D)/E"

// Pilha de operadores
var operadoresStack = Stack<Character>()

// Pilha da expressao npi
var npi = Stack<Character>()

var optSelected = ""
while optSelected != "99"  {

    print("Escolha uma opção: \(expressao)")
    print("1.  Inserir Expressão")
    print("2.  Avaliar Expressão")
    print("3.  Imprimir Expressão")
    print("99. Sair")

    optSelected = readLine()!
    var opt = Opcao(rawValue: optSelected)

    system("clear") // limpa o console
    if let opt = opt {
        switch opt {
        case .inserir:
            print("Insira a expressão que deseja utilizar: ", terminator: "")
            expressao = readLine()!
        case .avaliar:
            var invalido = false
            let arrayExp = Array(expressao.characters)

            // Checa se os parenteses abrem e fecham
            if !( arrayExp.filter { $0 == "(" }.count == arrayExp.filter { $0 == ")" }.count) {
                invalido = true
            }

            // Checa se nao há operador antes de parenteses fechando
            if let match = expressao.range(of: "[*|+|-|/]\\)", options: .regularExpression) {
                invalido = true
            }

            // Checa se nao há espaço entre operandos
            if let match = expressao.range(of: "[A-Za-z0-9]\\s[A-Za-z0-9]", options: .regularExpression) {
                invalido = true
            }

            // Checa se termina com operador
            if let match = expressao.range(of: "[+|-|/|*]$", options: .regularExpression) {
                invalido = true
            }

            // Checa se começa com operador Expressão Inválidao
            if let match = expressao.range(of: "^[/|*]", options: .regularExpression) {
                invalido = true
            }

            if invalido {
                print("Expressão Inválida")                
            } else {
                print("Expressão Válida")
            }

        case .imprimir:
            let arrayExp = Array(expressao.characters).filter({ $0 != " "})

            for element in arrayExp {
                switch element {
                case ")":
                    while operadoresStack.peek() != "(" {
                        guard let element = operadoresStack.pop() else {
                            break
                        }
                        npi.push(element)
                    }
                    let _ = operadoresStack.pop()
                case "(":
                    operadoresStack.push(element)                
                case "*", "/", "+", "-":
                    if let head = operadoresStack.peek() {
                        var headOperador = getOperador(operador: String(head))!
                        let elementOperador = getOperador(operador: String(element))!
                        // checa prioridade
                        while headOperador.hasMorePriority(operador: elementOperador) {
                            // checa se esta vazio
                            guard let _ = operadoresStack.peek() else {
                                break
                            }
                            npi.push(operadoresStack.pop()!)
                            if let newHead = operadoresStack.peek() {
                                headOperador = getOperador(operador: String(newHead))!
                            }
                        }
                    }
                    operadoresStack.push(element)
                default:
                    npi.push(element)                    
                }
                //print("\(element) é o elemento:", terminator: "")
                //print("\(operadoresStack.array)", terminator: "")
                //print("\(npi.array)")
            }

            while let element = operadoresStack.pop() {
                npi.push(element)
            }

            print("\(String(npi.array))")
            npi = Stack<Character>()
        default:
            print("Bye bye...")
        }
    }
}