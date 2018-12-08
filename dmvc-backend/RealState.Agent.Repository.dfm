object AgentRepository: TAgentRepository
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 504
  Width = 730
  object AgentQuery: TFDQuery
    SQL.Strings = (
      'SELECT'
      '  "ID",'
      '  "Name",'
      '  "Phone",'
      '  "Picture"'
      'FROM'
      '  "Agent"'
      'order by "ID"')
    Left = 96
    Top = 96
    object AgentQueryID: TLargeintField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object AgentQueryName: TWideStringField
      FieldName = 'Name'
      Origin = '"Name"'
      Size = 100
    end
    object AgentQueryPhone: TWideStringField
      FieldName = 'Phone'
      Origin = '"Phone"'
      Size = 100
    end
    object AgentQueryPicture: TWideStringField
      FieldName = 'Picture'
      Origin = '"Picture"'
      Size = 2000
    end
  end
end
