package Count;
use Dancer ':syntax';
use Dancer::Plugin::Database;

our $VERSION = '0.1';

get '/' => sub {
    my $count = get_count();
    template 'index', { count => $count };
};

get '/count' => sub {
    my $count = get_count();
    to_json { count => $count };
};

sub get_count {
    my $sth = database->prepare( 'select count(*) as sum from dingdan', );
    $sth->execute;
    my $count = $sth->fetchrow_arrayref->[0];
    return $count;
}

true;
