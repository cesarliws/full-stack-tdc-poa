unit RealState.Repository;

{.$DEFINE IS_VIRTUAL_BOX}

interface

uses
  Data.DB,
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TRepository = class(TDataModule)
    Connection: TFDConnection;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnectionBeforeConnect(Sender: TObject);
  private
    function IsDebugMode: Boolean;
    function IsVirtualBox: Boolean;
  end;

var
  Repository: TRepository;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TRepository.DataModuleDestroy(Sender: TObject);
begin
  Connection.Close;
end;

procedure TRepository.DataModuleCreate(Sender: TObject);
begin
  Connection.Open();
end;

procedure TRepository.ConnectionBeforeConnect(Sender: TObject);
begin
  if IsDebugMode and IsVirtualBox then
    Connection.Params.Values['Server'] := '10.0.2.2'
  else
    Connection.Params.Values['Server'] := '127.0.0.1';
end;

function TRepository.IsDebugMode: Boolean;
begin
{$WARNINGS OFF}
  Result := DebugHook <> 0;
{$WARNINGS ON}
end;

function TRepository.IsVirtualBox: Boolean;
begin
  Result := {$IFDEF IS_VIRTUAL_BOX}True{$ELSE}False{$ENDIF};
end;

end.
