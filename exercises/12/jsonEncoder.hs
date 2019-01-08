joinWith :: String -> [String] -> String
joinWith _ [] = ""
joinWith _ [x] = x
joinWith separator (x:xs) = x ++ separator ++ joinWith separator xs

data Text = Text String

data Option t = None | Some t

data Student = Student { name :: Text, number :: Integer, age :: Int }

class ToJson t where
  toJson :: t -> String
  toJson _ = "null"

instance ToJson Int where
  toJson int = show int

instance ToJson Integer where
  toJson integer = show integer

instance ToJson Float where
  toJson float = show float

instance ToJson Double where
  toJson double = show double

instance ToJson Bool where
  toJson True = "true"
  toJson _ = "false"

instance ToJson ()

instance ToJson t => ToJson [t] where
  toJson list = "[" ++ joinWith ", " (map toJson list) ++ "]"

instance ToJson Text where
  toJson (Text string) = show string

instance ToJson t => ToJson (Option t) where
  toJson (Some x) = toJson x
  toJson _ = "null"

instance ToJson t => ToJson (Maybe t) where
  toJson (Just x) = toJson x
  toJson _ = "null"

instance ToJson Student where
  toJson (Student name number age) = "{\n  " ++
                                     toJson name ++ "\n  " ++
                                     toJson number ++ "\n  " ++
                                     toJson age ++ "\n}"
