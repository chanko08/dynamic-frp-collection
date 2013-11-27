module Engine
    ( Time
    , Key
    , Game
    , run 
    )
  where


import FRP.Sodium

type Time = Event Int
type Key  = Event Char
type Game a = Time -> Key -> Reactive (Behavior a) 

run :: Show a => Game a -> IO ()
run game = do
    (dtEv, dtSink)   <- sync newEvent
    (keyEv, keySink) <- sync newEvent
    g <- sync $ do

        game' <- game dtEv keyEv
        return game'

    go g dtSink keySink
    return ()
  where
    go gameB dtSink keySink = do
        sync $ dtSink 1
        
        ks <- getLine
        mapM_ (sync . keySink) ks

        v <- sync $ sample gameB
        print v

        go gameB dtSink keySink
 
