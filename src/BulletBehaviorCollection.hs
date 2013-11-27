module Main (main) where
import Control.Applicative
import FRP.Sodium
import Engine

normalBullet :: Time -> Reactive (Behavior Int)
normalBullet dt = collectE update 0 dt >>= hold 0
  where
    update t x = (x + t, x + t)

staticBullet :: Reactive (Behavior Int)
staticBullet = return $ pure 0


game :: Time -> Key -> Reactive (Behavior [Int]) 
game dt key = do
    let spawnNormal = filterE (==' ') key
        createNormal = execute $ (\_ -> normalBullet dt) <$> spawnNormal

        spawnStatic = filterE (=='b') key
        createStatic = execute $ (\_ -> staticBullet) <$> spawnStatic

        bEvs = merge createNormal createStatic

        keepList x xs = (x:xs, x:xs)  


    bBehs <- (collectE keepList [] bEvs) >>= hold [] 
        
        
    bs <- switch $ foldr (\b bs -> (:) <$> b <*> bs) (pure []) <$> bBehs      
    return $ bs 

main :: IO ()
main = run game
