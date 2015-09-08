-module(my_server).
-export([start/2, start_link/2, call/2, cast/2, reply/2]).

%%% Public API
start(Module, InitalState) ->
  spawn(fun() -> init(Module, InitalState) end).

start_link(Module, InitalState) ->
  spawn_link(fun() -> init(Module, InitalState) end).

call(Pid, Msg) ->
  Ref = erlang:monitor(process, Pid),
  Pid ! {sync, self(), Ref, Msg},
  receive
    {Ref, Reply} ->
      erlang:demonitor(Ref, [flush]),
      Reply;
    {'DOWN', Ref, process, Pid, Reason} ->
      erlang:error(Reason)
  after 5000 ->
    erlang:error(timeout)
  end.

cast(Pid, Msg) ->
  Pid ! {acync, Msg},
  ok.

reply({Pid, Ref}, Reply) ->
  Pid ! {Ref, Reply}.

%%% Private stuff
init(Module, InitalState) ->
  loop(Module, Module:init(InitalState)).

loop(Module, State) ->
  receive
    {async, Message} ->
      loop(Module, Module:handle_cast(Message, State));
    {sync, Pid, Ref, Msg} ->
      loop(Module, Module:handle_call(Msg, Pid, Ref, State))
  end.
