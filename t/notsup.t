use Test::More (tests => 4);

use Lchown qw(lchown LCHOWN_AVAILABLE);

SKIP: {
    skip "this system has lchown", 4 if LCHOWN_AVAILABLE;

    my $uid = $>;
    my $gid = $) =~ /^(\d+)/;

    ok( ! defined lchown($uid, $gid), "null lchown call failed" );
    like( $!, qr/operation not supported/i, "null lchown gave ENOTSUP" );
    
    symlink 'bar', 'foo' or die "symlink: $!";

    ok( ! defined lchown($uid, $gid, 'foo'), "valid lchown call failed" );
    like( $!, qr/operation not supported/i, "valid lchown gave ENOTSUP" );
    
    unlink 'foo' or die "unlink: $!";
}

