import Control.Monad
import Development.Shake
import System.Exit

main :: IO ()
main = shakeArgs shakeOptions $ do
    want ["foo/.done"]

    -- run work with same key to avoid re-running for each need
    work <- newCache $ \_ -> do
        liftIO $ putStrLn "touching"
        cmd_ "mkdir -p foo/1"
        cmd_ "mkdir -p foo/2"
        cmd_ "touch foo/1/.bar"
        cmd_ "touch foo/2/.bar"

    "foo/*/.bar" %> \out -> work "once only"

    "foo/.once" %> \out -> do
        work "once only"
        cmd_ "touch foo/.once"

    "foo/.done" %> \out -> do
        need ["foo/.once"]
        Stdout ls <- cmd "find foo -name .bar"
        need $ words ls
        cmd_ "touch foo/.done"
