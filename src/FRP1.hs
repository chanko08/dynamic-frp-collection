module Main (main) where
import Control.Applicative
import FRP.Sodium
import Engine

type TimeB = Behavior Int

bullet :: TimeB -> Reactive (Behavior Int)
bullet dtBeh = collect update 0 dtBeh
  where
    update dt x = (x+dt, x+dt)

main :: IO ()
main = run game

game :: Time -> Key -> Reactive (Behavior [Int]) 
game dtEv key = do
    dt <- hold 0 dtEv
    --first you need to develop a way to create bullets
    let spawn = filterE (==' ') key
    
    let create = execute $ (\_ -> bullet dt) <$> spawn
        keepList x xs = ((x:xs),(x:xs))

    --now keep a list of bullet behaviors in a behavior
    bulletBehs <- (collectE keepList [] create) >>= hold [] 

    --now collapse the list of bullet behaviors into a behavior of a list of
    --bullets

    bullets <- switch $ foldr (\b bs -> (:) <$> b <*> bs) (pure []) <$> bulletBehs

    return bullets
    



