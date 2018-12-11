program ReadStateBackEnd;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,

  Web.ReqMulti,
  Web.WebReq,
  Web.WebBroker,

  Startup in 'Startup.pas',
  RealState.Agent.Controller in 'RealState.Agent.Controller.pas',
  RealState.Agent.Repository in 'RealState.Agent.Repository.pas' {AgentRepository: TDataModule},
  RealState.House.Controller in 'RealState.House.Controller.pas',
  RealState.House.Repository in 'RealState.House.Repository.pas' {HouseRepository: TDataModule},
  RealState.Repository in 'RealState.Repository.pas' {s: TDataModule},
  RealState.WebModule in 'RealState.WebModule.pas' {RealStateWebModule: TWebModule};

{$R *.res}


begin
  ReportMemoryLeaksOnShutdown := True;
  IsMultiThread := True;
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;

    WebRequestHandlerProc.MaxConnections := 1024;
    TStartup.RunServer(8080);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
