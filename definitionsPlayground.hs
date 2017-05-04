iAmPicky = [x | x <- [10..20], x /= 13, x /= 15, x /= 19]

crossAllThisShit = [x*y | x <- [1..30], y <- [1..20], x*y > 20]

nouns = ["Sapo", "Papa", "Rei"]
adjetives = ["Bobao", "Sabichao", "Preguicoso"]
justSomeFun = [noun ++ " " ++ adjetive | noun <- nouns, adjetive <- adjetives]
