module BigNumberD where


import Digit

data BigNumber = Positive [Digit] 
               | Negative [Digit]

--scanner :: String -> BigNumber
--scanner [] = []
--scanner s = 


output :: BigNumber -> String
output (Positive n) = "+" ++ digitsToString n
output (Negative n) = "-" ++ digitsToString n