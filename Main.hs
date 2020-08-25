{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}

module Main where

import Control.Lens
import Data.Aeson
import Data.Aeson.Lens
import Data.Aeson.Encode.Pretty
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Monoid (Any)
import Data.Text hiding (unlines)
import Data.Time.Clock
import Data.Foldable (find)
import Example
import Network.HTTP.Client
import Network.HTTP.Simple hiding (httpLbs)
import Network.HTTP.Types.Status (statusCode)
import Types

loginUrl :: String
loginUrl = "http://localhost:11780/radar/app/auth/login"

hasTeamName :: Text -> Value -> Bool
hasTeamName name = has (key "team" . key "name" . _String . only name)

mediaEnabledLens :: AsValue t => Traversal' t Value
mediaEnabledLens = key "team"
                 . key "targetWorkflowSettings"
                 . key "adverseMediaEnabled"

bt :: Value
bt = Bool True

getTeam :: Maybe Value -> Maybe Value
getTeam mv = mv >>= \v -> v ^? key "team"

main' :: IO ()
main' = B.putStrLn . j $ teamsResponseEx

j :: B.ByteString -> B.ByteString
j s = do
  let x :: Maybe Value = s ^? values . filtered (hasTeamName "Blue")
  let y :: Maybe Value = set mediaEnabledLens bt <$> x
  let z :: Maybe Value = getTeam y
  encodePretty z


main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

  now1 <- getCurrentTime

  let pairs = [ ("username", "decoy9697@gmail.com") , ("password", "Password123!") ]

  let loginRequest = setRequestHost "localhost"
                   $ setRequestPort 11780
                   $ setRequestPath "/radar/app/auth/login"
                   $ setRequestHeader "Content-Type" ["application/x-www-form-urlencoded"]
                   $ urlEncodedBody pairs defaultRequest

  loginResponse <- httpLbs loginRequest manager

  -- putStrLn $ "The status code was: " ++ show ( statusCode $ responseStatus loginResponse)

  -----------------------------------------------------------------------------

  let (jar1, _) = updateCookieJar loginResponse loginRequest now1 (createCookieJar [])
  -- putStrLn $ "new jar: " ++ show jar1

  let allTeamsRequest = setRequestMethod "GET"
                      $ setRequestHost "localhost"
                      $ setRequestPort 11780
                      $ setRequestPath "/radar/app/admin/teams"
                      $ setRequestHeader "Content-Type" ["application/json"]
                      $ setRequestHeader "Accept" ["application/json"]
                      defaultRequest
  now2 <- getCurrentTime
  let (request2, jar2) = insertCookiesIntoRequest allTeamsRequest jar1 now2

  allTeamsResponse <- httpLbs request2 manager

  -- putStrLn $ "\nThe status code was: " ++ show ( statusCode $ responseStatus allTeamsResponse)

  -- let mteams = decode (responseBody allTeamsResponse) :: Maybe TeamsResponse
  -- let mteam  = mteams >>= getTeam "Radar Team"

  -- print $ adverseMediaEnabled . targetWorkflowSettings <$> mteam

  -- Find team with team.name == 'Radar Team'
  -- change team.team.targetWorkflowSettings.adverseMediaEnabled = true
  -- POST team.team to  /radar/app/admin/team

  pure ()







