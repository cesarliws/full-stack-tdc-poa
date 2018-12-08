unit RealState.Agent.Repository;

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
  System.Classes,
  System.SysUtils,
  RealState.Repository;

type
  TAgentRepository = class(TDataModule)
    AgentQuery: TFDQuery;
    AgentQueryID: TLargeintField;
    AgentQueryName: TWideStringField;
    AgentQueryPhone: TWideStringField;
    AgentQueryPicture: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    fRepository: TRealStateRepository;
    procedure BindConnection;
  protected
    function Connection: TFDConnection;
  public
    function GetAgents: TDataSet;
  end;

var
  AgentRepository: TAgentRepository;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TAgentRepository.BindConnection;
begin
   AgentQuery.Connection := Connection;
end;

function TAgentRepository.Connection: TFDConnection;
begin
  Result := fRepository.Connection;
end;

procedure TAgentRepository.DataModuleCreate(Sender: TObject);
begin
  fRepository := TRealStateRepository.Create(Self);
  BindConnection;
end;

function TAgentRepository.GetAgents: TDataSet;
begin
  Result := TFDMemTable.Create(nil);
  AgentQuery.Open;
  TFDTable(Result).CopyDataSet(AgentQuery, [coStructure, coRestart, coAppend]);
end;

end.
