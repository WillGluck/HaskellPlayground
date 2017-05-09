-- Fun��es bobas para brincar um pouco

doubleMe :: (Num a) => a -> a
doubleMe x = x + x

doubleUsAndSum :: (Num x) => x -> x -> x
doubleUsAndSum x y = x*2 + y*2

----
----Ifss----
----

doubleBelow100 :: (Ord x, Num x) => x -> x
doubleBelow100 x = if x > 100 then x else x*2

doubleBelow100' :: (Ord x, Num x) => x -> x
doubleBelow100' x = (if x > 100 then x else x*2) + 1

----
----List comprehension-
----

boomBangs :: (Num a, Ord a, Integral a) => [a] -> [String]
boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

--Ignorando o item da lista de input, tudo vira 1 e � somado.
length' :: [a] -> Int
length' xs = sum [1 | _ <- xs]

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

removeAllOddListInsideList :: (Num a, Ord a, Integral a) => [[a]] -> [[a]]
removeAllOddListInsideList xxs = [[x | x <- xs, even x] | xs <- xxs]

generateRightTriangleWithPerimeter :: Int -> [(Int, Int, Int)]
generateRightTriangleWithPerimeter x = [(a,b,c) | a <- [1..10], b <- [1..10], c <- [1..10], a^2 + b^2 == c^2, a+b+c == x]

----
----Patterns
----

sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
--Tem que ficar em último esse malandrops. Sen�o ele faz o catch. Sempre adicionar um catch all.
sayMe x = "Not between 1 and 5"

--s2
factorial :: (Integral a) => a -> a
factorial 0 = 1
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
--Podia ser [x, y].
tell (x:y:[]) = "Lista tem dois elementos: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "Lista eh longa. Os dois primeiros elementos sao: "  ++ show x ++ " and " ++ show y

--Um pouco de recursão pra animar
length'' :: (Num b) => [a] -> b
length'' [] = 0
length'' (_:xs) = 1 + length'' xs

-- Recursão again
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- NOME@, serve como um alias pra evitar repetição.
capital :: String -> String
capital "" = "String vazio, eita"
capital all@(x:xs) = "A primeira letra de " ++ all ++ " eh " ++ [x]

----
----Guards!!! Com where e tudo que tem direito
----

imcTell :: (RealFloat a) => a -> a -> String
imcTell weight height
  | bmi <= magro  = "Seco"
  | bmi <= normal = "Ta susse"
  | bmi <= gordo  = "Gordo"
  | otherwise         = "Obeso"
  where bmi = weight / height ^ 2
        magro = 18.5
        normal = 25.0
        gordo = 30.0
        -- (magro, normal, gordo) = (18.25, 25.0, 30.0)

--
initials :: String -> String -> String
--Poderia ter colocado nos atributos da função o pattern, mas só pra mostrar q dá pra deixar no where vai ficar ali.
initials firstName lastName = [f] ++ ". " ++ [l] ++ "."
  where (f:_) = firstName
        (l:_) = lastName

-- Sim funções no where O__O
calcImcs :: (RealFloat a) => [(a, a)] -> [a]
calcImcs xs = [bmi w h | (w,h) <- xs]
  where bmi weight height = weight / height ^ 2
