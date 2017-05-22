--Defining types

-- Intro

--data Bool = False | True
--data Int = -2147483648 | -2147483647 | ... | -1 | 0 | 1 | 2 | ... 2147483647

data Point = Point Float Float deriving (Show)
--data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show) -- The Shape type is part of the Show typeclass
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

--Circle e Rectangle are value constructors
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

data Person = Person {
  firstName :: String,
  lastName :: String,
  age :: Int,
  height :: Float,
  phoneNumber :: String,
  flavor :: String
} deriving (Show)
