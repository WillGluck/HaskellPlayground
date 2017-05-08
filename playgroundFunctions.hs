-- Funções bobas para brincar um pouco

doubleMe :: (Num a) => a -> a
doubleMe x = x + x

doubleUsAndSum :: (Num x) => x -> x -> x
doubleUsAndSum x y = x*2 + y*2

doubleBelow100 :: (Ord x, Num x) => x -> x
doubleBelow100 x = if x > 100 then x else x*2

doubleBelow100' :: (Ord x, Num x) => x -> x
doubleBelow100' x = (if x > 100 then x else x*2) + 1

boomBangs :: (Num a, Ord a, Integral a) => [a] -> [String]
boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

-- Ignorando o item da lista de input, tudo vira 1 e é somado.
length' :: [a] -> Int
length' xs = sum [1 | _ <- xs]

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

removeAllOddListInsideList :: (Num a, Ord a, Integral a) => [[a]] -> [[a]]
removeAllOddListInsideList xxs = [[x | x <- xs, even x] | xs <- xxs]

generateRightTriangleWithPerimeter :: Int -> [(Int, Int, Int)]
generateRightTriangleWithPerimeter x = [(a,b,c) | a <- [1..10], b <- [1..10], c <- [1..10], a^2 + b^2 == c^2, a+b+c == x]

sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
--Tem que ficar em último esse malandrops. Senão ele faz o catch. Sempre adicionar um catch all.
sayMe x = "Not between 1 and 5"


factorial :: (Integral a) => a -> a
factorial 0 = 1
--s2
factorial n = n * factorial (n - 1)

addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

first :: (a,b,c) -> a
first (x,_,_) = x

second :: (a,b,c) -> b
second (_,y,_) = y

third :: (a,b,c) -> c
third (_,_,z) = z

sumTuples :: (Num x, Ord x, Integral x) => [(x, x)] -> [x]
sumTuples xs = [ a+b | (a, b) <- xs]

head' :: [a] -> a
head' [] = error "Vc quer o primeiro item de uma lista vazia seu imbecil? Assim nao da!"
head' (x:_) = x

tell :: (Show a) => [a] -> String
tell [] = "Lista vazia"
tell (x:[]) = "Lista tem um elemento: " ++ show x
--Podia ser [x, y]. Sugarr
tell (x:y:[]) = "Lista tem dois elementos: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "Lista eh longa. Os dois primeiros elementos sao: "  ++ show x ++ " and " ++ show y

--Um pouco de recurssão pra animar
length'' :: (Num b) => [a] -> b
length'' [] = 0
length'' (_:xs) = 1 + length'' xs
