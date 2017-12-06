{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to define a event message
  @created(04/12/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooEventHub.Event;

interface

uses
  SysUtils;

type
{$REGION 'documentation'}
// @abstract(Type to define a event identifier)
{$ENDREGION}
  TEventID = String;

{$REGION 'documentation'}
{
  @abstract(Object for event messages)
  @member(ID Event identifier)
  @member(Content Message content)
  @member(TimeStamp Date/time when event raised)
}
{$ENDREGION}

  IEvent<T> = interface
    ['{04104543-8BB2-41D3-85C6-0B926D5C3D07}']
    function ID: TEventID;
    function Content: T;
    function TimeStamp: TDateTime;
  end;
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IEvent))
  @member(ID @seealso(IEvent.ID))
  @member(Content @seealso(IEvent.Content))
  @member(TimeStamp @seealso(IEvent.TimeStamp))
  @member(
    Create Object constructor
    @param(ID Event identifier)
    @param(Content Message content)
  )
  @member(
    New Create a new @classname as interface
    @param(ID Event identifier)
    @param(Content Message content)
  )
}
{$ENDREGION}

  TEvent<T> = class sealed(TInterfacedObject, IEvent<T>)
  strict private
    _ID: TEventID;
    _Content: T;
    _TimeStamp: TDateTime;
  public
    function ID: TEventID;
    function Content: T;
    function TimeStamp: TDateTime;
    constructor Create(const ID: TEventID; const Content: T);
    class function New(const ID: TEventID; const Content: T): IEvent<T>;
  end;

implementation

function TEvent<T>.ID: TEventID;
begin
  Result := _ID;
end;

function TEvent<T>.Content: T;
begin
  Result := _Content;
end;

function TEvent<T>.TimeStamp: TDateTime;
begin
  Result := _TimeStamp;
end;

constructor TEvent<T>.Create(const ID: TEventID; const Content: T);
begin
  _ID := ID;
  _Content := Content;
  _TimeStamp := Now;
end;

class function TEvent<T>.New(const ID: TEventID; const Content: T): IEvent<T>;
begin
  Result := TEvent<T>.Create(ID, Content);
end;

end.
