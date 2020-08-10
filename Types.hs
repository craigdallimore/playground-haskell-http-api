{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Types where

import GHC.Generics
import Data.Aeson
import Control.Monad

import Types.LoginResponse hiding (name)
import Types.MediaScreeningKeywordList hiding (name, id)
import qualified Data.Vector as V

foldString :: [String] -> String
foldString = foldr (\b a -> b ++ "\n" ++ a) "\n"

-------------------------------------------------------------------------------

data TargetWorkflowSettings = TargetWorkflowSettings
  { pepSanctionsEnabled :: Bool
  , pepSanctionsSources :: [String]
  , adverseMediaEnabled :: Bool
  }

instance FromJSON TargetWorkflowSettings where
  parseJSON (Object v) = TargetWorkflowSettings <$>
                       v .: "pepSanctionsEnabled" <*>
                       v .: "pepSanctionsSources" <*>
                       v .: "adverseMediaEnabled"
  parseJSON _          = mzero

instance Show TargetWorkflowSettings where
  show t = "\npepSanctionsEnabled: " ++ (show . pepSanctionsEnabled) t
        ++ "\npepSanctionsSources: " ++ foldr (\b a -> b ++ "\n" ++ a) "\n" (pepSanctionsSources t)
        ++ "\nadverseMediaEnabled: " ++ (show . adverseMediaEnabled) t

-------------------------------------------------------------------------------

data RadarClassicSettings = RadarClassicSettings
  { flags :: [String]
  , monitoringEnabled :: Bool
  , dataSourceProviders :: [String]
  , dataSourceSettings :: Object
  }

instance FromJSON RadarClassicSettings where
  parseJSON (Object v) = RadarClassicSettings <$>
                       v .: "flags" <*>
                       v .: "monitoringEnabled" <*>
                       v .: "dataSourceProviders" <*>
                       v .: "dataSourceSettings"
  parseJSON _          = mzero

instance Show RadarClassicSettings where
  show r = "\nmonitoringEnabled: " ++ (show . monitoringEnabled) r
        ++ "\nflags: " ++ foldString (flags r)
        ++ "\ndataSourceProviders: " ++ foldString (dataSourceProviders r)
        ++ "\ndataSourceSettings" ++ show (dataSourceSettings r)

-------------------------------------------------------------------------------

data Team = Team
  { name :: String
  , timeZone :: String
  , targetWorkflowSettings :: TargetWorkflowSettings
  , radarClassicSettings :: RadarClassicSettings
  , mediaScreeningKeywordLists :: [MediaScreeningKeywordList]
  , tenant :: String
  , id :: TeamId
  }

instance FromJSON Team where
  parseJSON (Object v) = Team <$>
                     v .: "name" <*>
                     v .: "timeZone" <*>
                     v .: "targetWorkflowSettings" <*>
                     v .: "radarClassicSettings" <*>
                     v .: "mediaScreeningKeywordLists" <*>
                     v .: "tenant" <*>
                     v .: "id"
  parseJSON _        = mzero

instance Show Team where
  show t = "\nname: " ++ name t
        ++ "\ntimeZone: " ++ timeZone t
        ++ "\ntargetWorkflowSettings: " ++ (show . targetWorkflowSettings ) t
        ++ "\nradarClassicSettings: " ++ (show . radarClassicSettings ) t
        ++ "\nmediaScreeningKeywordsLists: " ++ concatMap show (mediaScreeningKeywordLists t)
        ++ "\ntenant: " ++ tenant t
        ++ "\nid: " ++ Types.id t

-------------------------------------------------------------------------------

data TeamsItem = TeamsItem
  { enabledUserCount :: Int
  , userCount :: Int
  , team :: Team
  }

instance FromJSON TeamsItem where
  parseJSON (Object v) = TeamsItem <$>
                     v .: "enabledUserCount" <*>
                     v .: "userCount" <*>
                     v .: "team"
  parseJSON _        = mzero

instance Show TeamsItem where
  show t = "\nenabledUserCount: " ++ (show . enabledUserCount $ t)
        ++ "\nuserCount: " ++ (show . userCount $ t)
        ++ "\nteam: " ++ show (team t)

-------------------------------------------------------------------------------

data TeamsResponse = TeamsResponse [TeamsItem] deriving (Show, Generic, FromJSON)
