-module(hotload).
%% -export([server/1, upgrade/1]).
%%
%% server(State) ->
%%   receive
%%     update ->
%%       NewState = ?MODULE:upgrade(State),
%%       ?MODULE:server(NewState); %% Go to new module version
%%     SomeMessage ->
%%       %% do semething here
%%       server(State) %% Stay in old code version
%%   end.
%%
%% upgrade(OldState) ->
%%  %% Update and return new process state
