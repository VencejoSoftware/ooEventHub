unit MainForm;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  Subscriber1,
  Subscriber2,
  ooEventHub.Event,
  ooEventHub.Subscriber,
  ooEventHub.BroadcastHub,
  ooEventHub.BroadcastHub.Filtered;

const
  MSG1: TEventID = '{B05F679D-0603-4B97-A947-B189587F25B5}';
  MSG2: TEventID = '{C6EF7042-2646-46C1-ADAB-37F1EA6C4D2C}';

type
  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    _BroadcastHub: IBroadcastHubFiltered<String>;
  public
    constructor Create(Owner: TComponent; const BroadcastHub: IBroadcastHubFiltered<String>); reintroduce;
  end;

var
  NewMainForm: TMainForm;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TMainForm.Button1Click(Sender: TObject);
begin
  _BroadcastHub.Send(Self, TEvent<String>.New(MSG1, 'Something!'));
end;

procedure TMainForm.Button2Click(Sender: TObject);
var
  FilterCallback: TOnBroadcastFilter<String>;
begin
  FilterCallback :=
      function(const Sender: TObject; const Subscriber: ISubscriber<String>; const Event: IEvent<String>): Boolean
    begin
      Result := IsEqualGUID(Subscriber.ID, TSubscriber2._ID);
    end;
  _BroadcastHub.ChangeFilter(FilterCallback);
  _BroadcastHub.Send(Self, TEvent<String>.New(MSG1, 'Filtered!'));
  _BroadcastHub.ChangeFilter(nil);
end;

procedure TMainForm.Button3Click(Sender: TObject);
var
  NewForm: TMainForm;
begin
  NewForm := TMainForm.Create(Application, _BroadcastHub);
  _BroadcastHub.Attach(MSG2, TSubscriber1.New(Edit2));
  NewForm.Show;
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
  _BroadcastHub.Send(Self, TEvent<String>.New(MSG2, 'Value 2!'));
end;

constructor TMainForm.Create(Owner: TComponent; const BroadcastHub: IBroadcastHubFiltered<String>);
begin
  inherited Create(Owner);
  _BroadcastHub := BroadcastHub;
  _BroadcastHub.Attach(MSG1, TSubscriber1.New(Edit1));
  _BroadcastHub.Attach(MSG1, TSubscriber2.New);
end;

end.
