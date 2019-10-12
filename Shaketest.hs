import Control.Monad
import Development.Shake

main :: IO ()
main = shakeArgs shakeOptions $ do
    want ["foo/.bar"]

    "foo/.bar" %> \out -> do
        cmd_ "mkdir -p foo"
        ls <- liftIO $ getDirectoryFilesIO "." ["*"]
        liftIO $ putStrLn $ show ls
        void $ getDirectoryFiles "foo" ["*/.bar"]
        cmd_ "touch foo/.bar"
