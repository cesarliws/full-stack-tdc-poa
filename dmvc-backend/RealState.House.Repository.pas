unit RealState.House.Repository;

interface

uses
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.Classes,

  RealState.Repository;

type
  THouseRepository = class(TDataModule)
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
    procedure DataModuleCreate(Sender: TObject);
  private
    fRepository: TRealStateRepository;
    procedure BindConnection;
  protected
    function Connection: TFDConnection;
  public
    function GetHouses: TDataSet;
    procedure SetFavorite(id: Int64; favorite: boolean);
  end;

var
  HouseRepository: THouseRepository;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure THouseRepository.BindConnection;
begin
  HousesQuery.Connection := Connection;
end;

function THouseRepository.Connection: TFDConnection;
begin
  Result := fRepository.Connection;
end;

procedure THouseRepository.DataModuleCreate(Sender: TObject);
begin
  fRepository := TRealStateRepository.Create(Self);
  BindConnection;
end;

function THouseRepository.GetHouses: TDataSet;
begin
  Result := TFDMemTable.Create(nil);
  HousesQuery.Open;
  TFDTable(Result).CopyDataSet(HousesQuery, [coStructure, coRestart, coAppend]);
end;

procedure THouseRepository.SetFavorite(id: Int64; favorite: boolean);
const
  UPDATE_FAVORITE_SQL = 'update "House" set "Favorite" = :p0 where "ID" = :p1 and "Favorite" <> :p2';
begin
  Connection.ExecSQL(UPDATE_FAVORITE_SQL, [favorite, id, favorite]);
end;

end.
