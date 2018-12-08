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
begin
  var  Repository := THouseRepository.Create(nil);
  try
    Render(Repository.GetHouses);
  finally
    Repository.Free;
  end;
end;

procedure THouseController.SetFavorite(id: Int64);
begin
  Writeln('SetFavorite: ' + id.ToString + ', ' + Context.Request.Body);
  var Body := TJsonObject.Parse(Context.Request.Body) as TJsonObject;

  var
  Repository := THouseRepository.Create(nil);
  try
    Repository.SetFavorite(id, Body['favorite'].BoolValue);
  finally
    Repository.Free;
  end;
end;

end.
