-- Main always has a type of IO Something. IO (), IO String...
import Data.Char

main = do
  putStrLn "Hello World"                        -- foo <- putStrLn "Hello World" (is the same thing)
  putStrLn "What's your first name?"
  firstName <- getLine -- name is now a untainted
  putStrLn "What's your last name?"
  lastName <- getLine
  let bigFirstName = map toUpper firstName
      bigLastName = map toUpper lastName
  putStrLn ("Hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?")


-- Every IO action has a result encapsulated within it. The <- untaint the value.
-- name = getLine is just giving the IOACtion a different name.
