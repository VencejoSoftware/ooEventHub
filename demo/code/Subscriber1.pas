unit Subscriber1;

interface

uses
  SysUtils, StdCtrls,
  ooEventHub.Event,
  ooEventHub.Subscriber;

type
  TSubscriber1 = class sealed(TInterfacedObject, ISubscriber<String>)
  strict private
    _Edit1: TEdit;
  public
    function ID: TSubscriberID;
    procedure HandleEvent(const Event: IEvent<String>);
    constructor Create(const Edit1: TEdit);
    class function New(const Edit1: TEdit): ISubscriber<String>;
  end;

implementation

function TSubscriber1.ID: TSubscriberID;
begin
  CreateGuid(result);
end;

procedure TSubscriber1.HandleEvent(const Event: IEvent<String>);
begin
  _Edit1.Text := Event.Content;
end;

constructor TSubscriber1.Create(const Edit1: TEdit);
begin
  _Edit1 := Edit1;
end;

class function TSubscriber1.New(const Edit1: TEdit): ISubscriber<String>;
begin
  result := TSubscriber1.Create(Edit1);
end;

end.
