object s: Ts
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 397
  Width = 510
  object Connection: TFDConnection
    Params.Strings = (
      'Database=tdc_real_state'
      'User_Name=postgres'
      'Password=postgres'
      'Server=10.0.2.2'
      'DriverID=PG')
    LoginPrompt = False
    BeforeConnect = ConnectionBeforeConnect
    Left = 128
    Top = 80
  end
end
