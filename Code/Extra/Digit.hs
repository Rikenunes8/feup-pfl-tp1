module Digit (Digit, intToDigit, digitToInt, digitsToString) where

data Digit d = Digit0 | Digit1 | Digit2 | Digit3 | Digit4 | Digit5 | Digit6 | Digit7 | Digit8 | Digit9

instance Show Digit where
    show Digit0 = "0"
    show Digit1 = "1"
    show Digit2 = "2"
    show Digit3 = "3"
    show Digit4 = "4"
    show Digit5 = "5"
    show Digit6 = "6"
    show Digit7 = "7"
    show Digit8 = "8"
    show Digit9 = "9"

intToDigit :: Int -> Digit
intToDigit 0 = Digit0
intToDigit 1 = Digit1
intToDigit 2 = Digit2
intToDigit 3 = Digit3
intToDigit 4 = Digit4
intToDigit 5 = Digit5
intToDigit 6 = Digit6
intToDigit 7 = Digit7
intToDigit 8 = Digit8
intToDigit 9 = Digit9
intToDigit _ = error "Digito é entre [0,9]"

digitToInt :: Digit -> Int
digitToInt Digit0 = 0
digitToInt Digit1 = 1
digitToInt Digit2 = 2
digitToInt Digit3 = 3
digitToInt Digit4 = 4
digitToInt Digit5 = 5
digitToInt Digit6 = 6
digitToInt Digit7 = 7
digitToInt Digit8 = 8
digitToInt Digit9 = 9

digitsToString :: [Digit] -> String
digitsToString [] = ""
digitsToString (x:xs) = (show x) ++ digitsToString xs
