use 5.010;
use strict;
use warnings;

use LWP::Protocol::http::SocketUnixAlt;
use Test::More 0.98;

sub test_parse_url {
    my ($url, $res, $reason) = @_;
    my ($sock_path, $uri_path) =
        LWP::Protocol::http::SocketUnixAlt::_parse_url($url);
    is_deeply({sock_path=>$sock_path, uri_path=>$uri_path}, $res, $reason);
}

# without uri_path
test_parse_url('http:rel/sock/path',
               {sock_path=>'rel/sock/path', uri_path=>'/'});
test_parse_url('http:./rel/sock/path',
               {sock_path=>'./rel/sock/path', uri_path=>'/'});
test_parse_url('http:../rel/sock/path',
               {sock_path=>'../rel/sock/path', uri_path=>'/'});
test_parse_url('http:/abs/sock/path',
               {sock_path=>'/abs/sock/path', uri_path=>'/'});

# with an empty uri_path
test_parse_url('http:rel/sock/path//',
               {sock_path=>'rel/sock/path', uri_path=>'/'});
test_parse_url('http:./rel/sock/path//',
               {sock_path=>'./rel/sock/path', uri_path=>'/'});
test_parse_url('http:../rel/sock/path//',
               {sock_path=>'../rel/sock/path', uri_path=>'/'});
test_parse_url('http:/abs/sock/path//',
               {sock_path=>'/abs/sock/path', uri_path=>'/'});

# with a non-empty uri_path
test_parse_url('http:rel/sock/path//uri/path',
               {sock_path=>'rel/sock/path', uri_path=>'/uri/path'});
test_parse_url('http:./rel/sock/path//uri/path',
               {sock_path=>'./rel/sock/path', uri_path=>'/uri/path'});
test_parse_url('http:../rel/sock/path//uri/path',
               {sock_path=>'../rel/sock/path', uri_path=>'/uri/path'});
test_parse_url('http:/abs/sock/path//uri/path',
               {sock_path=>'/abs/sock/path', uri_path=>'/uri/path'});

DONE_TESTING:
done_testing;
