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
-- typeclass constraint on tupe constructors
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
