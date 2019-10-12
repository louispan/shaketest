import Control.Monad
import Development.Shake

main :: IO ()
main = shakeArgs shakeOptions $ do
    want ["foo/.bar"]

    "foo/.hello" %> \out -> do
        cmd_ "touch foo/.hello"

    "foo/.bar" %> \out -> do
        cmd_ "mkdir -p foo"
        ls <- liftIO $ getDirectoryFilesIO "." ["*"]
        liftIO $ putStrLn $ show ls
        void $ getDirectoryFiles "foo" ["*/.hello"]
        cmd_ "touch foo/.bar"
