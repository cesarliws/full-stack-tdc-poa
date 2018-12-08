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
    AgentQuery: TFDQuery;
    AgentQueryID: TLargeintField;
    AgentQueryName: TWideStringField;
    AgentQueryPhone: TWideStringField;
    AgentQueryPicture: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnectionBeforeConnect(Sender: TObject);
  private
    function IsDebugMode: Boolean;
  public
    function GetHouses: TDataSet;
    procedure SetFavorite(id: Int64; favorite: boolean);
    function GetAgents: TDataSet;
  end;

var
  RealStateRepository: TRealStateRepository;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

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

{ TRealStateRepository }

function TRealStateRepository.GetAgents: TDataSet;
begin
  Result := TFDMemTable.Create(nil);
  AgentQuery.Open;
  TFDTable(Result).CopyDataSet(AgentQuery, [coStructure, coRestart, coAppend]);
end;

function TRealStateRepository.GetHouses: TDataSet;
begin
  Result := TFDMemTable.Create(nil);
  HousesQuery.Open;
  TFDTable(Result).CopyDataSet(HousesQuery, [coStructure, coRestart, coAppend]);
end;

procedure TRealStateRepository.SetFavorite(id: Int64; favorite: boolean);
const
  UPDATE_FAVORITE_SQL = 'update "House" set "Favorite" = :p0 where "ID" = :p1 and "Favorite" <> :p2';
begin
  Connection.ExecSQL(UPDATE_FAVORITE_SQL, [favorite, id, favorite]);
end;

function TRealStateRepository.IsDebugMode: Boolean;
begin
{$WARNINGS OFF}
  Result := DebugHook <> 0;
{$WARNINGS ON}
end;

end.
