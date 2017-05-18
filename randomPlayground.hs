--Modules.

--import Data.List
-- :m + Data.List Data.Map Data.Set --No GHCI
-- import Data.List (nub, sort) --Métodos específicos
-- import Data.List hiding (nub) --Retira método específico
-- import qualified Data.Map as M -- Com namespace (customizado)

import Data.List
import Data.Char
import qualified Data.Map as Map
import Data.Set
import Data.Function

--import Geometry.Sphere as Sphere
--import Geometry.Cuboid as Cuboid
--import Geometry.Cube as Cube

--DATA.LIST

-- interperse - Passa um valor de uma lista. Adiciona o valor no meio de cada item da lista.
-- intercalate - Passa uma lista e uma lista de listas. Estica os valores, adicionando a lista passada no meio das listas que constituiam a outra lisca (sic!)
-- transpose - Sem segredo, pega uma lista de listas e transforma as "colunas" viram as "linhas"
equation1 = [0,3,5,9]
equation2 = [10,0,0,9]
equation3 = [8,5,1,-1]
equations = [equation1, equation2, equation3]
equationsSum = Data.List.map sum $ transpose equations
-- foldl' e foldl1' - são as versões estrítas
-- concat - apesar do nome, apenas faz um flat em uma lista de listas...
-- concatMap - mesma coisa que fazer um map e dps concat
-- and - recebe uma lista de booleans e retorna true se todos forem true
-- or - recebe uma lista de booleans e retorna true se um deles for true
asd = and $ Data.List.map (>3) [1,2,3,4,5]
asdqwe = or $ Data.List.map (==4) [1,2,3,4,5]
-- any e all - recebe um predicado e verifica se algum ou todos elementos satisfazem o predicado, respectivamente. É usado normalmente ao invés da combinação MAP + (OR/AND)
afaqwe = all (>3) [1,2,3,4,5]
ert = any (==4) [1,2,3,4,5]
--iterate - Pega uma função de um valor inicial e vai acumulando ele eternamente... Daí usa um take, por exemplo pra pegar o valor.
rty = take 10 $ iterate (*2) 1
-- splitAt - pega um número e quebra uma lista em duas tuplas com cada metade.
poi = let (a,b) = splitAt 4 "WILLGLUK" in b ++ a --invertendo a string na maciota
-- takeWhile - conhecida já
-- dropWhile - Parecida com takeWhile, mas em vez de "pegar" enquanto for true, remove da lista enquanto for true
-- span - recebe uma função e uma lista também, mas retorna duas listas. Uma é o resultado de um takeWhile e a outra são os que "caíram fora" da validação do takeWhile
-- sort - recebe uma lista de Ord e ordena
-- group - pega uma lista de divide em uma lista de listas com todos os itens que são iguais. Agrupa os iguais, basicamente (por ordem)
-- inits e tails - cria uma lista recursivamente aplicando init e tail, até não sobrar mais nada. Retorna uma lista dos resultados parciais.
search :: (Eq a) =>  [a]-> [a] -> Bool
search needle haystack =
  let nlen = length needle
  in Data.List.foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)
-- isInfixOf - basicamente a implementação acima. Procura uma lista dentro de uma lista. Tem isPrefixOf e isSuffixOf que vem o início e final, respectivamente.
-- elem e notElem verifica se um item está ou não, respectivamente, em uma lista.
-- partition - Recebe uma lista e predicado. Retorna primeira a lista que satisfaz o predicado e dps a que não.
-- find - Recebe um predicado e retorna um Maybe do primeiro encontrado. Maybe pode ser Just alguma coisa ou Nothing.
-- elemIndex - Tipo elem, mas em vez de retornar boolean retorna um Maybe do índice do primeiro encontrado.
-- elemIndices - Igual elemIndex mas retorna uma lista de índices. Serve pra encontrar vários.
-- findIndex - Tipo find, só que retorna uma lista de índices. Serve pra encontrar vários.
-- zip3, zip4, zipWith3, zipWith4...vai até 7.
-- lines - pra lidar com textos. Pega cada linha de texto e coloca em uma lista diferente. Retorna uma lista de listas dai.
-- unlines - Função inversa de lines.
-- words e unwords - divide o texto em palavras e o contrário, respectivamente.
-- delete - deleta a primeira ocorrência do valor passado da lista passada.
-- \\ - Usa LISTA \\ LISTA - cria uma nova lista sem os elementos que existem na lista da esquerda e direita (exclusão é um pra um)
-- union - Junta duas listas mas remove repetições!
 -- intersect - cria nova lista apenas com os valores que se repetem em ambas as listas.
 -- insert - adiciona um valor numa lista que pode ser ordenada, na primeira posição "correta" encontrada (baseada na ordenação).
 -- length, take, drop, splitAt, !! e replicate usam INTS por motivos históricos
 -- Para casos diferentes usar genericNOME_DO_METODO (exceção sendo genericIndex que representa a função !!)
 -- nub, delete, union, intersect e group usam == para as comparações
 -- Quando quiser comparação customizada usar nubBy, deleteBy, unionBy, intersectBy e groupBy. usar group é igual usar groupBy (==)
