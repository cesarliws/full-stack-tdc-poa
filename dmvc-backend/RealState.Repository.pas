unit RealState.Repository;

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
  TRealStateRepository = class(TDataModule)
    AgentQuery: TFDQuery;
    AgentQueryID: TLargeintField;
    AgentQueryName: TWideStringField;
    AgentQueryPhone: TWideStringField;
    AgentQueryPicture: TWideStringField;
    Connection: TFDConnection;
    HousesQuery: TFDQuery;
    HousesQueryID: TLargeintField;
    HousesQueryFavorite: TBooleanField;
    HousesQueryAddress: TWideStringField;
    HousesQueryCity: TWideStringField;
    HousesQueryState: TWideStringField;
    HousesQueryZipCode: TWideStringField;
    HousesQueryBeds: TIntegerField;
    HousesQueryBaths: TIntegerField;
    HousesQueryHouseSize: TIntegerField;
    HousesQueryLotSize: TFMTBCDField;
    HousesQueryPrice: TCurrencyField;
    HousesQueryCoordinates: TWideStringField;
    HousesQueryFeatures: TWideMemoField;
    HousesQueryYearBuilt: TIntegerField;
    HousesQueryType: TSmallintField;
    HousesQueryStatus: TSmallintField;
    HousesQueryImage: TWideStringField;
    HousesQueryAgentId: TLargeintField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnectionBeforeConnect(Sender: TObject);
  private
    function IsDebugMode: Boolean;
  end;

var
  RealStateRepository: TRealStateRepository;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TRealStateRepository.DataModuleDestroy(Sender: TObject);
begin
  Connection.Close;
end;

procedure TRealStateRepository.DataModuleCreate(Sender: TObject);
begin
  Connection.Open();
end;

procedure TRealStateRepository.ConnectionBeforeConnect(Sender: TObject);
begin
  if IsDebugMode then
    Connection.Params.Values['Server'] := '10.0.2.2'
  else
    Connection.Params.Values['Server'] := '127.0.0.1';
end;

function TRealStateRepository.IsDebugMode: Boolean;
begin
{$WARNINGS OFF}
  Result := DebugHook <> 0;
{$WARNINGS ON}
end;

end.
