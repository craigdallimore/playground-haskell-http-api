{-# LANGUAGE DeriveGeneric #-}

module Types.LoginResponse where

import Data.Aeson
import Control.Monad
import GHC.Generics

type TeamId = String

data TeamHint = TeamHint
  { teamId :: TeamId
  , teamName :: String
  } deriving (Generic, Show)

data LoginResponse = LoginResponse
  { name :: String
  , requiresTeamSelection :: Bool
  , teams :: [TeamHint]
  } deriving (Generic, Show)

instance ToJSON TeamHint where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON TeamHint

instance ToJSON LoginResponse where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON LoginResponse


