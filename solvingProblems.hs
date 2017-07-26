import Data.List

solveRPN :: (Num a) => String -> a
solveRPN = read . head . foldl foldingFunction [] .words
  where foldingFunction stack item =
