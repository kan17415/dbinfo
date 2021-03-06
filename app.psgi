use v5.14;
use Plack::Builder;
use App::DBInfo;

my $debug = ($ENV{PLACK_ENV} // '') =~ /^(development|debug)$/;

builder {
    enable_if { $debug } 'Debug';
    enable_if { $debug } 'Debug::TemplateToolkit';

    enable 'SimpleLogger';
    enable_if { $debug }  'Log::Contextual', level => 'trace';
    enable_if { !$debug } 'Log::Contextual', level => 'warn';

    App::DBInfo->new->to_app;
}
