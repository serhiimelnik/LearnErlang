-module(pool_worker).
-behaviour(gen_server).
-export([start_link/2, stop/1]).
-export([init/1, handle_call/3, handle_cast/2,
  handle_info/2, code_change/3, terminate/2]).

start_link(Task, SendTo) ->
  gen_server:start_link(?MODULE, {Task, 500, 1, SendTo} , []).

stop(Pid) ->
  gen_server:call(Pid, stop).

init({Task, Delay, Max, SendTo}) ->
  process_flag(trap_exit, true),
  {ok, {Task, Delay, Max, SendTo}, Delay}.

handle_call(_Msg, _From, State) ->
  {noreply, State}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(timeout, {Task, Delay, Max, SendTo}) ->
  SendTo ! {self(), Task},
  if Max =< 1 ->
      timer:sleep(500),
      io:format("~p~n", [Task]),
      {stop, normal, {Task, Delay, 0, SendTo}}
  end;
handle_info(_Msg, State) ->
  {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

terminate(_Reason, _State) -> ok.
