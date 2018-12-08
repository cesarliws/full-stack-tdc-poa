program ReadStateBackEnd;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Web.ReqMulti,
  Web.WebReq,
  Web.WebBroker,
  RealState.Controller in 'RealState.Controller.pas',
  RealState.WebModule in 'RealState.WebModule.pas' {RealStateWebModule: TWebModule},
  RealState.Repository in 'RealState.Repository.pas' {RealStateRepository: TDataModule},
  Startup in 'Startup.pas';

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
