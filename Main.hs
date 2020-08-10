{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson
import Types
import Network.HTTP.Client
import Network.HTTP.Simple hiding (httpLbs)
import Network.HTTP.Types.Status (statusCode)
import Data.Time.Clock

loginUrl :: String
loginUrl = "http://localhost:11780/radar/app/auth/login"

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

  putStrLn $ "The status code was: " ++ show ( statusCode $ responseStatus loginResponse)

  -----------------------------------------------------------------------------

  let (jar1, _) = updateCookieJar loginResponse loginRequest now1 (createCookieJar [])
  putStrLn $ "new jar: " ++ show jar1

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

  putStrLn $ "\nThe status code was: " ++ show ( statusCode $ responseStatus allTeamsResponse)
  print $ responseBody allTeamsResponse

  -- Find team with team.name == 'Radar Team'
  -- change team.team.targetWorkflowSettings.adverseMediaEnabled = true
  -- POST team.team to  /radar/app/admin/team