separatePositivesAndNegatives = Data.List.groupBy (\x y -> (x > 0) == (y > 0))
-- on
separatePositivesAndNegatives' = groupBy ((==) `on` (>))
-- sort, insert, maximum e minimum também podem ser usados pra ordenação customizada com sortBy, insertBy, maximumBy e minimumBy.
-- Como saber onde adicionar uma lista de listas? Se uma lista não é Ord
xs = [[5,4,5,4,4], [1,2,3], [3,5,4,3], [], [2], [2,2]]
gfh = Data.List.sortBy (compare `on` length) xs
-- Resultado [[],[2],[2,2],[1,2,3],[3,5,4,3],[5,4,5,4,4]]

--DATA.CHAR

-- isControl (verifica se é caracter de controle), isSpace, isLower, isUpper, isAlpha (letra), isAlphaNum (número e letra), isPrint,
-- isDigit, isOctoDigit (é um dígito octal), isHexDigit, isLetter, isMark (verifica se é um caracter unicode de marcação..francês),
-- isNumber, isPunctuation, isSymbol, isSeparator (espaços e separadores), isAscii, isAsciiUpper, isAsciiLower...
tyu = all isAlphaNum "bobby283"
--True
--Simulando words com isSpace
wefv = Data.List.filter (not. any Data.Char.isSpace) . Data.List.groupBy ((==) `on` Data.Char.isSpace) $  "hey guys its me"
-- ["hey", "guys", "its", "me"]
-- generalCategory - identifica a GeneralCategory (extende de Eq) de um caracter. É um enumerador
sdfsa = generalCategory 'A'
-- UppercaseLetter
-- Para manipular: toUpper, toLower, toTitle (as vzs é UpperCase), digitToInt (0..9) (a..f), intToDigit.
-- Ord retorna o valor numérico que representa o caracter. chr retorna o char de um valor numérico
encode :: Int -> String -> String
encode shift text =
  let ords = Data.List.map ord text
      shifted = Data.List.map (+shift) ords
  in Data.List.map chr shifted

decode :: Int -> String -> String
decode shift text = encode (negate shift) text

--DATA.MAP

-- uma maneira de representar maps? Association List [(a,b)]
findKey :: (Eq k) => k -> [(k, v)] -> Maybe v
--findKey key [] = Nothing
--findKey key ((k,v):xs) = if key == k then Just v else findKey key xs
findKey key  = Data.Set.foldr (\(k,v) acc -> if key == k then Just v else acc) Nothing
-- Mapas são mais otimizados. Use fromList para transformar uma lista associativa em um Map. Remove chaves duplicadas.
-- Map.fromList ::(Ord k) => [(k,v)] -> Map.Map k v
--empty - retorna map vazio
-- insert - recebe chave, valor e um mapa e faz o trabalho
-- null - verifica se o mapa é nulo
-- size - Retorna o tamanho do mapa
-- singleton - recebe chave valor e cria um mapa com apenas um valor Oo
-- lookup - igual o do Data.List. Retorna Just valor ou Nothing.
-- member - recebe a key e o mapa e retorna boolean dizendo se a chave está
-- map e filter - igual o da lista, operam apenas no valor.
-- toList - inverso do fromList
-- keys e elems retorna uma lista com as chaves e elementos, respectivamente.
-- fromListWith - recebe uma função para decidir o que fazer com chaves duplicadas.

--phoneBookToMap :: (Ord k) => [(k,String)] -> Map.Map k String
--phoneBookToMap xs = Map.fromListWith (\number1 number2 -> number1 ++ ", " ++ number2) xs
phoneBookToMap :: (Ord k) => [(k, a)] -> Map.Map k [a]
phoneBookToMap xs = Map.fromListWith (++) $ Data.Set.map (\(k,v) -> (k, [v])) xs -- transforma valor em lista e aplica somma de listas.
--insertWith - o que fromListWith é para fromList insertWith é para insert. No caso de valores repetidos.
