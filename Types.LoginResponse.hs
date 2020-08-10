{-# LANGUAGE OverloadedStrings #-}
module Types.LoginResponse where

import Data.Aeson
import Control.Monad

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

instance FromJSON TeamHint where
  parseJSON (Object v) = TeamHint <$>
                       v .: "teamId" <*>
                       v .: "teamName"
  parseJSON _          = mzero

instance FromJSON LoginResponse where
  parseJSON (Object v) = LoginResponse <$>
                       v .: "name" <*>
                       v .: "requiresTeamSelection" <*>
                       v .: "teams"
  parseJSON _          = mzero

instance Show LoginResponse where
  show lr = "\nname: " ++ name lr
         ++ "\nrequiresTeamSelection: " ++ (show . requiresTeamSelection $ lr)
         ++ "\nteams: " ++ concatMap show (teams lr)


instance Show TeamHint where
  show th = "\nteamId: " ++ teamId th
         ++ "\nteamName: " ++ teamName th
