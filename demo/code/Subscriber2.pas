unit Subscriber2;

interface

uses
  SysUtils, Dialogs,
  ooEventHub.Event,
  ooEventHub.Subscriber;

type
  TSubscriber2 = class(TInterfacedObject, ISubscriber<String>)
  const
    _ID: TGUID = '{4F219209-112E-4092-9660-650351F74886}';
  public
    function ID: TSubscriberID;
    procedure HandleEvent(const Event: IEvent<String>);
    class function New: ISubscriber<String>;
  end;

implementation

function TSubscriber2.ID: TSubscriberID;
begin
  Result := _ID;
end;

procedure TSubscriber2.HandleEvent(const Event: IEvent<String>);
begin
  ShowMessage('2 ' + Event.Content);
end;

class function TSubscriber2.New: ISubscriber<String>;
begin
  Result := TSubscriber2.Create;
end;

end.
