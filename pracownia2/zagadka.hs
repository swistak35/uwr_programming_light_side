----------------------------------------------
--          Rafał Łasocha (258338)          --
--            Zagadka "A, B, C"             --
-- http://archiwum.wiz.pl/2001/01124800.asp --
----------------------------------------------

import Control.Monad
import Data.List
import Data.Maybe
import System.IO
import System.Environment (getArgs)

-- Types. Useful, they nicely describe how functions work.
type Elem = Char
type Row = [Elem]
type Board = [Row]

type Width = Int
type Height = Int
type ColumnPos = Int
type RowPos = Int
type FieldConfig = (RowPos, ColumnPos, Elem)
type Input = (Height, Width, Elem, [FieldConfig])

----- Generating initial board -----

-- Generates empty board (filled with '*')
generateEmptyBoard :: Width -> Height -> Board
generateEmptyBoard width 0 = []
generateEmptyBoard width height = (replicate width '*'):(generateEmptyBoard width (height-1))

-- Places letter in correct position in the row
insertElemInRow :: Row -> Elem -> ColumnPos -> Row
insertElemInRow xs letter pos = begin ++ (letter:end) where
  (begin, _:end) = splitAt (pos-1) xs

-- Places letter in correct position in the board
insertElemInBoard :: Board -> FieldConfig -> Board
insertElemInBoard (row:rows) (1, colPos, letter) = (insertElemInRow row letter colPos):rows
insertElemInBoard (row:rows) (rowPos, colPos, letter) = row:(insertElemInBoard rows ((rowPos-1),colPos,letter))

-- Takes full initial configuration from input and fill board (passed in argument)
--   with correct initial configuration fields
fillBoardWithConfig :: Board -> [FieldConfig] -> Board
fillBoardWithConfig board fieldConfigs = foldr (flip insertElemInBoard) board fieldConfigs

-- Function, which generate whole initial board based on input
generateInitialBoard :: Input -> Board
generateInitialBoard (height, width, maxLetter, fieldConfigs) = initBoard where
  emptyBoard = generateEmptyBoard width height
  initBoard = fillBoardWithConfig emptyBoard fieldConfigs

----- Generating correct solutions -----

-- Char generator - '*' means that every available letter may be here
chooseLetter :: Elem -> [Elem] -> [Elem]
chooseLetter '*' letters = letters
chooseLetter  c _ = [c]

-- Generates all correct rows based on initial row and possible letters
generateRow :: Row -> [Elem] -> [Row]
generateRow [] _ = [[]]
generateRow (x:xs) letters = [(letter:rest) | letter <- chooseLetter x letters, rest <- generateRow xs letters]

-- Counting how many given element occurs in row
-- Great example, that programmer can waste time on optimalization, but in the end,
--   haskell optimization can do it better (I tried Data.Map here to go only once through the list)
countElemInRow :: Row -> Elem -> Int
countElemInRow xs elem = length $ filter (== elem) xs

-- Checks if row is correct, I mean
-- if every element, which occurs in this row, occurs as frequently as other elements.
correctRow :: [Elem] -> Row -> Bool
correctRow letters xs = all (==first) amounts where
  (first:amounts) = filter (/=0) $ map (countElemInRow xs) letters

-- Checks if on the board there is at least one row or one column filled with only one letter
checkForFullOne :: Board -> Bool
checkForFullOne board = (checkForFullOneRow board) || (checkForFullOneRow $ transpose board)

-- Checks if on the board there is at least one row filled with only one letter
checkForFullOneRow :: Board -> Bool
checkForFullOneRow = any (\(first:rest) -> all (==first) rest)


---- Warning. Ugly functions.
---- I am aware that two functions below are ugly. I am sorry for them.
---- As a penance, I promise to write While interpreter during my holidays.

-- Generates correct rows
generateCorrectRow :: (Num a, Ord a) => Board -> (a, a) -> [Elem] -> [Board]
generateCorrectRow board@(row:rows) (spann, pos) letters
  | pos == 1 = [ newRow:rows | newRow <- generateRow row letters, correctRow letters newRow]
  | pos > spann = [board]
  | otherwise = [row:board' | board' <- generateCorrectRow rows (spann, pos-1) letters]

