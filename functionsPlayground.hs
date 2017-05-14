-- Funções bobas para brincar um pouco

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

--Ignorando o item da lista de input, tudo vira 1 e é somado.
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
--Tem que ficar em último esse malandrops. Senão ele faz o catch. Sempre adicionar um catch all.
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

---
--- Let it be
--- São expressões então podem ser usadas em qualquer lugar uhules. E definem funções vsf muito bom.

calcAreaCylinder :: (RealFloat a) => a -> a -> a
calcAreaCylinder r h =
  let sideArea = 2 * pi * r * h
      topArea = pi * r ^ 2 --Pode ser colocado na mesma linha e dividinha por ; mas fica feinho
  in sideArea + 2 * topArea

--Alternativa com let. Valor definido no let só fica visível após definição.
--ATENÇÃO - IN clause limita a visibilidade das declarações LET. Tanto aqui como no GHCi
calcImcsForFatties xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]

---
--- CASE Então aparentemente GUARDS são apenas syntatic sugar para CASE. O bom é que CASE é expressão então podem ser usadas EVERYWHEREEE!

head'' xs = case xs of [] -> error "JA DISSE Q NÃO TEM COMO PEGAR O HEAD DE UMA LISTA VAZIA MALDITO"
                       (x:_) -> x

firstItemOfEveryList :: [[a]] -> [a]
firstItemOfEveryList [] = []
firstItemOfEveryList xxs = [head xs | xs <- xxs, not(null xs)]

firsts :: [[a]] -> [a]
firsts [] = []
firsts ([]:xss) = error "sublist is empty"
firsts [(x:xs)] = [x]
firsts ((x:xs):xss) = x: firsts xss

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "O máximo de uma lista vazia é tua mãe maldito tu ta me testando né?"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)
--Versão deselegante
--maximum' [x:xs]
--  x > maxTail = x
--  otherwise = maxTail
--  where maxTail = maximum' xs

---
---RECURSÃO... Mano. Eu amo recursão.
---
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
  | n <= 0 = []
  | otherwise = x:replicate' (n-1) x

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _ | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x : take' (n-1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

repeat' :: a -> [a]
repeat' x = x:repeat' x

zip' :: [a] -> [b] -> [(a, b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x, y): zip' xs ys

elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' e (x:xs)
  | e == x = True
  | otherwise = elem' e xs

quicksort:: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  let smallerSorted = [a | a <- xs, a <= x] --quicksort (filter (<=x) xs)
      biggerSorted = [a | a <- xs, a > x] --quicksort (filter (>x) xs)
  in smallerSorted ++ [x] ++ biggerSorted

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

---
--- HIGHER ORDER FUNCTIONS - Agora a porra começa a ficar séria
---

--- CURRIED
compareWithHundred :: (Num a, Ord a) => a -> Ordering
--compareWithHundred x = compare 100 x
compareWithHundred = compare 100

divideByten :: (Floating a) => a -> a
--divideByten x = (/10) x
divideByten = (/10)

-- Exceção é a função infixo "-". -4 é 4 negativo.
--Função de um lado para outro

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

flip' :: (a -> b -> c) -> (b -> a -> c)
--flip' f = g where g x y = f y x
flip' f x y = f y x

--Map
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

sumThreeToEach :: (Num a) => [a] -> [a]
sumThreeToEach x = map (3+) x

--Filter

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs)
  | p x = x : filter p xs
  | otherwise = filter p xs


returnTheThrees :: (Eq a, Num a) => [a] -> [a]
returnTheThrees x = filter (==3) x

largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [100000, 99999..])
  where p x = mod x 3829 == 0

--takeWhile
--Takewhile
sumOfAllOdSquaredSmallerThan :: (Integral a) =>  a -> a
--sumOfAllOdSquaredSmallerThan x = sum (takeWhile (<x) (filter odd (map (^2) [1..])))
sumOfAllOdSquaredSmallerThan x = sum (takeWhile (<x) [n^2 | n <- [1..], odd n])

getSquareSum =  sum (takeWhile (<10000) (filter odd (map (^2) [1..])))
--getSquareSum = sum (takeWhile(<10000) [n^2 | n <- [1..], odd (n^2)])

collatzSequence :: (Integral a) => a -> [a]
collatzSequence 1 = [1]
collatzSequence n
  | even n = n: collatzSequence (n `div` 2)
  | odd n = n: collatzSequence (n * 3 + 1)

numLongCollatzSequence :: Int
--numLongCollatzSequence = length (filter isLong (map collatzSequence [1..100])) where isLong xs = length xs > 15
--Lambda
numLongCollatzSequence = length (filter (\xs -> length xs > 15) (map collatzSequence [1..100]))

listOfFuns = map (*) [0..]

-- Folds

sum'' :: (Num a) => [a] -> a
--sum'' xs = foldl (\acc x -> acc + x) 0 xs
--sum'' xs = foldl1 (\acc x -> acc + x) xs
sum'' = foldl (\acc x -> acc + x) 0

maximum'' :: (Ord a) => [a] -> a
maximum'' = foldl1 (\acc x -> if x > acc then x else acc)

reverse'' :: [a] -> [a]
reverse'' = foldr (\x acc -> x:acc) []

elem'' :: (Eq a) => a -> [a] -> Bool
elem'' n xs = foldl (\acc x -> if n == x then True else acc) False xs

map'' :: (a -> b) -> [a] -> [b]
map'' f xs = foldr (\x acc -> f x : acc) [] xs

head''' :: [a] -> a
head''' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\_ x -> x)

-- How many elements does it take for the sum of the roots of all natural numbers to exceed 1000
sqrtSums :: Int
--sqrtSums =  length (takeWhile(<1000) (scanl1 (+) (map sqrt [1..])))

--Function Application $
sqrtSums =  length $ takeWhile(<1000) $ scanl1 (+) (map sqrt [1..])

--Function composition
negateList :: (Num a) => [a] -> [a]
--negateList xs = map negate (map abs xs)
negateList = map (negate . abs)
