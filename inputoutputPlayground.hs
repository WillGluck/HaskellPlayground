-- Main always has a type of IO Something. IO (), IO String...
import Data.Char
import System.Directory
import Data.List
import Control.Monad
import System.IO


{-
main = do
  putStrLn "Hello World"                        -- foo <- putStrLn "Hello World" (is the same thing)
  putStrLn "What's your first name?"
  firstName <- getLine -- name is now a untainted
  putStrLn "What's your last name?"
  lastName <- getLine
  let bigFirstName = map toUpper firstName
      bigLastName = map toUpper lastName
  putStrLn ("Hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?")
-}

-- Every IO action has a result encapsulated within it. The <- untaint the value.
-- name = getLine is just giving the IOACtion a different name.

{-
main = do
  line <- getLine
  if null line
    then return() --Takes something and create a IO action. So return "String" creates a IO String. You can use alto "then do xxx"
    else do --Use do because there is two IO actions
      putStrLn $ reverseWords line
      main --Call main again
-}
reverseWords :: String -> String
reverseWords = unwords . map reverse .words
{-
main = do
  return () -- does nothing
  return "HAHAHA" -- does nothing
  line <- getLine
  return "BLAH BLAH" -- does nothing
  return 4 -- does nothing
  putStrLn line

main = do
  a <- return "Hell"
  b <- return "Yeah"
  putStrLn $ a ++ " " ++ b
-}

--putStr / putStrLn - no line / with line
--putChar
--print -> takes a SHOW typeclass value , call show, and call putStrLn
--getChar

{-
main = do
  c <- getChar
  if c /= ' '
    then do
      putChar c
      main
    else return()
-}

--when - from Control.Monad. Receives a boolean and a IOAction. If true, execute the action, if not execute a return()
--Rewriting last main with when.

{-
main = do
  c <- getChar
  when (c /= ' ') $ do
    putChar c
    main
-}
--sequence -> get a lists of IO actions and return a IO action with a list of the results.
{-
main = do
  a <- getLine
  b <- getLine
  c <- getLine
  print [a, b, c]
--same as
main = do
  rs <- sequence [getLine getLine getLine]
  print rs
-}

--mapM - takes a function and a list, maps the function over a list and then sequences it.
--mapM_ - same, but throws the result away.

--forever - takes and IO action and repeats forever
-- this will execute forever.
{-
main = forever $ do
  putStr "Give me some input: "
  l <- getLine
  putStrLn $ map toUpper l
-}

-- formM - just like mapM, but the parameters are switched around. WHy? let's see
{-
main = do
  colors <- forM [1,2,3,4] (\a -> do
    putStrLn $ "Wich color do ou associate with the number " ++ show a ++ "?"
    color <- getLine
    return color) --returns IO action so the <- bind the value
  putStrLn "The colors that you associate with 1, 2, 3 and 4 are:"
  mapM putStrLn colors
-}

--NOTES: remember putStrLn is not a function that prints. Is a function that receives a String and return a IO String action.
--When this IO action is performed a string is printed on the screen.

-- Files and Streams

-- getContents - getLine until it reach EOF
-- Replace for the example using forever before.
{-

main = do
  contents <- getContents
  putStr (map toUpper contents)
-}


-- Using getContents and interact, and then a very simple way using function application and composition (three mains)
{-

main = do
  contents <- getContents
  putStr (shortLinesOnly contents)

main = interact shortLinesOnly

shortLinesOnly :: String -> String
shortLinesOnly input =
  let allLines = lines input
      shortLines = filter (\line -> length line < 10) allLines
      result = unlines shortLines
  in result

main = interact $ unlines . filter ((<10) . length) .lines
-}

-- respondPalindromes...
respondPalindromes = unlines . map (\xs -> if isPalindrome xs then "palindrome" else "not palindrome") . lines
  where isPalindrome xs = xs == reverse xs

--main = interact respondPalindromes

{-
main = do
  handle <- openFile "filePath" ReadMode -- data IOMode = ReadMode | WriteMode | AppendMode | ReadWriteMode
  contents <- hGetContents handle
  putStr contents
  hClose handle
-}

--Alternative using withFile

{-
main = do
  withFile "filePath" ReadMode (\handle -> do
    contents <- hGetContents handle
    putStr contents)
-}


--Insight of the withFile method
{-
withFile' :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
withFile' path mode f = do
  handle <- openFile path module
  result <- f handle
  hClose handle
  return result
-}

-- just like we have hGetContents that works like getContents, there is hGetLine, hPutStr, hPutStrLn, hGetChar, etc...

-- readFile - quick way to open a file, get the content and close it.
{-
main = do
  contents <- readFile "filePath"
  putStr contents
-}

-- writeFile - Sample taking a file and rewriting it with uppercase
-- ALWAYS RESET TO POSITION ZERO
{-
main = do
  contents <- readFile "filePath"
  writeFile "filePath" (map toUpper contents)
-}

-- appendFile - Same as writeFile, but dont reset the cursor to position zero.

--WithFile is lazy. Usually, the buffer size for files is a line, but it can be changed using hSetBuffering (takes a handle and a BufferMode)
--BufferMode = NoBuffering | LineBuffering | BlockBuffering (Maybe Int) // bytes

{-
main = do
  withFile "filePath" ReadMode (\handle -> do
    hSetBuffering handle $BlockBuffering (Just 2048)
    contents <- hGetContents handle
    putStr contents)
-}

-- hFlush - Faz o flush que o BlockBuffering define manualmente.

main = do
  handle <- openFile "filePath" ReadMode
  (tempName, tempHandle) <- openTempFile "folderPath" "tempFilePartialAlias"
  contents <- hGetContents handle
  let todoTasks = lines contents
      numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
  putStrLn "There are your TO-DO items:"
  putStr $ unlines numberedTasks
  putStrLn "Wich one do you want to delete?"
  numberString <- getLine
  let number = read numberString
      newTodoItems = delete (todoTasks !! number) todoTasks
  hPutStr tempHandle $ unlines newTodoItems
  hClose handle
  hClose tempHandle
  removeFile "filePath"
  renameFile tempName "filePath"
