module ReversePolishCalculator
    ( calculator
    ) where

import Control.Exception
import Control.Monad
import Data.Maybe (isNothing)
import Text.Regex (mkRegex, matchRegex)

type Stack = [Double]

-- Given An Expression In Reverse polish Notation, Print The Result If Possible Otherwise Throw An Error
evaluateExpression :: String -> IO ()
evaluateExpression string = do
    let stack = foldM buildStack [] $ words string
    case stack of Left _ -> throw $ userError "Invalid Exprssion!"
                  Right [v] -> putStrLn $ "Result Of Expression (" ++ string ++ "): " ++ show v
                  Right _ -> throw $ userError "Invalid Expression!"


-- Try To Update The Stack By Adding A Number Or Applying An Operator. May Throw An IOError If Invalid
-- Input Is Given. For Example, If An Operator Is Applied To A Stack With Fewer Than 2 Numbers.
buildStack :: Stack -> String -> Either IOError Stack
buildStack stack char
    | length stack < 2 && (char == "*" || char == "/" || char == "+" || char == "-") = Left (userError "Invalid Expression Given!")
    | isNothing (matchRegex (mkRegex "[*/+-0123456789.]") char) = Left (userError "Invalid Character Encountered!")
    | otherwise = Right (addToStack stack char)
    where addToStack (x:y:xs) "*" = x * y : xs
          addToStack (x:y:xs) "/" = y / x : xs
          addToStack (x:y:xs) "+" = x + y : xs
          addToStack (x:y:xs) "-" = y - x : xs
          addToStack xs a = read a : xs


-- If A Exception Occurs, Print To The Terminal
handler :: IOException -> IO()
handler = print


-- Given An Expression In Reverse polish Notation, Print The Result Or An Error If Invalid
calculator :: String -> IO ()
calculator expression = catch (evaluateExpression expression) handler