unit RealState.Controller;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  JsonDataObjects;

type

  [MVCPath('/api')]
  TRealStateController = class(TMVCController)
  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    [MVCPath('/houses')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;

    [MVCPath('/house/($id)')]
    [MVCHTTPMethod([httpPOST])]
    procedure SetFavorite(id: Int64);

    [MVCPath('/agents')]
    [MVCHTTPMethod([httpGET])]
    procedure GetAgents;
  end;

implementation

uses
  System.StrUtils,
  System.SysUtils,
  MVCFramework.Logger,
  RealState.Repository;

procedure TRealStateController.Index;
begin
  Render('{hello}');
end;

procedure TRealStateController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  inherited;
end;

procedure TRealStateController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  inherited;
end;

procedure TRealStateController.GetCustomers;
begin
  var repository := TRealStateRepository.Create(nil);
  try
    Render(repository.GetHouses);
  finally
    repository.Free;
  end;
end;

procedure TRealStateController.GetAgents;
begin
  var repository := TRealStateRepository.Create(nil);
  try
    Render(repository.GetAgents);
  finally
    repository.Free;
  end;
end;

procedure TRealStateController.SetFavorite(id: Int64);
begin
  Writeln('SetFavorite: ' + id.ToString + ', ' + Context.Request.Body);
  var body := TJsonObject.Parse(Context.Request.Body) as TJsonObject;

  var repository := TRealStateRepository.Create(nil);
  try
    repository.SetFavorite(id, body['favorite'].BoolValue);
  finally
    repository.Free;
  end;
end;

end.
