unit Startup;

interface

uses
  IdHTTPWebBrokerBridge,
  System.SysUtils,

  MVCFramework.Logger,
  MVCFramework.Commons,
  MVCFramework.REPLCommandsHandlerU;

type
  TStartup = class
  public
    class procedure RunServer(Port: Integer); static;
  end;

implementation

class procedure TStartup.RunServer(Port: Integer);
var
  server: TIdHTTPWebBrokerBridge;
  customHandler: TMVCCustomREPLCommandsHandler;
  command: string;
begin
  Writeln('DMVCFramework Server - Build: ' + DMVCFRAMEWORK_VERSION);

  if ParamCount >= 1 then
    command := ParamStr(1)
  else
    command := 'Start';

  customHandler := function(const Value: String; const server: TIdHTTPWebBrokerBridge; out Handled: Boolean): THandleCommandResult
    begin
      Handled := False;
      Result := THandleCommandResult.Unknown;
    end;

  server := TIdHTTPWebBrokerBridge.Create(nil);
  try
    server.DefaultPort    := Port;
    server.MaxConnections := 0;
    server.ListenQueue    := 200;

    Writeln('Digite "quit" or "exit" para finalizar o servidor');
    repeat
      if command.IsEmpty then
      begin
        Write('  ');
        ReadLn(command)
      end;

      try
        case HandleCommand(command.ToLower, server, customHandler) of
          THandleCommandResult.Continue:
            begin
              Continue;
            end;

          THandleCommandResult.Break:
            begin
              Break;
            end;

          THandleCommandResult.Unknown:
            begin
              REPLEmit('Comando desconhecido: ' + command);
            end;
        end;

      finally
        command := '';
      end;

    until False;

  finally
    server.Free;
  end;
end;

end.
