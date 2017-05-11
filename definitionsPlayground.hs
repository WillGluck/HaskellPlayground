iAmPicky = [x | x <- [10..20], x /= 13, x /= 15, x /= 19]

crossAllThisShit = [x*y | x <- [1..30], y <- [1..20], x*y > 20]

nouns = ["Sapo", "Papa", "Rei"]
adjetives = ["Bobao", "Sabichao", "Preguicoso"]
justSomeFun = [noun ++ " " ++ adjetive | noun <- nouns, adjetive <- adjetives]

answer = 4 * (let x = 9 in x + 1) + 2

letPower = let square x = x * x in (square 2, square 3, square 4)

-- flip div cria uma função que recebe dois parametros, faz flip e divide. Viva o currie
maluquice = zipWith (flip div) [2,2..] [10,8,6,4,2]

-- Curried + map
let listOfFuns = map (*) [0..]