-- Generates board filled only with correct rows,
-- but not necessarily with one row/column filled with only one letter
generateBoard :: Board -> [Elem] -> (Height, RowPos) -> (Width, ColumnPos) -> [Board]
generateBoard board letters horizontal@(height, ypos) vertical@(width, xpos) = if ypos > height && xpos > width then return board else do
  newBoard  <- generateCorrectRow board horizontal letters
  newBoard' <- generateCorrectRow (transpose newBoard) vertical letters
  resBoard <- generateBoard (transpose newBoard') letters (height, ypos+1) (width, xpos+1)
  return resBoard

---- End of ugly functions declarations.

-- Generates completely correct boards
generateCorrectBoard :: Board -> [Elem] -> (Height, RowPos) -> (Width, ColumnPos) -> [Board]
generateCorrectBoard board letters horizontal vertical = [ newBoard |
  newBoard <- generateBoard board letters horizontal vertical,
  checkForFullOne newBoard ]

----- Solving the problem ------

-- Main function; solving the problem
solve :: Input -> [Board]
solve input@(height, width, maxLetter, _) = generateCorrectBoard initBoard letters (height,1) (width,1) where
  initBoard = generateInitialBoard input
  letters = ['A'..maxLetter]

-- Display one solution
displayBoard :: Board -> IO ()
displayBoard board = putStrLn $ aux board where
  aux [] = ""
  aux (row:rows) = row ++ ['\n'] ++ (aux rows)

-- Display all solutions
displayBoards :: [Board] -> IO ()
displayBoards [] = putStrLn "End."
displayBoards (board:boards) = do
  displayBoard board
  displayBoards boards

-- Parse content of the file, and return valid output
parseFile :: [Char] -> Input
parseFile contents = (height, width, maxLetter, fieldConfigs) where
  [height', width', maxLetter', fieldConfigs', _] = splitOn '.' contents
  height = read height' :: Height
  width = read width' :: Width
  maxLetter = read maxLetter' :: Elem
  fieldConfigs = read fieldConfigs' :: [FieldConfig]

-- Split a list into list of lists by some element.
splitOn :: (Eq a) => a -> [a] -> [[a]]
splitOn chr xs = begin:rest where
  (begin,end) = span (/=chr) xs
  rest = if null end then [] else splitOn chr $ tail end

-- Main function, called with running the program
main = do
  args <- getArgs
  let testFilePath = if null args then error "What we can do, without proper input, my dear friend?" else head args
  handle <- openFile testFilePath ReadMode
  contents <- hGetContents handle
  (displayBoards . solve . parseFile) contents
  hClose handle

-- Test inputs
-- If you wish, you can use these, just remember to uncomment below 'main' and comment version above.
--main = do
--  displayBoards $ solve testInput1
--  displayBoards $ solve testInput2
--  displayBoards $ solve testInput3
--  displayBoards $ solve testInput4

--testInput1 :: Input
--testInput1 = (2, 2, 'B', [(1,1,'A'),(2,1,'B')])

--testInput2 :: Input
--testInput2 = (4, 4, 'C', [(3,1,'B'), (4,1,'A'), (1,2,'B'), (4,2,'C'), (1,3,'C'), (2,4,'A')])

--testInput3 :: Input
--testInput3 = (2, 6, 'B', [(1,1,'A'),(2,1,'B'),(1,2,'B'),(2,2,'A'),(1,3,'A'),(2,3,'A'),(1,4,'B'),(2,4,'B'),(1,5,'A')])

--testInput4 :: Input
--testInput4 = (8, 8, 'D', [(1,1,'A'), (1,5,'C'), (2,3,'D'), (3,2,'C'), (3,5,'C'), (3,6,'D'), (4,3,'A'), (4,6,'D'),(5,2,'D'), (5,3,'D'), (6,1,'B'), (6,5,'B'), (1,2,'C'), (1,4,'D'), (2,1,'B'), (2,6,'B'), (3,3,'A'), (4,1,'A'), (1,6,'D'), (4,5,'C'), (5,5,'B'), (5,6,'B'), (6,3,'D'), (6,4,'D'), (2,4,'D'), (2,5,'B')])