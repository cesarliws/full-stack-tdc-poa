unit RealState.WebModule;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,

  MVCFramework;

type
  TRealStateWebModule = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    FMVC: TMVCEngine;
    procedure RegisterControllers;
    procedure RegisterMiddlewares;
  end;

var
  WebModuleClass: TComponentClass = TRealStateWebModule;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  MVCFramework.Commons,
  MVCFramework.Middleware.Compression,
  MVCFramework.Middleware.CORS,
  RealState.Agent.Controller,
  RealState.House.Controller;

procedure TRealStateWebModule.RegisterControllers;
begin
  FMVC.AddController(TAgentController);
  FMVC.AddController(THouseController);
end;

procedure TRealStateWebModule.RegisterMiddlewares;
begin
  // To enable compression (deflate, gzip) just add this middleware as the last one
  FMVC.AddMiddleware(TMVCCompressionMiddleware.Create);
  FMVC.AddMiddleware(TCORSMiddleware.Create);
end;

procedure TRealStateWebModule.WebModuleCreate(Sender: TObject);
begin
  FMVC := TMVCEngine.Create(Self,
    procedure(Config: TMVCConfig)
    begin
      // enable static files
      Config[TMVCConfigKey.DocumentRoot] := TPath.Combine(ExtractFilePath(GetModuleName(HInstance)), 'www');

      // session timeout (0 means session cookie)
      Config[TMVCConfigKey.SessionTimeout] := '0';

      // default content-type
      Config[TMVCConfigKey.DefaultContentType] := TMVCConstants.DEFAULT_CONTENT_TYPE;

      // default content charset
      Config[TMVCConfigKey.DefaultContentCharset] := TMVCConstants.DEFAULT_CONTENT_CHARSET;

      // unhandled actions are permitted?
      Config[TMVCConfigKey.AllowUnhandledAction] := 'false';

      // default view file extension
      Config[TMVCConfigKey.DefaultViewFileExtension] := 'html';

      // view path
      Config[TMVCConfigKey.ViewPath] := 'templates';

      // Max Record Count for automatic Entities CRUD
      Config[TMVCConfigKey.MaxEntitiesRecordCount] := '20';

      // Enable Server Signature in response
      Config[TMVCConfigKey.ExposeServerSignature] := 'true';

      // Define a default URL for requests that don't map to a route or a file (useful for client side web app)
      Config[TMVCConfigKey.FallbackResource] := 'index.html';
    end);

  RegisterControllers;
  RegisterMiddlewares;
end;

procedure TRealStateWebModule.WebModuleDestroy(Sender: TObject);
begin
  FMVC.Free;
end;

end.
