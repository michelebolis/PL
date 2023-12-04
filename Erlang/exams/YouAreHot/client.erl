-module(client).
-export([convert/5]).
convert(from, FromScale, to, ToScale, T) -> client ! {convert, FromScale, ToScale, T}.