--A little deep intuition abou functors, applicative functors and monoids.
--Functor is something that can be mapped over
--Typeclass Functor has only one method
--fmap:: (a -> b) -> f a -> f b
--How IO is a functor?
{-
instance Functor IO where
        fmap f action = do
            result <- action
            return (f result)
-}
--fmap (++"!") getLine == getLine but with "!" appended

--Partial Functions are also Functors. Is the type (->) r, Normal functions are (->) r a, same as r -> a.
--fmap: (a -> b) -> (r -> a) -> (r -> b)   <---------- Function composition
--The output of (r -> a) is put inside (a -> b) and return (r -> b)
{-

instance Functor ((->) r) where  
    fmap f g = (\x -> f (g x))  

(if allowed)
instance Functor (r ->) where  
    fmap f g = (\x -> f (g x))  

    OR

instance Functor ((->) r) where
    fmap = (.)

SAMPLES:

fmap (*3) (+100) = Function that take a number
(*3) `fmap` (+100) = Same, using infix the resemblance with (.) is clear

-}
-- Remembering curried functions
-- We can say that fmap is a function that take a function and return another function that takes a functor and returns a functor.
-------------------------------------------------------------------------------------------------------------------------------------------

--Functor lawsss
{-
1. The first functor law states that if we map the id function over a functor, the functor that we get back should be the same as 
the original functor. Ex:

instance Functor Maybe where  
    fmap f (Just x) = Just (f x)  
    fmap f Nothing = Nothing  

2. The second law says that composing two functions and then mapping the resulting function over a functor should be the same as
first mapping one function over the functor and then mapping the other one. Ex:

A type constructor that is not a Functor

data CMaybe a = CNothing | CJust Int a deriving (Show)
instance Functor CMaybe where
    fmap fCNothing = CNothing
    fmap f (CJust counter x) = CJust (counter+1) (f x)

If we check the first law it will fail. It's deriving Functor but it's not a Functor.

-}
-------------------------------------------------------------------------------------------------------------------------------------------

--Applicative Functors
{-

Represented by Applicative typeclass, found in the Control.Applicative module. It's kind of a enhanced Functor.
Notes: mapping "multi-parameter" functions over functors get us functors that contain functions inside them

-}