object HouseRepository: THouseRepository
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 513
  Width = 751
  object HousesQuery: TFDQuery
    SQL.Strings = (
      'SELECT '
      '  h."ID", '
      '  h."Favorite", '
      '  h."Address", '
      '  h."City", '
      '  h."State", '
      '  h."ZipCode", '
      '  h."Beds", '
      '  h."Baths", '
      '  h."HouseSize", '
      '  h."LotSize", '
      '  h."Price", '
      '  h."Coordinates", '
      '  h."Features", '
      '  h."YearBuilt", '
      '  h."Type", '
      '  h."Status", '
      '  h."Image", '
      '  ah."AgentId"'
      'from "House" h '
      'LEFT join "AgentHouse" ah '
      '  on h."ID"  = ah."HouseId"  '
      'order by h."ID"')
    Left = 96
    Top = 72
    object HousesQueryID: TLargeintField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object HousesQueryFavorite: TBooleanField
      FieldName = 'Favorite'
      Origin = '"Favorite"'
    end
    object HousesQueryAddress: TWideStringField
      FieldName = 'Address'
      Origin = '"Address"'
      Size = 100
    end
    object HousesQueryCity: TWideStringField
      FieldName = 'City'
      Origin = '"City"'
      Size = 100
    end
    object HousesQueryState: TWideStringField
      FieldName = 'State'
      Origin = '"State"'
      Size = 2
    end
    object HousesQueryZipCode: TWideStringField
      FieldName = 'ZipCode'
      Origin = '"ZipCode"'
      Size = 10
    end
    object HousesQueryBeds: TIntegerField
      FieldName = 'Beds'
      Origin = '"Beds"'
    end
    object HousesQueryBaths: TIntegerField
      FieldName = 'Baths'
      Origin = '"Baths"'
    end
    object HousesQueryHouseSize: TIntegerField
      FieldName = 'HouseSize'
      Origin = '"HouseSize"'
    end
    object HousesQueryLotSize: TFMTBCDField
      FieldName = 'LotSize'
      Origin = '"LotSize"'
      Precision = 18
      Size = 2
    end
    object HousesQueryPrice: TCurrencyField
      FieldName = 'Price'
      Origin = '"Price"'
    end
    object HousesQueryCoordinates: TWideStringField
      FieldName = 'Coordinates'
      Origin = '"Coordinates"'
      Size = 100
    end
    object HousesQueryFeatures: TWideMemoField
      FieldName = 'Features'
      Origin = '"Features"'
      BlobType = ftWideMemo
    end
    object HousesQueryYearBuilt: TIntegerField
      FieldName = 'YearBuilt'
      Origin = '"YearBuilt"'
    end
    object HousesQueryType: TSmallintField
      FieldName = 'Type'
      Origin = '"Type"'
    end
    object HousesQueryStatus: TSmallintField
      FieldName = 'Status'
      Origin = '"Status"'
    end
    object HousesQueryImage: TWideStringField
      FieldName = 'Image'
      Origin = '"Image"'
      Size = 2000
    end
    object HousesQueryAgentId: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'AgentId'
      Origin = '"AgentId"'
    end
  end
end
