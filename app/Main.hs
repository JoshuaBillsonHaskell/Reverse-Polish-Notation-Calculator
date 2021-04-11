-- Author: Joshua Billson, 2021
-- Description: Prompt The User For An Expression In Reverse Polish Notation, Evaluate, And Print The Results. Repeat
-- Until EOF Is Encountered.

module Main where

import ReversePolishCalculator
import Control.Monad (forever)
import System.IO 

main :: IO ()
main = forever $ do
    putStr "Enter A Reverse Polish Expression: "
    hFlush stdout
    getLine >>= calculator