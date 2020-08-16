{-# LANGUAGE DeriveGeneric, DeriveAnyClass, TemplateHaskell #-}

module Types where

import Control.Lens
import Control.Monad
import Data.Aeson
import GHC.Generics

import Types.LoginResponse hiding (name)
import Types.MediaScreeningKeywordList hiding (name, id)

-------------------------------------------------------------------------------

data TargetWorkflowSettings = TargetWorkflowSettings
  { pepSanctionsEnabled :: Bool
  , pepSanctionsSources :: [String]
  , adverseMediaEnabled :: Bool
  } deriving (Show, Generic, ToJSON, FromJSON)


-------------------------------------------------------------------------------

data RadarClassicSettings = RadarClassicSettings
  { flags :: [String]
  , monitoringEnabled :: Bool
  , dataSourceProviders :: [String]
  , dataSourceSettings :: Object
  } deriving (Show, Generic, ToJSON, FromJSON)

-------------------------------------------------------------------------------

data Team = Team
  { name :: String
  , timeZone :: String
  , targetWorkflowSettings :: TargetWorkflowSettings
  , radarClassicSettings :: RadarClassicSettings
  , mediaScreeningKeywordLists :: [MediaScreeningKeywordList]
  , tenant :: String
  , id :: TeamId
  } deriving (Show, Generic, ToJSON, FromJSON)

makeLenses ''Team

-------------------------------------------------------------------------------

data TeamsItem = TeamsItem
  { enabledUserCount :: Int
  , userCount :: Int
  , team :: Team
  } deriving (Show, Generic, ToJSON, FromJSON)

newtype TeamsResponse = TeamsResponse [TeamsItem] deriving (Show, Generic, ToJSON, FromJSON)
