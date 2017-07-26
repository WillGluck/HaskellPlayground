-- Main always has a type of IO Something. IO (), IO String...
import Data.Char
import System.Directory
import Data.List
import Control.Monad
import System.IO
import System.Environment
import System.Random
import Control.Monad()
import qualified Data.ByteString.Lazy as B
import System IO.Error

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
--reverseWords :: String -> String
--reverseWords = unwords . map reverse .words
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
--respondPalindromes = unlines . map (\xs -> if isPalindrome xs then "palindrome" else "not palindrome") . lines
--  where isPalindrome xs = xs == reverse xs

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
{-
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
-}

-- COMMAND LINE ARGUMENTS
-- getArgs (returns a IO [String]) and getProgramName (returns a IO String)

--Lets create a main to add, remove and view tasks. Ex: todo add todo.txt "Find the magic sword of power"



{------------------------------------------------------------------------------------------

dispatch :: [(String, [String] -> IO ())]
dispatch = [
    ("add", add),
    ("view", view),
    ("remove", remove)
  ]

main = do
  (command:args) <- getArgs --Uses pattern matching to get the action to be performed
  let (Just action) = lookup command dispatch --Look for the action string in the map. Uses patterh matching again to extract the action from the Maybe
  action args

add :: [String] -> IO()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO()
view [fileName] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
  putStr $ unlines numberedTasks

remove :: [String] -> IO()
remove [fileName, numberString] = do
  handle <- openFile fileName ReadMode
  (tempName, tempHandle) <- openTempFile "." "temp"
  contents <- hGetContents handle
  let number = read numberString
      todoTasks = lines contents
      newTodoItems = delete (todoTasks !! number) todoTasks
  hPutStr tempHandle $ unlines newTodoItems
  hClose handle
  hClose tempHandle
  removeFile fileName
  renameFile tempName fileName

------------------------------------------------------------------------------------------}
--Randomness
--RandomGen typeclass - indicate a "random" generator
--Random typeclass - value that can be random (boolean, numbers, etc...)
--random function - takes a RandomGen and returns a (Random, RandomGen) - Need to know the type of the RandomGen and Random when called.

threeCoins :: StdGen -> (Bool, Bool, Bool)
threeCoins gen =
  let (firstCoin, newGen) = random gen --Don't need the type because the function already has a type declaration.
      (secondCoin, newGen') = random newGen
      (thirdCoin, newGen'') = random newGen'
  in (firstCoint, secondCoin, thirdCoin)

--Forever loop of random values.
randoms' :: (RandomGen g, Random a) => g -> [a]
randoms' gen = let (value, newGen) = random' gen in value:randoms' newGen

finiteRandoms :: (RandomGen g, Random a, Num n) => n -> g -> ([a], g)
finiteRandoms 0 gen = []
finiteRandoms n gen =
  let (value, newGen) = random gen
      (restOfList, finalGen) = finiteRandoms (n-1) newGen
  in (value:restOfList, finalGen)

--Just like random, but it takes lower and upper bounds.
--randomR:: (RandomGen g, Random a) :: (a, a) -> g -> (a, g)

--randomRs - Is kind of the randoms of the randomR. Takes bounds but return a stream of random values.

-- getStdGen - return a value of IO StdGen type. If called twice in the same execution will return the same RandomGen
-- newStdGen - return a new RandomGen and update the global one.

--Guess my number "appzinho" Version 1
{-
main = do
    gen <- getStdGen
    askForNumber gen

askForNumber :: StdGen -> IO()
askForNumber gen = do
  let (randomNumber, newGen) = randomR (1,10) gen :: (Int, StdGen)
  putStr "Wich number in the range from 1 to 10 am I thinking of?"
  numberString <- getLine
  when (not $ null numberString) $ do
    let number = reads numberString
    if randomNumber == number
      then putStrLn "You are correct!"
      else putStrLn $ "Sorry, it was " ++ show randomNumber
    askForNumber newGen
-}

--Guess my number "appzinho" Version 2
{-
main = do
  gen <- getStrGen
  let (randomNumber, _) = randomR (1,10) gen :: (Int, StdGen)
  putStr "Wich number in the range from 1 to 10 am I thinking of?"
  numberString <- getLine
  when (not $ null numberString) $ do
    let number = reads numberString
    if randomNumber == number
      then putStrLn "You are correct!"
      else putStrLn $ "Sorry, it was " ++ show randomNumber
    newStdGen
    main
-}

-- Bytestrings
-- Alternative to deal with files when optimization is needed.
-- It Has the lazy and the strict version. THh lazy uses 64 bytes chunks, instead of 8 bytes.

{-
main = do
  (fileName1:fileName2:_) <- getArgs
  copyFile fileName1 fileName2

copyFile :: FilePath -> FilePath -> IO()
copyFile source dest = do
  contents <- B.readFile source
  B.writeFile dest contents
-}

-- Exceptions. Haskell has exceptions and the Monads Maybe (Just x or Nothing) and Either

-- doesFileExist check returns a IO Bool that indicate if the file exists.
{-
main = do (fileName:_) <- getArgs
          fileExists <- doesFileExist fileName
          if fileExists
            then do contents <- readFile fileName
                    putStrLn % "The file has " ++ show (length (lines contents)) ++ " lines!"
            else do putStrLn "The file doesn't exist!"
-}

-- catch action handle
{-
main  = toTry `catch` handler
toTry :: IO()
toTry = do (fileName:_) <- getArgs
           contents <- readFile fileName
           putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
handler :: IOError -> IO()
handler e = putStrLn "Whoops, had some trouble!"
-}

-- catch cheking the type of the exception
-- isDoesNotExistError - indicates that the error happen because the file didn't exist
-- ioError - takes a IOError and return a IO a (anything)
main = toTry `catch` handler

toTry :: IO ()
toTry = do
  (fileName:_) <- getArgs
  contents <- readFile fileName
  putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"

--isAlreadyExistsError, isDoesNotExistError, isAlreadyInUseError, isFullError, isEOFError, isIllegalOperation, isPermissionError, isUserError
-- ex: ioError $ userError "remote computer unplugged!" <- throws a error with a custom message

{-
handler :: IOError -> IO ()
handler e
  | isDoesNotExistError e = putStrLn "The file doesn't exist!"
-- | Other checks is....
  | otherwise = ioError e
-}

--ioGetFileName to get the path of the fileName

handler :: IOError -> IO()
handler e
  | isDoesNotExistError e =
    case ioeGetFileName e of
      Just path -> putStrLn $ "Whoops! File does not exist at: " ++ path
      Nothing -> putStrLn $ "Whoops! File does not exists at unkown location!"
  | otherwise = ioError e
