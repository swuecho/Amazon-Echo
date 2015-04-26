requires 'perl', '5.008001';
requires 'Moose';
requires 'Plack';
requires 'JSON::XS';


on 'test' => sub {
    requires 'Test::More', '0.98';
};

