unit RealState.House.Controller;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  JsonDataObjects;

type

  [MVCPath('/api/houses')]
  THouseController = class(TMVCController)
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure GetHouses;

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpPOST])]
    procedure SetFavorite(id: Int64);

  end;

implementation

uses
  System.StrUtils,
  System.SysUtils,
  MVCFramework.Logger,
  RealState.House.Repository;

procedure THouseController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  inherited;
end;

procedure THouseController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  inherited;
end;

procedure THouseController.GetHouses;
var
  repository: THouseRepository;
begin
  Writeln(Context.Request.PathInfo);
  repository := THouseRepository.Create(nil);
  try
    Render(repository.GetHouses);
  finally
    repository.Free;
  end;
end;

procedure THouseController.SetFavorite(id: Int64);
var
  body: TJsonObject;
  repository: THouseRepository;
begin
  Writeln(Context.Request.PathInfo + ', ' + Context.Request.Body);
  body := TJsonObject.Parse(Context.Request.Body) as TJsonObject;

  repository := THouseRepository.Create(nil);
  try
    repository.SetFavorite(id, body['favorite'].BoolValue);
  finally
    repository.Free;
  end;
end;

end.
