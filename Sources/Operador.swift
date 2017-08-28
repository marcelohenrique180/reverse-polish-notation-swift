// Operadores com Peso atribuido
enum Operador: Int {
    case multiplication = 2
    case sum = 1
    case parentheses = 0

    func hasMorePriority(operador: Operador) -> Bool{
        let selfPriority = self.rawValue
        let operatorPriority = operador.rawValue
        return selfPriority >= operatorPriority
    }
}

func getOperador(operador: String) -> Operador? {
    switch operador {
    case "(", ")":
        return .parentheses
    case "*", "/":
        return .multiplication
    case "+", "-":
        return .sum
    default:
        return nil
    }
}