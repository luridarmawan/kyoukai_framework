{*******************************************************************************

                          This is Part of Kyoukai units
                        A Simple Web Framework for Pascal

See the file COPYING.LGPL.txt, included in this distribution,
for details about the copyright.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

*******************************************************************************}
unit Kyoukai.Standard.HTTPApplication;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  Kyoukai.Standard.HTTPServer,
  Kyoukai.Standard.WebRouter;

type

  TKyoukaiApp = class(TCustomApplication)
  private
    fServer: TKyCustHTTPServer;
    function ReadRouter: TKyRoutes;
    procedure WriteRouter(ARouter: TKyRoutes);
    function ReadFileRoutes: TFileRouteMap;
    procedure WriteFileRoutes(AFileRoute: TFileRouteMap);
    function ReadIsActive: boolean;
    procedure WriteToActive(AState: boolean);
    function ReadPort: word;
    procedure WritePort(APort: word);
    function ReadThreaded: boolean;
    procedure WriteThreaded(IsThreaded: boolean);
  public
    property Threaded: boolean read ReadThreaded write WriteThreaded;
    property Port: word read ReadPort write WritePort;
    property Router: TKyRoutes read ReadRouter write WriteRouter;
    property FileRoutes: TFileRouteMap read ReadFileRoutes write WriteFileRoutes;
    property Active: boolean read ReadIsActive write WriteToActive;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  KyoukaiApp: TKyoukaiApp;

implementation

function TKyoukaiApp.ReadThreaded: boolean;
begin
  Result := fServer.Threaded;
end;

procedure TKyoukaiApp.WriteThreaded(IsThreaded: boolean);
begin
  fServer.Threaded := IsThreaded;
end;

function TKyoukaiApp.ReadRouter: TKyRoutes;
begin
  Result := fServer.Router;
end;

procedure TKyoukaiApp.WriteRouter(ARouter: TKyRoutes);
begin
  fServer.Router := ARouter;
end;

function TKyoukaiApp.ReadFileRoutes: TFileRouteMap;
begin
  Result := fServer.FileRoutes;
end;

procedure TKyoukaiApp.WriteFileRoutes(AFileRoute: TFileRouteMap);
begin
  fServer.FileRoutes := AFileRoute;
end;

function TKyoukaiApp.ReadIsActive: boolean;
begin
  Result := fServer.Active;
end;

function TKyoukaiApp.ReadPort: word;
begin
  Result := fServer.Port;
end;

procedure TKyoukaiApp.WritePort(APort: word);
begin
  fServer.Port := APort;
end;

procedure TKyoukaiApp.WriteToActive(AState: boolean);
begin
  WriteLn('Registered into port: ', KyoukaiApp.Port);
  fServer.Active := AState;
end;

constructor TKyoukaiApp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fServer := TKyCustHTTPServer.Create(Self);
end;

destructor TKyoukaiApp.Destroy;
begin
  FreeAndNil(fServer);
  inherited Destroy;
end;

initialization
  Routes := TKyRoutes.Create;
  KyoukaiApp := TKyoukaiApp.Create(nil);
  KyoukaiApp.Router := Routes;

finalization
  FreeAndNil(Routes);
  FreeAndNil(KyoukaiApp);

end.

