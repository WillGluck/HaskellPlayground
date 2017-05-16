--Modules.

--import Data.List
-- :m + Data.List Data.Map Data.Set --No GHCI
-- import Data.List (nub, sort) --Métodos específicos
-- import Data.List hiding (nub) --Retira método específico
-- import qualified Data.Map as M -- Com namespace (customizado)

import Data.List
import Data.Char
import Data.Map
import Data.Set

-- interperse - Passa um valor de uma lista. Adiciona o valor no meio de cada item da lista.
-- intercalate - Passa uma lista e uma lista de listas. Estica os valores, adicionando a lista passada no meio das listas que constituiam a outra lisca (sic!)
-- transpose - Sem segredo, pega uma lista de listas e transforma as "colunas" viram as "linhas"
let equation1 = [0,3,5,9]
let equation2 = [10,0,0,9]
let equation3 = [8,5,1,-1]
let equations = [equation1, equation2, equation3]
let equationsSum = map sum $ transpose equations
-- foldl' e foldl1' - são as versões estrítas
-- concat - apesar do nome, apenas faz um flat em uma lista de listas...
-- concatMap - mesma coisa que fazer um map e dps concat
-- and - recebe uma lista de booleans e retorna true se todos forem true
-- or - recebe uma lista de booleans e retorna true se um deles for true
and $ map (>3) [1,2,3,4,5]
or $ map (==4) [1,2,3,4,5]
-- any e all - recebe um predicado e verifica se algum ou todos elementos satisfazem o predicado, respectivamente. É usado normalmente ao invés da combinação MAP + (OR/AND)
all (>3) [1,2,3,4,5]
any (==4) [1,2,3,4,5]
--iterate - Pega uma função de um valor inicial e vai acumulando ele eternamente... Daí usa um take, por exemplo pra pegar o valor.
take 10 $ iterate (*2) 1
-- splitAt - pega um número e quebra uma lista em duas tuplas com cada metade.
let (a,b) = splitAt 4 "WILLGLUK" in b ++ a --invertendo a string na maciota
-- takeWhile - conhecida já
-- dropWhile - Parecida com takeWhile, mas em vez de "pegar" enquanto for true, remove da lista enquanto for true
-- span - recebe uma função e uma lista também, mas retorna duas listas. Uma é o resultado de um takeWhile e a outra são os que "caíram fora" da validação do takeWhile
-- sort - recebe uma lista de Ord e ordena
-- group - pega uma lista de divide em uma lista de listas com todos os itens que são iguais. Agrupa os iguais, basicamente
-- inits e tails - cria uma lista recursivamente aplicando init e tail, até não sobrar mais nada. Retorna uma lista dos resultados parciais.
search :: (Eq a) =>  [a]-> [a] -> Bool
search needle haystack =
  let nlen = length needle
  in foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)
-- isInfixOf - basicamente a implementação acima. Procura uma lista dentro de uma lista. Tem isPrefixOf e isSuffixOf que vem o início e final, respectivamente.
-- elem e notElem verifica se um item está ou não, respectivamente, em uma lista.
-- partition - Recebe uma lista e predicado. Retorna primeira a lista que satisfaz o predicado e dps a que não.


import Geometry.Sphere as Sphere
import Geometry.Cuboid as Cuboid
import Geometry.Cube as Cube
