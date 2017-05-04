-- Funções bobas para brincar um pouco

doubleMe :: (Num a) => a -> a
doubleMe x = x + x

doubleUsAndSum :: (Num x, Num y, Num z) => x -> y -> z
doubleUsAndSum x y = x*2 + y*2

doubleBelow100 x = if x > 100 then x else x*2

doubleBelow100' x = (if x > 100 then x else x*2) + 1

boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

-- Ignorando o item da lista de input, tudo vira 1 e é somado.
length' xs = sum [1 | _ <- xs]

removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

removeAllOddListInsideList xxs = [[x | x <- xs, even x] | xs <- xxs]

generateRightTriangleWithPerimeter x = [(a,b,c) | a <- [1..10], b <- [1..10], c <- [1..10], a^2 + b^2 == c^2, a+b+c == x]
