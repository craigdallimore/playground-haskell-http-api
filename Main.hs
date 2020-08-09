{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson
import Network.HTTP.Client
import Network.HTTP.Simple hiding (httpLbs)
import Network.HTTP.Types.Status (statusCode)
import Data.Time.Clock

type TeamId = String

data TeamHint = TeamHint
  { teamId :: TeamId
  , teamName :: String
  }

data LoginResponse = LoginResponse
  { name :: String
  , requiresTeamSelection :: Bool
  , teams :: [TeamHint]
  }

data TargetWorkflowSettings = TargetWorkflowSettings
  { pepSanctionsEnabled :: Bool
  , pepSanctionsSources :: [String]
  , adverseMediaEnabled :: Bool
  }

data RadarClassicSettings = RadarClassicSettings
  { flags :: [String]
  , monitoringEnabled :: false
  , dataSourceProviders :: [String]
  , dataSourceSettings :: Maybe Object
  }

data MediaScreeningKeywordList = MediaScreeningKeywordList
  { id :: String
  , name :: String
  , keywords :: [String]
  }

data Team = Team
  { name :: String
  , timeZone :: String
  , targetWorkflowSettings :: TargetWorkflowSettings,
  , radarClassicSettings :: RadarClassicSettings,
  , mediaScreeningKeywordLists :: [MediaScreeningKeywordList]
  , tenant :: String
  , id :: TeamId
  }

data TeamsResponse =
  { enabledUserCount :: Int
  , team :: [Team]
  }

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








