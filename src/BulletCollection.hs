{-# LANGUAGE RecursiveDo #-}
module Main (main) where
import Control.Applicative
import FRP.Sodium
import Engine

data GEvent = Alter ([Int] -> [Int])

game :: Time -> Key -> Reactive (Behavior [Int])
game dt key = do
    let spawn = const (Alter (\xs -> (0:xs))) <$> filterE (==' ') key
        update = (\t -> Alter (\xs -> map (+t) xs)) <$> dt
        applyAlter (Alter f) xs = f xs
    
    rec
        bs <- hold [] $ snapshotWith applyAlter (merge spawn update) bs 
          

    return bs 


main :: IO ()
main = run game
