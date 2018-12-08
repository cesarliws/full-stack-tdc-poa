unit RealState.Agent.Controller;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  JsonDataObjects;

type

  [MVCPath('/api/agents')]
  TAgentController = class(TMVCController)
  public
  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure GetAgents;
  end;

implementation

uses
  System.StrUtils,
  System.SysUtils,
  MVCFramework.Logger,
  RealState.Agent.Repository;

procedure TAgentController.GetAgents;
begin
  var repository := TAgentRepository.Create(nil);
  try
    Render(repository.GetAgents);
  finally
    repository.Free;
  end;
end;

end.
