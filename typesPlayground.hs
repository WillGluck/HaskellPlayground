--Defining types

-- Intro

import qualified Data.Map as Map

--data Bool = False | True
--data Int = -2147483648 | -2147483647 | ... | -1 | 0 | 1 | 2 | ... 2147483647

data Point = Point Float Float deriving (Show)
--data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show) -- The Shape type is part of the Show typeclass
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

--Circle and Rectangle are value constructors
--Shape is a type

--Calculate the surface
surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

--Move the shape in the x/y axis
nudge :: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) a b = Circle (Point (x+a) (y+b)) r
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1 + a) (y1 + b)) (Point (x2 + a) (y2  + b))

baseCircle :: Float -> Shape
baseCircle r = Circle (Point 0 0) r

baseRect :: Float -> Float -> Shape
baseRect width height = Rectangle (Point 0 0) (Point width height)

{-
module Shapes
( Point(..) -- Point -> No value constructor function is exported. It is a good practice - more abstract. But don't allow pattern matching
, Shape(..) -- Shape -> '' - ''
, surface,
, nudge
, baseCircle
, baseRect
) where
-}

-- Record Syntax

--First name, last name, age, height, phone number and favorite ice-cream flavor
--data Person = Person String String Int Float String String deriving (Show)

--firstName :: Person -> String
--firstName (Person firstName _ _ _ _ _) = firstName

--lastName :: Person -> String
--lastName (Person _ lastName _ _ _ _) = lastName

-- etc...
--Solution - Avoid access methods and improve Show

{-
data Person = Person {
  firstName :: String,
  lastName :: String,
  age :: Int,
  height :: Float,
  phoneNumber :: String,
  flavor :: String
} deriving (Show)
-}

--Type parameters
-- type constructors...
--data Maybe a = Nothing | Just a -> Maybe is a Type constructor. If "a" is a char, the type will be Maybe Char. Nothing is polymorphic
-- [] is a type constructor -> [Char], [Int]...
-- typeclass constraint on type constructors
-- data (Ord k) => Map k v = ...
-- but the convention is "never add typeclass constraints in data declarations". Because then every method to map will have to need respect that typeclass, even when they don't care.
-- Lets create a data with type constructors -> Type constructors "=" left side. Value constructors "=" right side (possubly separated by "|"'s)
data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

vecMult :: (Num t) => Vector t -> t -> Vector t
(Vector i j k) `vecMult` m = Vector (i*m) (j*m) (k*m)

scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n

-- We put only one Type for each vector, because he have just one type in the type constructor.

-- Derived Instances

data Person = Person {
  firstName :: String,
  lastName :: String,
  age :: Int
} deriving (Eq, Show, Read)

-- Eq Show Read
-- let beatles = [john, paul, ringo, harrison]
-- ringo `elem` beatles -> True
-- Read need explicit type annotation when cannot use type inference
-- read "..." :: Person. Or "..." == ringo
-- When reading a parameterized type, you need to fill in the type parameter -> read "Just" :: Maybe Char

-- Ord
-- When deriving type Ord and comparing two value constructors of the same type, the first declared is taken as the smaller.
-- data Bool = False | True deriving (Ord) -> True > False -> True

-- When all the values constructors take no parameters / fields, it can be part of Enum and Bounded
data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
  deriving (Eq, Show, Read, Ord, Bounded, Enum)

-- Type synonyms

-- type String = [Char]
-- type PhoneBook = [(String, String)]
type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)]
-- inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
-- Parameterized
type AssocList k v = [(k,v)] --Type Constructor. Just like "Maybe"
-- Just like functions, type constructos can be partially applied
--type IntMap v = Map.Map Int v
type IntMap = Map.Map Int -- Same
-- data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)

data LockerState = Taken | Free deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber lockerMap =
  case Map.lookup lockerNumber lockerMap of
    Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
    Just (state, code) -> if state /= Taken
                            then Right code
                            else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"


-- Recursive Data Structures

--data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord) -- Cons is like ":" of lists
--data List a = Empty | Cons { listHead :: a, listTail :: List a} deriving (Show, Read, Eq, Ord) -- Verbose way
infixr 5 :-: -- infixr - right associative, fixity value is 5.
data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)

--infixr 5 ++
--(++) :: [a] -> [a] -> [a]
--[] ++ ys = ys
--(x:xs) ++ ys = x : (x ++ ys)

infixr 5 .++
(.++) :: List a -> List a -> List a
Empty .++ ys = ys
(x :-: xs) .++ ys = x :-: (xs .++ ys)
-- Pattern matching is about matching constructors. It work only on constructors. 8, 'a' are constructors for numeric and character types.

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree =  singleton x
treeInsert x (Node a left right)
  | x == a = Node x left right
  | x < a = Node a (treeInsert x left) right
  | x > a = Node a left (treeInsert x right)

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
  | x == a = True
  | x < a = treeElem x left
  | x > a = treeElem x right


-- Typeclasses 102

--Functions body is not mandatory, just the type declarations.

{-
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  x == y = not (x /= y) --Mutual recursion
  x /= y = not (x == y)
-}

data TrafficLight = Red | Yellow | Green

-- If we didn't had the function body as before, we would have to create a pattern to every == and every !=. Haskell wouldn't know how the two functions are related.
-- Same as deriving Eq
instance Eq TrafficLight where
  Red == Red = True
  Yellow == Yellow = True
  Green == Green = True
  _ == _ = False

-- Not the same as deriving Show, because whe created a custom String value.
instance Show TrafficLight where
  show Red = "Red Light"
  show Yellow = "Yellow Light"
  show Green = "Green Light"

-- class (Eq a) => Num a where... <- typeclasses that are subclasses of other typeclasses.

{-
instance (Eq m) => Eq (Maybe m) where
  Just x == Just y = x == y
  Nothing == Nothing = True
  _ == _ = False
-}

-- :info YourTypeClass, :info (types and types constructors)

-- Creating a Yes-Not Typeclass

class YesNo a where
  yesno :: a -> Bool

instance YesNo Int where
  yesno 0 = True
  yesno _ = False

instance YesNo [a] where
  yesno [] = False
  yesno _ = True

instance YesNo Bool where
  yesno = id -- Return the same value... so True is True and False is False d'oh

instance YesNo (Maybe a) where
  yesno (Just _) = True
  yesno Nothing = False

instance YesNo (Tree a) where
  yesno EmptyTree = False
  yesno _ = True

instance YesNo TrafficLight where
  yesno Red = False
  yesno _ = True

yesnoIf :: (YesNo y) => y -> a -> a -> a
yesnoIf yesnoVal yesResult noResult = if yesno yesnoVal then yesResult else noResult

-- The Functor typeclass
-- Types that can act like a box can be functors (Map, Set, Maybe and even our Tree type)
{-
class Functor f where -- F is not a concrete type oO
  fmap :: (a -> b) -> f a -> f b

instance Functor [] where
  fmap = map

instance functor Maybe where
  fmap f (Just x) = Just (f x)
  fmap f Nothing = Nothing
-}

instance Functor Tree where
  fmap f EmptyTree = EmptyTree
  fmap f (Node a left right) = Node (f a) (fmap f left) (fmap f right)

{-
instance Functor (Either a) where
  fmap f (Right x) = Right (f x)
  fmap f (Left x) = Left x
-}

-- :k is kind of a type.
-- Types are the labels of values and kinds are the labels of tyoes,
-- Kinds and some type-foo < - Read again later.
